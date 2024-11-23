select
    staff_id,
    sum(staff_total_sales_m) as total_amount
from {{ ref('mrt_sales_by_store') }}
group by 1
having total_amount < 0