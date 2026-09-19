with src as (
    select md5(cast(o.order_id as varchar) || '-' || cast(li.line_number as varchar)) as order_item_id,
    o.order_id, line_number, customer_id, part_id, supplier_id,
            order_date, order_status, ship_date, commit_date, receipt_date, return_flag, ship_mode,
            quantity, extended_price, discount_percentage, tax_rate,
            extended_price as gross_item_sales_amount,
            extended_price * discount_percentage as item_discount_amount,
            extended_price * (1 - discount_percentage) as item_net_amount,
            item_net_amount * tax_rate as item_tax_amount,
            item_net_amount + item_tax_amount as total_item_amount,
            return_flag = 'R' as is_returned
    from {{ ref('stg_tpch__lineitem') }} li inner join {{ ref('stg_tpch__orders') }} o
    on li.order_id = o.order_id
)

select *
from src