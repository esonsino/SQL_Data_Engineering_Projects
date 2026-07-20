WITH raw_customers AS (
    SELECT
        id AS customer_id,
        first_name,
        last_name
    FROM 
        {{ 'customers' }}
)

SELECT * FROM raw_customers
