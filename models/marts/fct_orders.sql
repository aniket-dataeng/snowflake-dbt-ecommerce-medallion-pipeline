{{ config(materialized = 'incremental', unique_key = 'order_id') }}

with src as (
    select o.order_id, o.customer_id,
            o.order_date, o.order_status, o.order_priority, o.clerk_name, o.ship_priority,
            iois.gross_sales_amount, iois.total_discount_amount, iois.net_sales_amount, iois.total_tax_amount, iois.total_order_amount, 
            iois.item_count, iois.returned_item_count,
            iois.returned_item_count > 0 as is_order_returned
    from {{ref('stg_tpch__orders')}} o inner join {{ref('int_order_items_summary')}} iois
    on o.order_id = iois.order_id
)

select *
from src