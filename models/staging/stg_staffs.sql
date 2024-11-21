SELECT

staff_id,
first_name AS staff_first_name,
last_name AS staff_last_name,
email AS staff_email,
phone AS staff_phone,
active,
store_id ,
CAST(CASE WHEN manager_id = 'NULL' THEN NULL ELSE manager_id END AS INT) AS manager_id

FROM 

{{source("databird_final_case","staffs")}}