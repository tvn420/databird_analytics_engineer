select
    customer_id,
    max(last_order_at_diff_month) as max_diff_months
from {{ ref('mrt_customers_analysis') }}
group by 1
having max_diff_months < 0