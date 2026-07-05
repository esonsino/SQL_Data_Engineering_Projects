/*
Question: What are the most optimal skills for data analysts—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Analyst positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/

SELECT 
    sd.skills,
    CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_year_avg) AS INT) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND((LN(COUNT(jpf.*)) * MEDIAN(jpf.salary_year_avg))/1_000_000, 2) AS optimal_score
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst'
    AND jpf.salary_year_avg IS NOT NULL
    AND jpf.job_work_from_home = True 
GROUP BY
    sd.skills
HAVING 
    COUNT(sjd.job_id) >= 100
ORDER BY
    optimal_score DESC
LIMIT 25;

/*
Here's a breakdown of the most optimal skills for Data Analysts, based on both high demand and high salaries:

┌──────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│  skills  │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│ varchar  │     int32     │    int64     │     double      │    double     │
├──────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ sql      │         90000 │          783 │             6.7 │           0.6 │
│ tableau  │         95000 │          505 │             6.2 │          0.59 │
│ python   │         90000 │          494 │             6.2 │          0.56 │
│ power bi │         90000 │          293 │             5.7 │          0.51 │
│ r        │         89796 │          289 │             5.7 │          0.51 │
│ excel    │         83500 │          441 │             6.1 │          0.51 │
│ sas      │         85900 │          220 │             5.4 │          0.46 │
│ looker   │         87500 │          117 │             4.8 │          0.42 │
└──────────┴───────────────┴──────────────┴─────────────────┴───────────────┘
*/

c