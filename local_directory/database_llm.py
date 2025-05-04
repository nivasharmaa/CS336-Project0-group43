import getpass
import shlex
import sys
from llama_cpp import Llama
import paramiko

# 1. Load the local LLM model
llm = Llama(model_path="Phi-3.5-mini-instruct-Q4_K_M.gguf", n_ctx = 5000, verbose = False)

# 2. Load the schema from file
with open("create_schema.sql", "r") as f:
    schema = f.read()

# Explicitly state context window
schema = schema[:5000]  

# 3. Construct the full prompt
def build_prompt(question):
    return (
        "Write an SQL SELECT query in response to the following schema and user question.\n"
        "Schema:\n" + schema + "\n"
        "Question:\n" + question + "\nSQL:"
    )

# 4. Extract the SQL query from LLM output 
def extract_query(response_text):
    lines = response_text.strip().splitlines()
    in_sql = False
    query_lines = []
    for line in lines:
        if line.strip().lower().startswith("select"):
            in_sql = True
        if in_sql:
            query_lines.append(line)
            if ";" in line:
                break
    return " ".join(query_lines).strip("; ") if query_lines else None

# 5. Send the SQL query to ILAB script using SSH
def run_remote_query(query, ssh_host, ssh_user, ssh_password):
    
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    try:
        ssh.connect(ssh_host, username=ssh_user, password=ssh_password)
        escaped_query = shlex.quote(query)
        cmd = (
            f"python3 /common/home/rb1395/Documents/CS336-Project0-group43/ilab_directory/ilab_script.py {escaped_query}"
        )
        stdin, stdout, stderr = ssh.exec_command(cmd)
        
        # Print results
        output = stdout.read().decode().strip()
        errors = stderr.read().decode().strip()
        
        if output:
            print("\n Query Results:\n" + output)
        if errors:
            print("\n Remote Error:\n" + errors)

    except Exception as e:
        print(f" SSH or query error: {e}")
    finally:
        ssh.close()

# 6. Interactive Q&A loop
def main():
    ssh_host = "iLab.cs.rutgers.edu"
    ssh_user = input("Enter your iLab username: ")
    ssh_password = getpass.getpass(f"Enter password for {ssh_user}@{ssh_host}: ")

    while True:
        user_question = input("\nAsk a question about the database (or type 'exit'): ")
        if user_question.strip().lower() == "exit":
            print("Exiting.")
            break

        prompt = build_prompt(user_question)
        llm_output = llm(prompt, max_tokens=200)
        response = llm_output["choices"][0]["text"]

        sql_query = extract_query(response)
        if sql_query:
            print("\nRunning query:", sql_query)
            run_remote_query(sql_query, ssh_host, ssh_user, ssh_password)
        else:
            print("Could not extract a valid SQL query. Try rephrasing your question.")

if __name__ == "__main__":
    main()

