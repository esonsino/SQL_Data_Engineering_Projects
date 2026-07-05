SELECT
    sd.skill_id,
    sd.skills,
    COUNT(jpf.job_id) AS job_count
FROM
    skills_dim AS sd
    RIGHT JOIN skills_job_dim AS sjd ON sd.skill_id = sjd.skill_id
    RIGHT JOIN job_postings_fact AS jpf ON jpf.job_id = sjd.job_id
WHERE
    jpf.job_title_short LIKE '%Data%'
GROUP BY
    sd.skill_id,
    sd.skills
ORDER BY
    job_count DESC;


