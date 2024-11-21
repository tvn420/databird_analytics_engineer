select

order_id,
customer_id,
store_id,
staff_id,
order_status,
CAST(order_date as DATETIME) AS order_at,
CAST(required_date as DATETIME) AS required_at,
SAFE_CAST(shipped_date as DATETIME) AS shipped_at

from {{source("databird_final_case","orders")}}