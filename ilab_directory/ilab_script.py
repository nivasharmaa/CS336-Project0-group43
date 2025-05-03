import sys
import psycopg2

def run_query(query):
    conn = psycopg2.connect(
        dbname='rfp46',  # user specific database, your netID
        user='rfp46',    # usename, just netID
        password='Prophet622#',  # your password for ilab
        host='postgres.cs.rutgers.edu' # the host psql database
    )
    cur = conn.cursor()
    cur.execute(query)
    rows = cur.fetchall()
    colnames = [desc[0] for desc in cur.description]

    # table formatting
    print("\t".join(colnames))
    for row in rows:
        print("\t".join(str(col) for col in row))

    cur.close()
    conn.close()

if __name__ == "__main__":
    if len(sys.argv) > 1:
        query = sys.argv[1]
    else:
        query = sys.stdin.read()
    run_query(query)

