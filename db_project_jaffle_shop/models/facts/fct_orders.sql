{{
    config(
        materialized="incremental",
        unique_key='order_id',
        incremental_strategy="merge"
    )
}}

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

{% if is_incremental() %}

,incremental_cutoff AS (
    SELECT COALESCE(MAX(order_date), '1900-01-01'::DATE) AS cutoff_date
    FROM {{ this }}
)

{% endif %}

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

{% if is_incremental() %}

INNER JOIN
    incremental_cutoff
    ON o.order_date > incremental_cutoff.cutoff_date

{% endif %}