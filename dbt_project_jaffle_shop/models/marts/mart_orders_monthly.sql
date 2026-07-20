WITH order_months AS (
    SELECT
        order_id,
        DATE_TRUNC('month', order_date) AS order_month
    FROM
        {{ ref('fct_orders')}}
),

final AS (
    SELECT 
        order_month,
        COUNT(order_id) AS order_count
    FROM
        order_months
    GROUP BY
        1
)

SELECT * FROM final
