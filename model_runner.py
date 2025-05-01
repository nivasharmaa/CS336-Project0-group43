from llama_cpp import Llama

# Load the model
llm = Llama(
    model_path="./model.gguf",  # Path to the model file
    n_ctx=2048,             # Context length
)


# Generate a response
output = llm("give one word anwer What is the capital of France?", max_tokens=200, echo=False, stop=["Q:", "\n"])   

print(output["choices"][0]["text"])
