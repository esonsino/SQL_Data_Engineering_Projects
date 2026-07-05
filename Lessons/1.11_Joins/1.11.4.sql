WITH skill_count AS (
    SELECT
        sjd.job_id AS job_id,
        sjd.skill_id AS skill_id,
        sd.skills AS skills,
        COUNT (sd.skills) AS skill_count
    FROM   
        skills_job_dim AS sjd
    LEFT JOIN skills_dim AS sd
        ON sjd.skill_id = sd.skill_id
    GROUP BY 
        sjd.job_id, sjd.skill_id, sd.skills
)

SELECT
    jpf.job_title_short,
    sc.skill_id,
    sc.skills,
    sc.skill_count
FROM    
    job_postings_fact AS jpf
LEFT JOIN skill_count AS sc
    ON jpf.job_id = sc.job_id
WHERE 
    job_title LIKE '%Data'
LIMIT 100;

-------------


SELECT
    job_title_short,
    sd.skill_id,
    sd.skills,
    COUNT(jpf.job_id) AS job_count  
FROM
    job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd  
    ON sjd.skill_id = sd.skill_id
GROUP BY
    job_title_short, sd.skill_id, sd.skills
ORDER BY
    job_count DESC
LIMIT 200;