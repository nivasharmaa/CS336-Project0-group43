CREATE TABLE IF NOT EXISTS Agencies(
agency_code INTEGER PRIMARY KEY, 
agency_name TEXT NOT NULL, 
agency_abbr TEXT NOT NULL	
);

CREATE TABLE IF NOT EXISTS LoanTypes(
loan_type INTEGER PRIMARY KEY, 
loan_type_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS PropertyTypes(
property_type INTEGER PRIMARY KEY,
property_type_names TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS LoanPurposes(
loan_purpose INTEGER PRIMARY KEY,
loan_purpose_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS OwnerOccupancies(
owner_occupancy INTEGER PRIMARY KEY,
owner_occupancy_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Preapprovals(
preapproval INTEGER PRIMARY KEY,
preapproval_name TEXT NOT NULL 
);

CREATE TABLE IF NOT EXISTS ActionsTaken(
action_taken INTEGER PRIMARY KEY,
action_taken_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Msamds(
msamd INTEGER PRIMARY KEY,
msamd_name TEXT
);

CREATE TABLE IF NOT EXISTS States(
state_code INTEGER PRIMARY KEY,
state_name TEXT NOT NULL,
state_abbr TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Counties(
county_code INTEGER PRIMARY KEY,
county_name TEXT
);

CREATE TABLE IF NOT EXISTS Ethnicities(
ethnicity INTEGER PRIMARY KEY,
ethnicity_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Races(
race INTEGER PRIMARY KEY,
race_name TEXT
);

CREATE TABLE IF NOT EXISTS Sexes(
sex INTEGER PRIMARY KEY,
sex_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS PurchaserTypes(
purchaser_type INTEGER PRIMARY KEY,
purchaser_type_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS DenialReasons(
denial_reason INTEGER PRIMARY KEY,
denial_reason_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS HoepaStatuses(
hoepa_status INTEGER PRIMARY KEY,
hoepa_status_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS LienStatuses(
lien_status INTEGER PRIMARY KEY,
lien_status_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS EditStatuses(
edit_status INTEGER PRIMARY KEY,
edit_status_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Applicant(
applicant_id INTEGER PRIMARY KEY, 
applicant_ethnicity INTEGER REFERENCES Ethnicities, 
applicant_sex INTEGER REFERENCES Sexes, 
applicant_income_000s INTEGER
);

CREATE TABLE IF NOT EXISTS Coapplicant(
co_applicant_id INTEGER PRIMARY KEY, 
co_applicant_ethnicity INTEGER REFERENCES Ethnicities, 
co_applicant_sex INTEGER REFERENCES Sexes
);

CREATE TABLE IF NOT EXISTS Location(
location_id SERIAL PRIMARY KEY, 
msamd INTEGER REFERENCES Msamds, 
state_code INTEGER REFERENCES States, 
county_code INTEGER REFERENCES Counties, 
census_tract_number DOUBLE PRECISION, 
population INTEGER, 
minority_population DOUBLE PRECISION, 
hud_median_family_income INTEGER, 
tract_to_msamd_income DOUBLE PRECISION, 
number_of_owner_occupied_units INTEGER, 
number_of_1_to_4_family_units INTEGER,
UNIQUE (
    msamd, state_code, county_code, census_tract_number, population,
    minority_population, hud_median_family_income, tract_to_msamd_income,
    number_of_owner_occupied_units, number_of_1_to_4_family_units
)
);

CREATE TABLE IF NOT EXISTS Property(
property_id INTEGER PRIMARY KEY,
property_type INTEGER REFERENCES PropertyTypes,
owner_occupancy INTEGER REFERENCES OwnerOccupancies,
location_id INTEGER REFERENCES Location
);

CREATE TABLE IF NOT EXISTS ApplicantRaces(
applicant_id INTEGER REFERENCES Applicant,
race INTEGER REFERENCES Races,
race_number INTEGER
);

CREATE TABLE IF NOT EXISTS CoApplicantRaces(
co_applicant_id INTEGER REFERENCES Coapplicant,
race INTEGER REFERENCES Races,
race_number INTEGER
);

CREATE TABLE IF NOT EXISTS LoanApplication(
application_id INTEGER PRIMARY KEY,
applicant_id INTEGER REFERENCES Applicant, 
co_applicant_id INTEGER REFERENCES CoApplicant,
as_of_year INTEGER,
respondent_id TEXT,
agency_code INTEGER REFERENCES Agencies,
loan_type INTEGER REFERENCES LoanTypes,
property_id INTEGER REFERENCES Property,
loan_purpose INTEGER REFERENCES LoanPurposes,
loan_amount_000s INTEGER,
preapproval INTEGER REFERENCES Preapprovals,
action_taken INTEGER REFERENCES ActionsTaken, 
purchaser_type INTEGER REFERENCES PurchaserTypes,
rate_spread TEXT,
hoepa_status INTEGER REFERENCES HoepaStatuses, 
lien_status INTEGER REFERENCES LienStatuses,
edit_status INTEGER REFERENCES EditStatuses,
sequence_number TEXT,
applications_date_indicator TEXT
);

CREATE TABLE IF NOT EXISTS ApplicationDenialReasons(
application_id INTEGER REFERENCES LoanApplication, 
denial_reason  INTEGER REFERENCES DenialReasons,
denial_number INTEGER,
PRIMARY KEY(application_id, denial_number)
);


INSERT INTO Agencies (agency_code, agency_name, agency_abbr)
SELECT DISTINCT agency_code, agency_name, agency_abbr FROM preliminary;

INSERT INTO LoanTypes (loan_type, loan_type_name)
SELECT DISTINCT loan_type, loan_type_name FROM preliminary;

INSERT INTO PropertyTypes(property_type, property_type_names)
SELECT DISTINCT property_type, property_type_name FROM preliminary;

INSERT INTO LoanPurposes(loan_purpose, loan_purpose_name)
SELECT DISTINCT loan_purpose, loan_purpose_name FROM preliminary;

INSERT INTO OwnerOccupancies(owner_occupancy, owner_occupancy_name)
SELECT DISTINCT owner_occupancy, owner_occupancy_name FROM preliminary;

INSERT INTO Preapprovals(preapproval, preapproval_name)
SELECT DISTINCT preapproval, preapproval_name FROM preliminary;

INSERT INTO ActionsTaken(action_taken, action_taken_name)
SELECT DISTINCT action_taken, action_taken_name FROM preliminary;

INSERT INTO Msamds(msamd, msamd_name)
SELECT DISTINCT msamd, msamd_name FROM preliminary WHERE msamd IS NOT NULL;

INSERT INTO States(state_code, state_name, state_abbr)
SELECT DISTINCT state_code, state_name, state_abbr FROM preliminary;

INSERT INTO Counties(county_code, county_name)
SELECT DISTINCT county_code, county_name FROM preliminary WHERE county_code IS NOT NULL;

INSERT INTO Ethnicities(ethnicity, ethnicity_name)
SELECT DISTINCT ethnicity, ethnicity_name
FROM (
    SELECT applicant_ethnicity AS ethnicity, applicant_ethnicity_name AS ethnicity_name
    FROM preliminary
    UNION
    SELECT co_applicant_ethnicity AS ethnicity, co_applicant_ethnicity_name AS ethnicity_name
    FROM preliminary 
) AS combined
WHERE ethnicity IS NOT NULL
AND NOT EXISTS (
    SELECT 1 FROM Ethnicities e
    WHERE e.ethnicity = combined.ethnicity
);

INSERT INTO Races(race, race_name)
SELECT DISTINCT race, race_name
FROM (
    SELECT applicant_race_1 AS race, applicant_race_name_1 AS race_name FROM preliminary
    UNION
    SELECT applicant_race_2, applicant_race_name_2 FROM preliminary 
    UNION
    SELECT applicant_race_3, applicant_race_name_3 FROM preliminary 
    UNION
    SELECT applicant_race_4, applicant_race_name_4 FROM preliminary 
    UNION
    SELECT applicant_race_5, applicant_race_name_5 FROM preliminary 
    UNION
    SELECT co_applicant_race_1, co_applicant_race_name_1 FROM preliminary 
    UNION
    SELECT co_applicant_race_2, co_applicant_race_name_2 FROM preliminary 
    UNION
    SELECT co_applicant_race_3, co_applicant_race_name_3 FROM preliminary 
    UNION
    SELECT co_applicant_race_4, co_applicant_race_name_4 FROM preliminary 
    UNION
    SELECT co_applicant_race_5, co_applicant_race_name_5 FROM preliminary 
) AS combined
WHERE race IS NOT NULL
AND NOT EXISTS (
    SELECT 1 FROM Races r
    WHERE r.race = combined.race
);

INSERT INTO Sexes(sex, sex_name)
SELECT DISTINCT sex, sex_name
FROM (
    SELECT applicant_sex AS sex, applicant_sex_name AS sex_name FROM preliminary 
    UNION
    SELECT co_applicant_sex, co_applicant_sex_name FROM preliminary 
) AS combined
WHERE sex IS NOT NULL
AND NOT EXISTS (
    SELECT 1 FROM Sexes s
    WHERE s.sex = combined.sex
);


INSERT INTO PurchaserTypes(purchaser_type, purchaser_type_name)
SELECT DISTINCT purchaser_type, purchaser_type_name FROM preliminary;

INSERT INTO DenialReasons(denial_reason, denial_reason_name)
SELECT DISTINCT denial_reason, denial_reason_name
FROM (
    SELECT denial_reason_1 AS denial_reason, denial_reason_name_1 AS denial_reason_name FROM preliminary  
    UNION
    SELECT denial_reason_2, denial_reason_name_2 FROM preliminary 
    UNION
    SELECT denial_reason_3, denial_reason_name_3 FROM preliminary 
) AS combined
WHERE denial_reason IS NOT NULL
AND NOT EXISTS (
    SELECT 1 FROM DenialReasons d
    WHERE d.denial_reason = combined.denial_reason
);

INSERT INTO HoepaStatuses(hoepa_status, hoepa_status_name)
SELECT DISTINCT hoepa_status, hoepa_status_name FROM preliminary;

INSERT INTO LienStatuses(lien_status, lien_status_name)
SELECT DISTINCT lien_status, lien_status_name FROM preliminary;

INSERT INTO EditStatuses(edit_status)
SELECT DISTINCT edit_status FROM preliminary WHERE edit_status IS NOT NULL;

INSERT INTO Applicant(applicant_id, applicant_ethnicity, applicant_sex, applicant_income_000s)
SELECT DISTINCT id, applicant_ethnicity, applicant_sex, applicant_income_000s FROM preliminary;

INSERT INTO Coapplicant(co_applicant_id, co_applicant_ethnicity, co_applicant_sex)
SELECT DISTINCT id, co_applicant_ethnicity, co_applicant_sex FROM preliminary;

INSERT INTO Location (
  msamd, state_code, county_code, census_tract_number, population,
  minority_population, hud_median_family_income, tract_to_msamd_income,
  number_of_owner_occupied_units, number_of_1_to_4_family_units
)
SELECT DISTINCT
  msamd, state_code, county_code, census_tract_number, population,
  minority_population, hud_median_family_income, tract_to_msamd_income,
  number_of_owner_occupied_units, number_of_1_to_4_family_units
FROM preliminary;

INSERT INTO Property (property_id, property_type, owner_occupancy, location_id)
SELECT DISTINCT
  p.id,
  p.property_type,
  p.owner_occupancy,
  l.location_id
FROM preliminary p
LEFT OUTER JOIN Location l ON
  coalesce(p.msamd, -1) = coalesce(l.msamd, -1) AND
  COALESCE(p.state_code, -1) = COALESCE(l.state_code, -1) AND
  COALESCE(p.county_code, -1) = COALESCE(l.county_code, -1) AND
  COALESCE(p.census_tract_number, -1) = COALESCE(l.census_tract_number, -1) AND
  COALESCE(p.population, -1) = COALESCE(l.population, -1) AND
  COALESCE(p.minority_population, -1) = COALESCE(l.minority_population, -1) AND
  COALESCE(p.hud_median_family_income, -1) = COALESCE(l.hud_median_family_income, -1) AND
  COALESCE(p.tract_to_msamd_income, -1) = COALESCE(l.tract_to_msamd_income, -1) AND
  COALESCE(p.number_of_owner_occupied_units, -1) = COALESCE(l.number_of_owner_occupied_units, -1) AND
  COALESCE(p.number_of_1_to_4_family_units, -1) = COALESCE(l.number_of_1_to_4_family_units, -1
);

INSERT INTO LoanApplication(application_id, applicant_id, co_applicant_id, as_of_year, respondent_id, agency_code, loan_type, property_id, loan_purpose, loan_amount_000s, preapproval, action_taken, purchaser_type, rate_spread, hoepa_status, lien_status, edit_status, sequence_number, applications_date_indicator)
SELECT DISTINCT id, id, id, as_of_year, respondent_id, agency_code, loan_type, id, loan_purpose, loan_amount_000s, preapproval, action_taken, purchaser_type, rate_spread, hoepa_status, lien_status, edit_status, sequence_number, applications_date_indicator 
FROM preliminary;

INSERT INTO ApplicationDenialReasons(application_id, denial_reason, denial_number)
SELECT DISTINCT id, denial_reason, denial_number
FROM (
    SELECT id, denial_reason_1 AS denial_reason, 1 as denial_number FROM preliminary 
    UNION
    SELECT id, denial_reason_2 AS denial_reason, 2 as denial_number FROM preliminary 
    UNION
    SELECT id, denial_reason_3 AS denial_reason, 3 as denial_number FROM preliminary 
) AS combined
WHERE denial_reason IS NOT NULL
AND NOT EXISTS (
    SELECT 1 FROM ApplicationDenialReasons a
    WHERE a.application_id = combined.id AND a.denial_number = combined.denial_number
);

INSERT INTO ApplicantRaces(applicant_id, race, race_number)
SELECT DISTINCT id, race, race_number
FROM (
    SELECT id, applicant_race_1 AS race, 1 as race_number FROM preliminary 
    UNION
    SELECT id, applicant_race_2 AS race, 2 as race_number FROM preliminary 
    UNION
    SELECT id, applicant_race_3 AS race, 3 as race_number FROM preliminary 
    UNION
    SELECT id, applicant_race_4 AS race, 4 as race_number FROM preliminary 
    UNION
    SELECT id, applicant_race_5 AS race, 5 as race_number FROM preliminary 
) AS combined
WHERE race IS NOT NULL
AND NOT EXISTS (
    SELECT 1 FROM ApplicantRaces a
    WHERE a.applicant_id = combined.id AND a.race_number = combined.race_number
);

INSERT INTO CoApplicantRaces(co_applicant_id, race, race_number)
SELECT DISTINCT id, race, race_number
FROM (
    SELECT id, co_applicant_race_1 AS race, 1 as race_number FROM preliminary 
    UNION
    SELECT id, co_applicant_race_2 AS race, 2 as race_number FROM preliminary 
    UNION
    SELECT id, co_applicant_race_3 AS race, 3 as race_number FROM preliminary 
    UNION
    SELECT id, co_applicant_race_4 AS race, 4 as race_number FROM preliminary 
    UNION
    SELECT id, co_applicant_race_5 AS race, 5 as race_number FROM preliminary 
) AS combined
WHERE race IS NOT NULL
AND NOT EXISTS (
    SELECT 1 FROM CoApplicantRaces c
    WHERE c.co_applicant_id = combined.id AND c.race_number = combined.race_number
);
