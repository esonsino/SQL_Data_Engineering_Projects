SELECT
    job_title_short,
    job_no_degree_mention,
    count(*) AS job_count
FROM
    job_postings_fact
WHERE
    job_posted_date::date BETWEEN '2024-12-01'
    AND '2024-12-31'
GROUP BY
    1,2
ORDER BY
    1,2;