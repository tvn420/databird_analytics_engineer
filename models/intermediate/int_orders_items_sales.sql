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

customer_product_summary AS (
SELECT 
o.customer_id,
oi.product_id,
p.product_name,
ROW_NUMBER() OVER(
  PARTITION BY o.customer_id
  ORDER BY SUM(quantity) DESC
) AS rn

FROM 
  {{ref("stg_order_items")}} oi
  INNER JOIN {{ref('stg_orders')}} o ON o.order_id = oi.order_id
  LEFT JOIN {{ref('stg_products')}} p ON p.product_id = oi.product_id

GROUP BY
o.customer_id,
oi.product_id,
p.product_name
),

customer_favorite_product AS (

SELECT
u.customer_id,
p.product_id AS favorite_product_id,
p.product_name AS favorite_product_name

FROM   map-80552.dbt_tca.stg_customers u
LEFT JOIN customer_product_summary p ON u.customer_id = p.customer_id
AND p.rn = 1 )

SELECT 

DATETIME_TRUNC(order_at, MONTH) as order_date_year_month,
order_at,
o.store_id,
store_name,
city,
state,
staff_id,
o.order_id,
o.customer_id,
order_item_id,
favorite_product_id,
favorite_product_name,
q.product_id,
product_price,
quantity,
order_items_total_price

FROM {{ref('stg_orders')}} o
LEFT JOIN query_order_items q
ON o.order_id = q.order_id
LEFT JOIN {{ref('stg_stores')}} s
ON o.store_id = s.store_id
LEFT JOIN customer_favorite_product f 
ON o.customer_id = f.customer_id