CREATE TABLE IF NOT EXISTS joined(
as_of_year TEXT,
respondent_id TEXT,
agency_name TEXT,
agency_abbr TEXT,
agency_code TEXT,
loan_type_name TEXT,
loan_type TEXT,
property_type_name TEXT,
property_type TEXT,
loan_purpose_name TEXT,
loan_purpose TEXT,
owner_occupancy_name TEXT,
owner_occupancy TEXT,
loan_amount_000s TEXT,
preapproval_name TEXT,
preapproval TEXT,
action_taken_name TEXT,
action_taken TEXT,
msamd_name TEXT,
msamd TEXT,
state_name TEXT,
state_abbr TEXT,
state_code TEXT,
county_name TEXT,
county_code TEXT,
census_tract_number TEXT,
applicant_ethnicity_name TEXT,
applicant_ethnicity TEXT,
co_applicant_ethnicity_name TEXT,
co_applicant_ethnicity TEXT,
applicant_race_name_1 TEXT,
applicant_race_1 TEXT,
applicant_race_name_2 TEXT,
applicant_race_2 TEXT,
applicant_race_name_3 TEXT,
applicant_race_3 TEXT,
applicant_race_name_4 TEXT,
applicant_race_4 TEXT,
applicant_race_name_5 TEXT,
applicant_race_5 TEXT,
co_applicant_race_name_1 TEXT,
co_applicant_race_1 TEXT,
co_applicant_race_name_2 TEXT,
co_applicant_race_2 TEXT,
co_applicant_race_name_3 TEXT,
co_applicant_race_3 TEXT,
co_applicant_race_name_4 TEXT,
co_applicant_race_4 TEXT,
co_applicant_race_name_5 TEXT,
co_applicant_race_5 TEXT,
applicant_sex_name TEXT,
applicant_sex TEXT,
co_applicant_sex_name TEXT,
co_applicant_sex TEXT,
applicant_income_000s TEXT,
purchaser_type_name TEXT,
purchaser_type TEXT,
denial_reason_name_1 TEXT,
denial_reason_1 TEXT,
denial_reason_name_2 TEXT,
denial_reason_2 TEXT,
denial_reason_name_3 TEXT,
denial_reason_3 TEXT,
rate_spread TEXT,
hoepa_status_name TEXT,
hoepa_status TEXT,
lien_status_name TEXT,
lien_status TEXT,
edit_status_name TEXT,
edit_status TEXT,
sequence_number TEXT,
population TEXT,
minority_population TEXT,
hud_median_family_income TEXT,
tract_to_msamd_income TEXT,
number_of_owner_occupied_units TEXT,
number_of_1_to_4_family_units TEXT,
applications_date_indicator TEXT,
id TEXT PRIMARY KEY
);

