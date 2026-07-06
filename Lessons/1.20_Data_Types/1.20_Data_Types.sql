SELECT
    column_name,
    data_type
FROM
    information_schema.columns
WHERE
    table_name = 'job_postings_fact';

SELECT
    cast(123 AS varchar);

SELECT
    cast(job_id as varchar) || '-' || cast(company_id as varchar),
    cast(job_work_from_home AS integer),
    cast(job_posted_date as date),
    cast(salary_year_avg as decimal(10,0))
FROM
    job_postings_fact
LIMIT
    10;