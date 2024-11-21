select

CONCAT(order_id,'_',item_id) AS order_item_id,
order_id,
item_id,
product_id,
quantity,
ROUND(list_price,2) AS product_price,
discount 

from {{source("databird_final_case","order_items")}}