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
