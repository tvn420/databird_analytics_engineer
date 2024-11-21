SELECT

store_id,
coalesce(store_name,'Other') AS store_name,
phone AS store_phone,
email AS store_email,
street AS address,
city,
state,
zip_code

FROM 

{{source("databird_final_case","stores")}}