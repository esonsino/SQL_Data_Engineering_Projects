/*
This table classifies customers based on order behaviour:
new_customer = only 1 order count
returning_customer = more then 1 order
*/


WITH customer_orders AS (
    SELECT *
    FROM 
        {{ ref('fct_customer_orders')}}
),

final AS (
    SELECT
        customer_id,
        total_orders,
        total_spent,
        CASE
            WHEN total_orders = 1 THEN 'new_customer'
            WHEN total_orders > 1 THEN 'returning_customer'
        END AS customer_type
    FROM 
        customer_orders
)

SELECT * FROM final
