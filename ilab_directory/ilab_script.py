import sys
import psycopg2
import pandas as pd

def run_query(query):
    conn = psycopg2.connect(
        dbname='####',  # user specific database, your netID
        user='####',    # usename, just netID
        password='####',  # your password for ilab
        host='postgres.cs.rutgers.edu' # the host psql database
    )
    cur = conn.cursor()
    cur.execute(query)
    rows = cur.fetchall()
    colnames = [desc[0] for desc in cur.description]
    df = pd.DataFrame(rows, columns = colnames)
    print(df.to_markdown(index = False))

    cur.close()
    conn.close()

if __name__ == "__main__":
    if len(sys.argv) > 1:
        query = sys.argv[1]
    else:
        query = sys.stdin.read()
    run_query(query)

