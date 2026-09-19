{% snapshot snp_customers %}

{{
    config(
      target_schema='snapshots',
      unique_key='customer_id',
      strategy='check',
      check_cols=['address', 'phone_number', 'account_balance', 'market_segment']
    )
}}

select * from {{ ref('stg_tpch__customer') }}

{% endsnapshot %}