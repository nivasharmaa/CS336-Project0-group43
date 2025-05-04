# CS336-Project2-group43

1) Team Member & Contributions:
   
   Rohit Bhagat - rb1395
   - Configured and tested Python environment; managed dependencies in `requirements.txt`
   - Implemented basic error handling in `database_llm.py` and stub scripts
   - Contributed to SSH key and permissions setup on ILAB
   
   Roman Perry - rfp46
   - Lead developer of the ILAB stub script (`ilab_script.py`) and SSH tunnel setup
   - Designed and implemented the schema loader scripts (`Preliminary.sql`, `create_schema.sql`)
   - Curated and normalized the database schema; performed data validation and ensured seamless command-line integration
     
   Niva Sharma - nas315
   - Drafted and organized the README and usage documentation
   - Assisted with prompt engineering and error handling logic
     
   Rishabh Sheth - rs2299
   - Generated sample queries and validated their results against the schema
   - Performed end-to-end testing of the full workflow and created a demo video showcasing queries
   - Captured and organized prompt–response transcripts


2) We encountered multiple challenges, such as initially managing the foreign key constraints and the referential integretity when attempting to limit the inserts to 500 rows per table. Additionally using the local LLM through llama-cpp revealed the limitations of our LLM model, as during queries the LLM would make up tables and columns that did not exist, which was mainly due to our initial small context window size, but also how we were asking the questions. There were also difficulties with the SSH to the Ilab server involving the pandas import which was eventually just removed altogether. Furthermore translating questions into SQL involved a deeper understanding of the schema, as this was integral for getting the LLM to respond with the appropriate queries, rather than it attempting to do something that wasn't possible like making its own table or column to join relations.

3) One of the most interesting things we found about this project was how the LLM can interpret normal human questions and convert them into SQL queries. We also found it fascinating that the LLM was extremely dependent on the size of the context window in order to answer the query correctly. The combination of natural language processing, SQL, remote scripting, and schema design made this project feel practical and an actual application of our knowledge. 

4) Yes
