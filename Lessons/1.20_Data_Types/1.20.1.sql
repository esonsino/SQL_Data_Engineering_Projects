select *
from job_postings_fact
limit 10;

select 
    column_name,
    data_type
from information_schema.columns;
where table_name = 'job_postings_fact';

select 
    count(*) as job_count,
    cast(job_posted_date as date) as dt
from 
    job_postings_fact
where 
    job_posted_date::date = '2024-12-31'
group by 2;