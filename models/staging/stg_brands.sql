select

brand_id,
COALESCE(brand_name,'Other') AS brand_name 

FROM 

{{source("databird_final_case","brands")}}