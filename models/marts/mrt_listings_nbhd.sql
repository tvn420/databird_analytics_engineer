{{ config(
    materialized='table',
    tags=['daily']
) }}

select
    neighbourhood_cleansed,
    room_type,
    count(id) as total_listings,
    avg(price) as avg_price,
from {{ ref('stg_listings') }}
group by
    1,2