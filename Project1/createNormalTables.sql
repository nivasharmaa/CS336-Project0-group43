-- CREATE TABLES

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
-- location_id INTEGER REFERENCES Location,
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
