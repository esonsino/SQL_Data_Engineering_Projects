/*
Question: What are the highest-paying skills for data analyst?
- Calculate the median salary for each skill required in data analyst positions
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/

WITH skills AS (
    SELECT
        *
    FROM
        skills_job_dim AS sjd
    INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
)
SELECT
    s.skills,
    CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_year_avg) AS INT) AS median_salary,
    COUNT(jpf.*) AS demand_count
FROM
    job_postings_fact AS jpf
INNER JOIN skills AS s ON jpf.job_id = s.job_id
WHERE
    job_title_short IN ('Data Analyst')
GROUP BY
    s.skills
HAVING
    COUNT(jpf.*) > 10_000
ORDER BY
    median_salary DESC
LIMIT
    20;

/*
Here's a breakdown of the highest-paying skills for Data Analysts:

Key Insights:
- Snowflake remains the top-paying skill at $106K median salary, though demand still relatively lower at 13K job postings compared to popular skills like SQL and Python.
- Looker has high median salaries at $105K, with identical demand as Snowflake.
- Popular cloud services like AWS and Azure have the same median salary at $100K with roughly 20K job postings each. 
  - Java: $100K median salary (10k postings)
  - Python: $98K median salary (116K postings)
  - Oracle: $96K median salary (19K postings)
  - SQL: $95K median salary (180K postings)

Takeaway: Cloud and modern data stack skills (Snowflake, Looker, Azure, AWS) command the highest salaries, while high-demand fundamentals like SQL, Excel, and Python offer slightly lower but still competitive pay.

┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │     int32     │    int64     │
├────────────┼───────────────┼──────────────┤
│ snowflake  │        106100 │        13207 │
│ looker     │        105000 │        13875 │
│ azure      │        100000 │        21613 │
│ java       │        100000 │        10255 │
│ aws        │        100000 │        18967 │
│ python     │         98650 │       116082 │
│ oracle     │         95924 │        18966 │
│ qlik       │         95000 │        10072 │
│ sql server │         95000 │        15130 │
│ sql        │         95000 │       180369 │
│ r          │         95000 │        58385 │
│ tableau    │         95000 │        90588 │
│ go         │         90000 │        14433 │
│ sas        │         90000 │        50742 │
│ vba        │         90000 │        12066 │
│ flow       │         90000 │        14097 │
│ power bi   │         88572 │        84353 │
│ sap        │         86400 │        20903 │
│ powerpoint │         82880 │        25316 │
│ excel      │         82500 │       131822 │
└────────────┴───────────────┴──────────────┘
  20 rows                         3 columns

*/
