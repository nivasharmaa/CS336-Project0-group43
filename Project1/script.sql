-- CREATE TABLES

CREATE TABLE IF NOT EXISTS LoanApplication(
application_id SERIAL PRIMARY KEY, 
as_of_year INTEGER, 
agency_code INTEGER,
respondent_id TEXT,
loan_amount_000s INTEGER, 
loan_purpose INTEGER,
loan_type INTEGER,
preapproval INTEGER, 
action_taken INTEGER, 
owner_occupancy INTEGER, 
rate_spread TEXT, 
hoepa_status INTEGER, 
lien_status INTEGER,
location_id INTEGER,
purchaser_type INTEGER,
applicant_income_000s INTEGER
);

CREATE TABLE IF NOT EXISTS Location(
location_id SERIAL PRIMARY KEY, 
state_code INTEGER, 
county_code INTEGER, 
msamd INTEGER, 
census_tract_number TEXT, 
population INTEGER, 
minority_population TEXT, 
hud_median_family_income INTEGER, 
tract_to_msamd_income TEXT, 
number_of_owner_occupied_units INTEGER, 
number_of_1_to_4_family_units INTEGER
);

CREATE TABLE IF NOT EXISTS Ethnicities(
ethnicity INTEGER PRIMARY KEY,
ethnicity_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Races(
application_id SERIAL PRIMARY KEY,
race INTEGER,
race_name TEXT
);

CREATE TABLE IF NOT EXISTS Sexes(
sex INTEGER PRIMARY KEY,
sex_name TEXT NOT NULL
);




CREATE TABLE IF NOT EXISTS DenialReasons(
	application_id SERIAL PRIMARY KEY,
denial_reason INTEGER,
denial_reason_name TEXT
);

CREATE TABLE IF NOT EXISTS LoanTypes(
loan_type INTEGER PRIMARY KEY, 
loan_type_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS LoanPurposes(
loan_purpose INTEGER PRIMARY KEY,
loan_purpose_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS PropertyTypes(
property_type INTEGER PRIMARY KEY,
property_type_names TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS OwnerOccupancies(
owner_occupancy INTEGER PRIMARY KEY,
owner_occupancy_name TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS LienStatuses(
lien_status INTEGER PRIMARY KEY,
lien_status_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS HoepaStatuses(
hoepa_status INTEGER PRIMARY KEY,
hoepa_status_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS PurchaserTypes(
purchaser_type INTEGER PRIMARY KEY,
purchaser_type_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS ActionsTaken(
action_taken INTEGER PRIMARY KEY,
action_taken_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Preapprovals(
preapproval INTEGER PRIMARY KEY,
preapproval_name TEXT NOT NULL 
);

CREATE TABLE IF NOT EXISTS States(
state_code INTEGER PRIMARY KEY,
state_name TEXT NOT NULL,
state_abbr TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Counties(
	location_id SERIAL PRIMARY KEY,
county_code INTEGER,
county_name TEXT
);

CREATE TABLE IF NOT EXISTS Msamds(
	location_id SERIAL PRIMARY KEY,
msamd INTEGER,
msamd_name TEXT
);


CREATE TABLE IF NOT EXISTS Agencies(
agency_code INTEGER PRIMARY KEY, 
agency_name TEXT NOT NULL, 
agency_abbr TEXT NOT NULL	
);

CREATE TABLE IF NOT EXISTS Nulls(
    edit_status INTEGER,
    edit_status_name TEXT,
    sequence_number TEXT,
    application_date_indicator TEXT
);



-- INPUT DATA INTO TABLES FROM PRELIMINARY


INSERT INTO Agencies (agency_code, agency_name, agency_abbr)
SELECT DISTINCT agency_code, agency_name, agency_abbr FROM PRELIMINARY;

INSERT INTO LoanTypes (loan_type, loan_type_name)
SELECT DISTINCT loan_type, loan_type_name FROM preliminary;

INSERT INTO LoanPurposes (loan_purpose, loan_purpose_name)
SELECT DISTINCT loan_purpose, loan_purpose_name FROM preliminary;

INSERT INTO Ethnicities (ethnicity, ethnicity_name)
SELECT DISTINCT applicant_ethnicity, applicant_ethnicity_name FROM preliminary;

INSERT INTO LoanApplication (
    as_of_year,
    agency_code,
    respondent_id,
    loan_amount_000s,
    loan_purpose,
    loan_type,
    preapproval,
    action_taken,
    owner_occupancy,
    rate_spread,
    hoepa_status,
    lien_status,
    location_id,
    purchaser_type,
    applicant_income_000s
)
SELECT 
    as_of_year,
    agency_code,
    respondent_id,
    loan_amount_000s,
    loan_purpose,
    loan_type,
    preapproval,
    action_taken,
    owner_occupancy,
    rate_spread,
    hoepa_status,
    lien_status,
    location_id,
    purchaser_type,
    applicant_income_000s
FROM preliminary;

