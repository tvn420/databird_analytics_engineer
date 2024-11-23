{{ config(
    materialized='table'
) }}

WITH query_sales_by_customer AS (

SELECT 
customer_id,
order_at,
SUM(order_items_total_price) as order_price_by_customer

FROM 

{{ref('int_orders_items_sales')}}

GROUP BY

customer_id,
order_at
),

query_customer_month_diff_order AS (

SELECT 
customer_id,
DATE_DIFF(MAX(order_at),MAX(last_order_at), MONTH) AS last_order_at_diff_month

FROM (
  SELECT

  customer_id,
  order_at,
  LAG(order_at) OVER(ORDER BY order_at) as last_order_at

  FROM 

  query_sales_by_customer 
)

group by customer_id

)

SELECT

order_date_year_month,
order_at,
oi.customer_id,
customer_city,
customer_state,
customer_zip_code,
customer_email,
customer_phone,
favorite_product_id,
favorite_product_name,
brand_name,
oi.order_id,
oi.product_id,
product_name,
quantity,
product_price, 
order_items_total_price,
last_order_at_diff_month

FROM 

{{ref("int_orders_items_sales")}} oi 
LEFT JOIN {{ref("int_products_details")}} p 
ON oi.product_id = p.product_id
LEFT JOIN {{ref("stg_customers")}} c 
ON oi.customer_id = c.customer_id
LEFT JOIN query_customer_month_diff_order d 
ON oi.customer_id = d.customer_id


