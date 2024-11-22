{{ config(
    materialized='table'
) }}

WITH metrics_by_staff_store AS (

SELECT

order_date_year_month,
order_at,
store_id,
store_name,
city,
state,
staff_id,
COUNT(DISTINCT order_id) AS order_id_count,
COUNT(DISTINCT customer_id) AS customer_id_count,
ROUND(SUM(order_items_total_price),2) AS staff_total_sales_m,
LAG(SUM(order_items_total_price)) OVER (PARTITION BY store_id, staff_id  ORDER BY order_at ASC) staff_total_sales_m_1,
SUM(quantity) AS product_quantity_sum

FROM

{{ref('int_orders_items_sales')}}

GROUP BY 

store_id,
store_name,
city,
state,
staff_id,
order_date_year_month,
order_at
)

SELECT 

s.store_id,
store_name,
city,
state,
s.staff_id,
CONCAT(staff_first_name,' ', staff_last_name) AS staff_name,
CONCAT(manager_first_name,' ', manager_last_name) AS manager_name,
s.order_at,
s.order_date_year_month,
order_id_count,
customer_id_count,
staff_total_sales_m,
ROUND(staff_total_sales_m_1,2) AS staff_total_sales_m_1,
staff_total_sales_m - staff_total_sales_m_1 AS total_sales_evolution

FROM 

metrics_by_staff_store s 
LEFT JOIN {{ref('int_staff_manager')}} m 
ON s.staff_id = m.staff_id

order by order_at ASC