CREATE DATABASE project;

#using the database
USE project;

#reading source file
SELECT * FROM final_data_for_analysis;

#reading all 3 tables created from the source file
SELECT * FROM jobs;
SELECT * FROM company;
SELECT * FROM details;

#altering the tables as per project instructions
#adding primary key constraint to job_id column in jobs table
ALTER TABLE jobs
MODIFY COLUMN job_id varchar(6);
ALTER TABLE jobs
ADD PRIMARY KEY (job_id);

#adding primary key constraint to companyid column in company table
ALTER TABLE company
MODIFY COLUMN company_id varchar(6);
ALTER TABLE company
ADD PRIMARY KEY (company_id);

#adding primary key constraint to details_id column in details table
ALTER TABLE details
MODIFY COLUMN details_id varchar(3);
ALTER TABLE details
ADD PRIMARY KEY (details_id);

#adding foreign key constraint to company_id column in jobs table and referencing it with that in comapany table
ALTER TABLE jobs
MODIFY COLUMN company_id varchar(6);
ALTER TABLE jobs
ADD FOREIGN KEY (company_id) REFERENCES company(company_id);

#adding foreign key constraint to details_id column in jobs table and referencing it with that in details table
ALTER TABLE jobs
MODIFY COLUMN details_id varchar(3);
ALTER TABLE jobs
ADD FOREIGN KEY (details_id) REFERENCES details(details_id);

###### NOW REFERING TO THE PROJECT INSTRUCTIONS #######
## Once you have the database of 3 tables created:
-- You need to generate aggregations and that will help you create dashboard which should be able to help the end user with
-- following insights:

## 1. Comparision of number of jobs across different cities for different level
SELECT location as job_location, count(job_ID) AS num_of_jobs
FROM jobs
GROUP BY 1
ORDER BY 2 DESC;

## 2. Generate some insight with respect to number of jobs distribution across various industry.
-- For instance, what is the total number of jobs in Software Industry as compared to Marketing
SELECT details_id, count(*) as num_of_jobs
FROM jobs
GROUP BY 1
ORDER BY 2 DESC;

## 3. Generate insights into number of opening with respect to the current employee count
-- For instance, number of openings in a company with more than 1000 employees in comparison to that in a company with 100 employees
SELECT employees_count as size, COUNT(job_id) as num_of_jobs
FROM jobs AS J LEFT JOIN company AS C ON J.company_id=C.company_id
GROUP BY 1
ORDER BY 2 DESC;

## 4. Generate any one interesting insight from the data
# which company is hiring most aggressively
# how many companies are still giving remote work
# which industry is giving most remote work
# which industry jobs are invited by companies established in each year
# among excel, python, sql which is the most sough after skill among only data analysis jobs
SELECT estab_year, CASE WHEN estab_year > 2009 THEN 'Since 2010'
WHEN estab_year < 2010 THEN 'Before 2010' END AS foundation, details_id, count(*)
FROM jobs as J LEFT JOIN company AS C on J.company_id = C.company_id
GROUP BY 1
ORDER BY 1 DESC;

## 5. Count the number of jobs across different industry across different locations.
-- For instance, how many Frontend Engineer jobs are there in Bangalore as compared to Data Analytics jobs in Bangalore,
-- or how many Data Analytics jobs are there in Bangalore as compared to number of Data Scientists job in Gurgaon
SELECT details_id, location, COUNT(job_id) AS num_of_jobs
FROM jobs
GROUP BY 1, 2
ORDER BY 1, 3 DESC;