/*
Question: What are the most in-demand skills for data analysts and business analysts?
- Identify the top 10 in-demand skills for data analysts and business analysts
- Focus on the jobs in the Netherlands
- Why? Retrieves the top 10 skills with the highest demand in the Netherlands,
    providing insights into the most valuable skills for data analysts and business analysts 
*/

SELECT
    sd.skills,
    COUNT(jpf.job_id) AS job_count
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
    (job_title_short IN ('Data Analyst', 'Business Analyst'))
    AND job_country = 'Netherlands'
GROUP BY
    sd.skills
ORDER BY
    COUNT(jpf.job_id) DESC
LIMIT
    10;

/*
┌──────────┬───────────┐
│  skills  │ job_count │
│ varchar  │   int64   │
├──────────┼───────────┤
│ sql      │      3869 │
│ python   │      3062 │
│ excel    │      1926 │
│ power bi │      1693 │
│ tableau  │      1397 │
│ r        │      1347 │
│ azure    │      1000 │
│ word     │       618 │
│ sas      │       612 │
│ sap      │       539 │
└──────────┴───────────┘
  10 rows    2 columns

Here's the breakdown of the most demanded skills for data analysts and business analysts:
SQL and Python are by far the most in-demand skills, with around 3800 and 3000 job postings respectively - nearly double the next closest skill.
Microsoft Excel completes the top 3 with nearly 2000 postings, highlighting the importance of spreadsheets. 
Business Intelligence tools round out the top skills, with Power BI leading at roughly 1700 postings, followed by Tableau at ~1400.

Key takeaways:
- SQL and Python remain the foundational skills for data analysts and business analysts
- Excel is critical for spreadsheets and quick analysis
- Business Intelligence  tools like Power BI and Tableau continue to be highly valued
- Programming language R show significant demand
- Word's presence in the top 10 likely reflects generic office skill requirements in than a core data skill
*/
