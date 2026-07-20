WITH customers AS (
    SELECT
        *
    FROM
        {{ ref('stg_customers') }}
),
orders AS (
    SELECT
        *
    FROM
        {{ ref('stg_orders') }}
),
payments AS (
    SELECT
        *
    FROM
        {{ ref('stg_payments') }}
)

SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status,
    p.payment_id,
    p.payment_method,
    p.amount
FROM 
    orders o
LEFT JOIN
    customers c
    ON o.customer_id = c.customer_id
LEFT JOIN
    payments p
    ON p.order_id = o.order_id
