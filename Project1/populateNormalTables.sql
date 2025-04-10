-- POPULATE TABLES

INSERT INTO Agencies (agency_code, agency_name, agency_abbr)
SELECT DISTINCT agency_code, agency_name, agency_abbr FROM PRELIMINARY;

INSERT INTO LoanTypes (loan_type, loan_type_name)
SELECT DISTINCT loan_type, loan_type_name FROM preliminary;

INSERT INTO PropertyTypes(property_type, property_type_names)
SELECT DISTINCT property_type, property_type_name from preliminary;

INSERT INTO LoanPurposes(loan_purpose, loan_purpose_name)
SELECT DISTINCT loan_purpose, loan_purpose_name FROM preliminary;

INSERT INTO OwnerOccupancies(owner_occupancy, owner_occupancy_name)
SELECT DISTINCT owner_occupancy, owner_occupancy_name FROM preliminary;

INSERT INTO Preapprovals(preapproval, preapproval_name)
SELECT DISTINCT preapproval, preapproval_name FROM preliminary;

INSERT INTO ActionsTaken(action_taken, action_taken_name)
SELECT DISTINCT action_taken, action_taken_name FROM preliminary;

INSERT INTO Msamds(msamd, msamd_name)
SELECT DISTINCT msamd, msamd_name FROM preliminary;

INSERT INTO States(state_code, state_name, state_abbr)
SELECT DISTINCT state_code, state_name, state_abbr FROM preliminary;

INSERT INTO Counties(county_code, county_name)
SELECT DISTINCT county_code, county_name FROM preliminary;

INSERT INTO Ethnicities(ethnicity, ethnicity_name)
SELECT DISTINCT ethnicity, ethnicity_name FROM preliminary;

INSERT INTO Races(race, race_name)
SELECT DISTINCT race, race_name FROM preliminary;

INSERT INTO Sexes(sex, sex_name)
SELECT DISTINCT sex, sex_name FROM preliminary;

INSERT INTO PurchaserTypes(purchaser_type, purchaser_type_name)
SELECT DISTINCT purchaser_type, purchaser_type_name FROM preliminary;

INSERT INTO DenialReasons(denial_reason, denial_reason_name)
SELECT DISTINCT denial_reason, denial_reason_name FROM preliminary;

INSERT INTO HoepaStatuses(hoepa_status, hoepa_status_name)
SELECT DISTINCT hoepa_status, hoepa_status_name FROM preliminary;

INSERT INTO LienStatuses(lien_status, lien_status_name)
SELECT DISTINCT lien_status, lien_status_name FROM preliminary;

INSERT INTO EditStatuses(edit_status)
SELECT DISTINCT edit_status FROM preliminary;

INSERT INTO Applicant(applicant_ethnicity, applicant_sex, applicant_income_000s)
SELECT DISTINCT applicant_ethnicity, applicant_sex, applicant_income_000s FROM preliminary;

INSERT INTO Coapplicant(co_applicant_ethnicity, co_applicant_sex)
SELECT DISTINCT co_applicant_ethnicity, co_applicant_sex FROM preliminary;

INSERT INTO Property(property_type, owner_occupancy, location_id)
SELECT DISTINCT location_id FROM preliminary;

INSERT INTO Location(msamd, state_code, county_code, census_tract_number, population, minority_population, hud_median_family_income, tract_to_msamd_income, number_of_owner_occupied_units, number_of_1_to_4_family_units)
SELECT DISTINCT msamd, state_code, county_code, census_tract_number, population, minority_population, hud_median_family_income, tract_to_msamd_income, number_of_owner_occupied_units, number_of_1_to_4_family_units FROM preliminary;

INSERT INTO ApplicantRaces(applicant_id, race, race_number)
SELECT DISTINCT applicant_id, race, race_number FROM preliminary;

INSERT INTO CoApplicantRaces(co_applicant_id, race, race_number)
SELECT DISTINCT co_applicant_id, race, race_number FROM preliminary;

INSERT INTO LoanApplication(applicant_id, co_application_id, as_of_year, respondent_id, agency_code, loan_type, property_id, location_id, loan_purpose, loan_amount_000s, preapproval, action_taken, purchaser_type, rate_spread, hoepa_status, lien_status, edit_status, sequence_number, application_date_indicator)
SELECT DISTINCT applicant_id, co_application_id, as_of_year, respondent_id, agency_code, loan_type, property_id, location_id, loan_purpose, loan_amount_000s, preapproval, action_taken, purchaser_type, rate_spread, hoepa_status, lien_status, edit_status, sequence_number, application_date_indicator FROM preliminary;

INSERT INTO ApplicationDenialReasons(application_id, denial_reason, denial_number)
SELECT DISTINCT application_id, denial_reason, denial_number FROM preliminary;