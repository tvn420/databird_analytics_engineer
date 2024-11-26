{% docs sales_by_store %}

This query calculate performances made by store and staff aggregated to the month

dimensions :

store_id,
store_name,
city,
state,
staff_id,
staff_name,
manager_name,
order_date_year_month

metrics calculated :

| metric                        | description                                                                     |
| ----------------------------- | ------------------------------------------------------------------------------- |
| order_id_count                | Count of sales made by store manager (by month)                                 |
| staff_total_sales_avg         | Mean of sales by store manager                                                  |
| staff_total_sales_m           | Amount of sales made by staff and by store (by month)                           |
| staff_total_sales_m_1         | Amount of sales made by staff and by store                                      |
| total_sales_evolution         | Difference beetween current sales made in amount and sales made last month      |
| total_sales_evolution_percent | Difference beetween current sales made in amount and sales made last month in % |

{% enddocs %}

{% docs customers_analysis %}

The query returns informations about customer's history and personal information 

dimensions :

*order_date_year_month
*order_at
*customer_id
*customer_name
*customer_address
*customer_city
*customer_state
*customer_zip_code
*customer_email
*customer_phone
*favorite_product_id
*favorite_product_name
*brand_name
*order_id
*product_id
*product_name

Numerics dimensions:

*quantity
*product_price
*order_items_total_price

metrics calculated :

| metric                   | description                                              |
| ------------------------ | -------------------------------------------------------- |
| last_order_at_diff_month | Difference in months between current date and last order |

{% enddocs %}
