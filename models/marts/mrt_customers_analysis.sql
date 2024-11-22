{{ config(
    materialized='table'
) }}

SELECT

oi.customer_id,
customer_city,
customer_state,
customer_zip_code,
customer_email,
customer_phone,
brand_name,
oi.order_id,
oi.product_id,
product_name,
quantity,
product_price, 
order_at,
order_date_year_month,
order_items_total_price

FROM 

{{ref("int_orders_items_sales")}} oi 
LEFT JOIN {{ref("int_products_details")}} p 
ON oi.product_id = p.product_id
LEFT JOIN {{ref("stg_customers")}} c 
ON oi.customer_id = c.customer_id
