WITH raw_orders AS (
    SELECT
        id AS order_id,
        user_id AS customer_id,
        order_date,
        status
    FROM
        {{ 'orders' }}
)

SELECT * FROM raw_orders

    