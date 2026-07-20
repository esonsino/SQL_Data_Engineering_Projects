WITH raw_payments AS (
SELECT
    id AS payment_id,
    order_id,
    payment_method,
    amount / 100 AS amount
FROM
    {{ 'payments' }}
)

SELECT * FROM raw_payments
