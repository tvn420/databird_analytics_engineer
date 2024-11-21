SELECT 

product_id,
product_name,
b.brand_id,
brand_name,
p.category_id,
category_name

FROM 

{{ref('stg_products')}} p 
LEFT JOIN {{ref('stg_category')}} c ON p.category_id = c.category_id
LEFT JOIN {{ref('stg_brands')}} b ON p.brand_id = b.brand_id
 