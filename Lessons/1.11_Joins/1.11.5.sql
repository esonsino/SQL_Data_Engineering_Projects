WITH skills AS (
    SELECT 
        sjd.job_id AS job_id,
        sd.skill_id AS skill_id,
        sd.skills AS skills
    FROM
      count   skills_job_dim AS sjd
    INNER JOIN skills_dim AS sd
        ON sjd.skill_id = sd.skill_id
) 
SELECT  
    job_title_short,
    s.skills AS skills,
    COUNT(jpf.job_id) AS job_count
FROM    
    job_postings_fact AS jpf
LEFT JOIN skills AS s
    ON jpf.job_id = s.job_id
WHERE
    salary_year_avg > 100_000
GROUP BY    
    job_title_short, skills
ORDER BY
    job_count DESC
LIMIT 50;
