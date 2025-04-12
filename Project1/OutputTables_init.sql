SELECT 
  CONCAT('\echo ', tablename, '\nSELECT * FROM ', tablename,' LIMIT 5;') 
FROM 
  pg_tables
WHERE
  schemaname = 'rs2299'
