with customers as (

    select * from {{ ref('stg_tpch__customer') }}

),

orders as (

    select * from {{ ref('fct_orders') }}

),

customer_orders as (

    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(distinct order_id) as number_of_orders,
        sum(net_sales_amount) as lifetime_value

    from orders
    group by 1

),

final as (

    select
        c.customer_id,
        c.customer_name,
        c.address,
        c.nation_id,
        c.phone_number,
        c.account_balance,
        c.market_segment,
        co.first_order_date,
        co.most_recent_order_date,
        coalesce(co.number_of_orders, 0) as number_of_orders,
        coalesce(co.lifetime_value, 0) as lifetime_value

    from customers c
    left join customer_orders co
        on c.customer_id = co.customer_id

)

select * from final