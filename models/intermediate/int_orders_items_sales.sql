WITH query_order_items AS (

select 
order_item_id ,
order_id,
product_id,
quantity,
ROUND(SUM(quantity * product_price),2) AS order_items_total_price,
product_price,
discount

from {{ref('stg_order_items')}} 

group by 

order_item_id,
order_id,
item_id,
product_id,
quantity,
product_price,
discount 

),

query_store_sales AS (

SELECT 

o.store_id,
store_name,
staff_id,
o.order_id,
customer_id,
order_item_id,
oi.product_id,
product_price,
quantity,
order_at,
order_items_total_price,
DATETIME_TRUNC(order_at, MONTH) as order_date_year_month

FROM {{ref('stg_orders')}} o 
LEFT JOIN query_order_items oi 
ON o.order_id = oi.order_id
LEFT JOIN {{ref('stg_stores')}} s
ON o.store_id = s.store_id
)


SELECT 

q.store_id,
store_name,
staff_id,
order_id,
customer_id,
order_item_id,
q.product_id,
product_price,
quantity,
product_quantity AS product_stock,
order_at,
order_items_total_price,
DATETIME_TRUNC(order_at, MONTH) as order_date_year_month

FROM query_store_sales q
LEFT JOIN {{ref('stg_stocks')}} st 
ON q.store_id = st.store_id 
AND q.product_id = st.product_id