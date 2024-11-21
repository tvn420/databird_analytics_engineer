select

product_id,
brand_id,
category_id,
COALESCE(product_name, 'Other') AS product_name,
model_year,
ROUND(list_price,2) AS product_price

from 

{{source("databird_final_case","products")}}
