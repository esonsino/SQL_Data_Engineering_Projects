/*- Find the top 10 highest-paying Data Engineer roles that are available remotely
    - Write a query to list each unique skill from the **`skills_dim`** table.
    - Count how many job postings mention each skill from the **`skills_job_dim`** table.
    - Calculate the average yearly salary for job postings associated with each skill.
    - Group the results by the skill name.
    - Order By the average salary */
SELECT
    job_id,
    job_title,
    cd.company_id,
    salary_year_avg
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd 
    ON jpf.company_id = cd.company_id
WHERE   
    job_title_short = 'Data Engineer'
    AND job_work_from_home = TRUE
    AND salary_year_avg IS NOT NULL;
