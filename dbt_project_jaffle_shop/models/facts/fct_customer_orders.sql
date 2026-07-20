SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    SUM(amount) AS total_spent,
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS latest_order_date
FROM 
    {{ ref('fct_orders') }}
GROUP BY
    customer_id
