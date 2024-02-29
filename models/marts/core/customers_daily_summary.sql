with source as (

    select * from {{ ref ('stg_orders')}}

),

daily_summary as (

    select 
        {{ dbt_utils.generate_surrogate_key(['customer_id', 'order_date'])}},
        customer_id, 
        order_date, 
        count(*)

    from source
    group by 1,2,3
)

select * from daily_summary