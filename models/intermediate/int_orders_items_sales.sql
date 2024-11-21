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

)


SELECT 

o.order_id,
customer_id,
order_item_id,
product_id,
store_id,
staff_id,
quantity,
order_at,
order_items_total_price,
DATETIME_TRUNC(order_at, MONTH) as order_date_year_month
--SUM(order_items_total_price) OVER(PARTITION BY store_id, DATETIME_TRUNC(order_at, MONTH)) AS store_id_total_amount_m,
--SUM(quantity) OVER(PARTITION BY store_id, DATETIME_TRUNC(order_at, MONTH)) AS product_quantity_sum_m


FROM {{ref('stg_orders')}} o left join query_order_items oi 

ON o.order_id = oi.order_id

--ORDER BY order_at DESC