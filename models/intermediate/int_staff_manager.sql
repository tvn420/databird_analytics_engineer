WITH query_manager_staff AS (

SELECT

staff_id,
staff_first_name as first_name_manager,
staff_last_name as last_name_manager

FROM 

{{ref('stg_staffs')}}

),

query_staff AS (

SELECT

staff_id,
staff_first_name ,
staff_last_name,
staff_email,
staff_phone,
active,
manager_id,

FROM 

{{ref('stg_staffs')}}

)



select 
s.staff_id,
s.staff_first_name,
s.staff_last_name,
s.staff_email,
s.staff_phone,
s.active,
m.staff_id as manager_id,
first_name_manager,
last_name_manager

from query_staff s left join query_manager_staff m on s.manager_id = m.staff_id