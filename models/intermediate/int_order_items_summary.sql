with src as (
    select order_id, customer_id, order_date, order_status,
    Sum(gross_item_sales_amount) as gross_sales_amount,
    Sum(item_discount_amount) as total_discount_amount,
    Sum(item_net_amount) as net_sales_amount,
    Sum(item_tax_amount) as total_tax_amount,
    Sum(total_item_amount) as total_order_amount,
    count(1) as item_count,
    count_if(is_returned) as returned_item_count
    from {{ ref('int_order_items') }}
    group by order_id, customer_id, order_date, order_status
)

select *
from src
