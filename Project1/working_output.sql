  SELECT la.application_id, ag.agency_name, lt.loan_type_name
  FROM loanapplication la
  LEFT JOIN agencies ag ON la.agency_code = ag.agency_code
  LEFT JOIN loantypes lt ON la.loan_type = lt.loan_type
  LIMIT 5
