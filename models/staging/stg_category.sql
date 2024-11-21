SELECT 

category_id,
COALESCE(category_name, 'Other') AS category_name

FROM 

{{source("databird_final_case","categories")}}