SELECT  
    job_id,
    job_title,
    cd.name AS company_name,
    job_location,
    job_posted_date
FROM 
    job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE
    cd.name IS NOT NULL
    AND job_title_short = 'Data Engineer'
ORDER BY
    job_posted_date DESC
LIMIT 10;
