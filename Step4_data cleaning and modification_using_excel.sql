CREATE DATABASE project1;

USE project1;

SELECT * FROM c_cleaning_and_modification_for_sql;

SELECT column1 as s_no, REPLACE(designation, " ()", "") as designation, company_name, location, estab_year, employees_count,
job_description as job_desc_combined, column3 as industry, column2 as description, skills, hr_name_extracted as hr_name,
experience_req
FROM c_cleaning_and_modification_for_sql;