INSERT INTO joined(
  as_of_year,
  respondent_id,
  agency_name,
  agency_abbr,
  agency_code,
  loan_type_name,
  loan_type,
  property_type_name,
  property_type,
  loan_purpose_name,
  loan_purpose,
  owner_occupancy_name,
  owner_occupancy,
  loan_amount_000s,
  preapproval_name,
  preapproval,
  action_taken_name,
  action_taken,
  msamd_name,
  msamd,
  state_name,
  state_abbr,
  state_code,
  county_name,
  county_code,
  census_tract_number,
  applicant_ethnicity_name,
  applicant_ethnicity,
  co_applicant_ethnicity_name,
  co_applicant_ethnicity,
  applicant_race_name_1,
  applicant_race_1,
  applicant_race_name_2,
  applicant_race_2,
  applicant_race_name_3,
  applicant_race_3,
  applicant_race_name_4,
  applicant_race_4,
  applicant_race_name_5,
  applicant_race_5,
  co_applicant_race_name_1,
  co_applicant_race_1,
  co_applicant_race_name_2,
  co_applicant_race_2,
  co_applicant_race_name_3,
  co_applicant_race_3,
  co_applicant_race_name_4,
  co_applicant_race_4,
  co_applicant_race_name_5,
  co_applicant_race_5,
  applicant_sex_name,
  applicant_sex,
  co_applicant_sex_name,
  co_applicant_sex,
  applicant_income_000s,
  purchaser_type_name,
  purchaser_type,
  denial_reason_name_1,
  denial_reason_1,
  denial_reason_name_2,
  denial_reason_2,
  denial_reason_name_3,
  denial_reason_3,
  rate_spread,
  hoepa_status_name,
  hoepa_status,
  lien_status_name,
  lien_status,
  edit_status_name,
  edit_status,
  sequence_number,
  population,
  minority_population,
  hud_median_family_income,
  tract_to_msamd_income,
  number_of_owner_occupied_units,
  number_of_1_to_4_family_units,
  applications_date_indicator,
  id
)
  SELECT
    la.as_of_year,
    la.respondent_id,
    ag.agency_name,
    ag.agency_abbr,
    la.agency_code,
    lt.loan_type_name,
    la.loan_type,
    pt.property_type_names AS property_type_name,
    p.property_type,
    lp.loan_purpose_name,
    la.loan_purpose,
    oo.owner_occupancy_name,
    p.owner_occupancy,
    la.loan_amount_000s,
    pr.preapproval_name,
    la.preapproval,
    at.action_taken_name,
    la.action_taken,
    ms.msamd_name,
    l.msamd,
    st.state_name,
    st.state_abbr,
    l.state_code,
    c.county_name,
    l.county_code,
    l.census_tract_number,
    ae.ethnicity_name AS applicant_ethnicity_name,
    a.applicant_ethnicity,
    ce.ethnicity_name AS co_applicant_ethnicity_name,
    ca.co_applicant_ethnicity,

    -- applicant races
    ra1.race_name AS applicant_race_name_1,
    ar1.race AS applicant_race_1,
    ra2.race_name AS applicant_race_name_2,
    ar2.race AS applicant_race_2,
    ra3.race_name AS applicant_race_name_3,
    ar3.race AS applicant_race_3,
    ra4.race_name AS applicant_race_name_4,
    ar4.race AS applicant_race_4,
    ra5.race_name AS applicant_race_name_5,
    ar5.race AS applicant_race_5,

    -- co-applicant races
    ra6.race_name AS co_applicant_race_name_1,
    cr1.race AS co_applicant_race_1,
    ra7.race_name AS co_applicant_race_name_2,
    cr2.race AS co_applicant_race_2,
    ra8.race_name AS co_applicant_race_name_3,
    cr3.race AS co_applicant_race_3,
    ra9.race_name AS co_applicant_race_name_4,
    cr4.race AS co_applicant_race_4,
    ra10.race_name AS co_applicant_race_name_5,
    cr5.race AS co_applicant_race_5,

    -- sex
    sa.sex_name AS applicant_sex_name,
    a.applicant_sex,
    sc.sex_name AS co_applicant_sex_name,
    ca.co_applicant_sex,
    a.applicant_income_000s,

    -- purchaser and denial
    pt2.purchaser_type_name,
    la.purchaser_type,
    dr1.denial_reason_name AS denial_reason_name_1,
    d1.denial_reason AS denial_reason_1,
    dr2.denial_reason_name AS denial_reason_name_2,
    d2.denial_reason AS denial_reason_2,
    dr3.denial_reason_name AS denial_reason_name_3,
    d3.denial_reason AS denial_reason_3,

    -- rest
    la.rate_spread,
    hs.hoepa_status_name,
    la.hoepa_status,
    ls.lien_status_name,
    la.lien_status,
    '' AS edit_status_name,
    la.edit_status,
    la.sequence_number,
    l.population,
    l.minority_population,
    l.hud_median_family_income,
    l.tract_to_msamd_income,
    l.number_of_owner_occupied_units,
    l.number_of_1_to_4_family_units,
    la.applications_date_indicator,
    la.application_id AS id
  FROM loanapplication la
    JOIN agencies ag ON la.agency_code = ag.agency_code
    JOIN loantypes lt ON la.loan_type = lt.loan_type
    JOIN property p ON la.property_id = p.property_id
    JOIN propertytypes pt ON p.property_type = pt.property_type
    JOIN owneroccupancies oo ON p.owner_occupancy = oo.owner_occupancy
    JOIN loanpurposes lp ON la.loan_purpose = lp.loan_purpose
    JOIN preapprovals pr ON la.preapproval = pr.preapproval
    JOIN actionstaken at ON la.action_taken = at.action_taken
    JOIN location l ON p.location_id = l.location_id
    LEFT JOIN msamds ms ON l.msamd = ms.msamd
    JOIN states st ON l.state_code = st.state_code
    JOIN counties c ON l.county_code = c.county_code
    JOIN applicant a ON la.applicant_id = a.applicant_id
    JOIN coapplicant ca ON la.co_applicant_id = ca.co_applicant_id
    JOIN ethnicities ae ON a.applicant_ethnicity = ae.ethnicity
    JOIN ethnicities ce ON ca.co_applicant_ethnicity = ce.ethnicity
    JOIN sexes sa ON a.applicant_sex = sa.sex
    JOIN sexes sc ON ca.co_applicant_sex = sc.sex
    LEFT JOIN applicantRaces ar1 ON a.applicant_id = ar1.applicant_id AND ar1.race_number = 1
    LEFT JOIN races ra1 ON ar1.race = ra1.race
    LEFT JOIN applicantRaces ar2 ON a.applicant_id = ar2.applicant_id AND ar2.race_number = 2
    LEFT JOIN races ra2 ON ar2.race = ra2.race
    LEFT JOIN applicantRaces ar3 ON a.applicant_id = ar3.applicant_id AND ar3.race_number = 3
    LEFT JOIN races ra3 ON ar3.race = ra3.race
    LEFT JOIN applicantRaces ar4 ON a.applicant_id = ar4.applicant_id AND ar4.race_number = 4
    LEFT JOIN races ra4 ON ar4.race = ra4.race
    LEFT JOIN applicantRaces ar5 ON a.applicant_id = ar5.applicant_id AND ar5.race_number = 5
    LEFT JOIN races ra5 ON ar5.race = ra5.race
    LEFT JOIN coapplicantRaces cr1 ON ca.co_applicant_id = cr1.co_applicant_id AND cr1.race_number = 1
    LEFT JOIN races ra6 ON cr1.race = ra6.race
    LEFT JOIN coapplicantRaces cr2 ON ca.co_applicant_id = cr2.co_applicant_id AND cr2.race_number = 2
    LEFT JOIN races ra7 ON cr2.race = ra7.race
    LEFT JOIN coapplicantRaces cr3 ON ca.co_applicant_id = cr3.co_applicant_id AND cr3.race_number = 3
    LEFT JOIN races ra8 ON cr3.race = ra8.race
    LEFT JOIN coapplicantRaces cr4 ON ca.co_applicant_id = cr4.co_applicant_id AND cr4.race_number = 4
    LEFT JOIN races ra9 ON cr4.race = ra9.race
    LEFT JOIN coapplicantRaces cr5 ON ca.co_applicant_id = cr5.co_applicant_id AND cr5.race_number = 5
    LEFT JOIN races ra10 ON cr5.race = ra10.race
    JOIN purchasertypes pt2 ON la.purchaser_type = pt2.purchaser_type
    LEFT JOIN applicationdenialreasons d1 ON la.application_id = d1.application_id AND d1.denial_number = 1
    LEFT JOIN denialreasons dr1 ON d1.denial_reason = dr1.denial_reason
    LEFT JOIN applicationdenialreasons d2 ON la.application_id = d2.application_id AND d2.denial_number = 2
    LEFT JOIN denialreasons dr2 ON d2.denial_reason = dr2.denial_reason
    LEFT JOIN applicationdenialreasons d3 ON la.application_id = d3.application_id AND d3.denial_number = 3
    LEFT JOIN denialreasons dr3 ON d3.denial_reason = dr3.denial_reason
    JOIN hoepastatuses hs ON la.hoepa_status = hs.hoepa_status
    JOIN lienstatuses ls ON la.lien_status = ls.lien_status
