# CS336-Project0-group43

0) 
Lily Del Pilar - lqd2\
Roman Perry - rfp46\
Niva Sharma - nas315\
Rishabh Sheth - rs2299


1)
There are no known issues with our code.


2)
We did not collaborate with anyone outside of our group.
Some resources we consulted were PostgreSQL documentation via Google Searches and an informational tutorial to PostgreSQL.
We used these resources to better understand how to navigate PostgreSQL, effectively interface with its interactive terminal, and write out script to upload SQL data.
We used 'Interactive Terminal', 'Postgres Starter Tutorial', and 'Privileges' to learn useful psql terminal commands and share our table with all members of the group.
Some commands we learned include '\l' to list databases, '\dt' to list tables, and '\o' to output query results to a file. \
We used 'Create Table Command' and 'Copy Command' in our SQL script to create a table with all of the columns we needed and copy data into if from our .csv file.
Additionally, for the ER diagram, we followed relational database best practices to structure entities based on real-world relationships, using only attributes from the dataset without additions. Crow’s Foot notation was used to define 1:1, 1:0 or 1, and M:1 relationships, with Loan_Application as the central entity linking to Applicant, Co_Applicant, Loan_Type, Agency, Property, Geographic_Location, and Denial_Reasons.
Using these resources we were able to effectively collaborate to complete the assignment.

Links:\
[Interactive Terminal](https://www.postgresql.org/docs/current/app-psql.html)\
[Copy Command](https://www.postgresql.org/docs/17/sql-copy.html)\
[Create Table Command](https://www.postgresql.org/docs/17/sql-createtable.html)\
[Postgres Starter Tutorial](https://hasura.io/blog/top-psql-commands-and-flags-you-need-to-know-postgresql)\
[Privileges](https://www.postgresql.org/docs/current/ddl-priv.html)


3)
We uncovered some useful insights by inspecting the data in the table. We noticed that certain column names had identical prefixes, indicating a significant relationship between the columns. We also noticed functional dependencies such as state_name, state_abbr, and state_code.


4) 
A problem we faced developing for this project is nagivating PostgreSQL and giving everyone proper access to the database table.
We spent time ensuring everyone had access to the database and the table we were using, as well as becoming more familiar with navigating through PostgreSQL.
In total our team spend approximately 8-10 hours on this project combined, including learning PostgreSQL, double-checking each other's work, and revising our solutions.
