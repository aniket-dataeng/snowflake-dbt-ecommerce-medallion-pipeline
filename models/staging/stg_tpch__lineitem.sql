with source as (
    select * from {{ source('tpch_sample', 'lineitem') }}
),

renamed as (

    select
        l_orderkey as order_id,
        l_linenumber as line_number,
        l_partkey as part_id,
        l_suppkey as supplier_id,
        l_quantity as quantity,
        cast(l_extendedprice as numeric(16, 2)) as extended_price,
        cast(l_discount as numeric(16, 2)) as discount_percentage,
        cast(l_tax as numeric(16, 2)) as tax_rate,
        l_returnflag as return_flag,
        l_linestatus as line_status,
        cast(l_shipdate as date) as ship_date,
        cast(l_commitdate as date) as commit_date,
        cast(l_receiptdate as date) as receipt_date,
        l_shipinstruct as ship_instructions,
        l_shipmode as ship_mode,
        l_comment as comment

    from source

)

select * from renamed