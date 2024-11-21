{{ config(
    materialized='table'
) }}

WITH metrics_by_staff_store AS (

SELECT

store_id,
staff_id,
order_date_year_month,
COUNT(DISTINCT order_id) AS order_id_count,
COUNT(DISTINCT customer_id) AS customer_id_count,
ROUND(SUM(order_items_total_price),2) AS staff_total_sales_m,
LAG(SUM(order_items_total_price)) OVER (PARTITION BY store_id, staff_id  ORDER BY order_date_year_month ASC) staff_total_sales_m_1,
SUM(quantity) AS product_quantity_sum

FROM

{{ref('int_orders_items_sales')}}

GROUP BY 

store_id,
staff_id,
order_date_year_month
)

SELECT 

s.store_id,
store_name,
s.staff_id,
order_id,
customer_id,
order_item_id,
product_id,
product_price,
quantity,
product_stock,
order_at,
order_items_total_price,
s.order_date_year_month,
staff_total_sales_m,
ROUND(staff_total_sales_m_1,2) AS staff_total_sales_m_1,
staff_total_sales_m - staff_total_sales_m_1 AS total_sales_evolution

FROM 

{{ref('int_orders_items_sales')}} s LEFT JOIN metrics_by_staff_store m
ON 
s.store_id = m.store_id
AND s.staff_id = m.staff_id
AND s.order_date_year_month = m.order_date_year_month

order by order_date_year_month ASC