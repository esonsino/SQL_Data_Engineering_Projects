SELECT  
    jpf.job_id,
    jpf.job_title,
    sd.skills,
    jpf.job_country
FROM 
    job_postings_fact AS jpf
JOIN skills_job_dim AS sjb
    ON jpf.job_id = sjb.job_id
LEFT JOIN skills_dim AS sd
    ON sjb.skill_id = sd.skill_id
WHERE   
    job_title_short = 'Data Engineer'
    AND job_health_insurance = TRUE
    AND jpf.job_country = 'United States'
ORDER BY
    job_id DESC
LIMIT 100;