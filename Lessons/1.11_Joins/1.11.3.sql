SELECT  
    j.job_id,
    j.job_title_short,
    j.job_title,
    j.job_location,
    s.skill_id
FROM
    job_postings_fact AS j
FULL JOIN skills_job_dim AS s
    ON j.job_id = s.job_id
WHERE
    j.job_country = 'United States'
ORDER BY
    j.job_id, s.skill_id
LIMIT 10;