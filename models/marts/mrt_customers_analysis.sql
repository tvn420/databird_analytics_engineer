SELECT

oi.customer_id,
customer_city,
customer_state,
customer_zip_code,
brand_name,
oi.product_id,
product_name,
quantity,
product_price, 
order_at,
order_date_year_month,
SUM(order_items_total_price) AS order_items_total_price_sum,
DENSE_RANK() OVER (PARTITION BY order_date_year_month, customer_city ORDER BY SUM(order_items_total_price) DESC) AS city_sales_rank

FROM 

{{ref("int_orders_items_sales")}} oi 
LEFT JOIN {{ref("int_products_details")}} p 
ON oi.product_id = p.product_id
LEFT JOIN {{ref("stg_customers")}} c 
ON oi.customer_id = c.customer_id

GROUP BY

oi.customer_id,
customer_city,
customer_state,
customer_zip_code,
brand_name,
oi.product_id,
product_name,
quantity,
product_price,
order_at,
order_date_year_month

