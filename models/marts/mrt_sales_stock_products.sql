{{ config(
    materialized='table'
) }}

WITH query_product_rank AS (

SELECT
order_date_year_month,
product_id,
RANK() OVER (PARTITION BY order_date_year_month ORDER BY SUM(quantity)) AS product_rank

FROM 

{{ref('int_orders_items_sales')}} 

GROUP BY

order_date_year_month,
product_id

)

SELECT 

oi.order_date_year_month,
order_at,
oi.store_id,
oi.order_id,
store_name,
brand_name,
category_name,
oi.product_id,
product_name,
oi.quantity,
order_items_total_price,
stock_quantity,
product_rank

FROM

{{ref('int_orders_items_sales')}} oi
LEFT JOIN {{ref('int_products_details')}} p 
ON oi.product_id = p.product_id
LEFT JOIN {{ref("stg_stocks")}} s 
ON oi.store_id = s.store_id
AND oi.product_id = s.product_id
LEFT JOIN query_product_rank q 
ON oi.product_id = q.product_id
AND oi.order_date_year_month = q.order_date_year_month

order by order_at desc