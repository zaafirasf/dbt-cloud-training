with customers as (
    select * from {{ ref('dim_customers') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

fct_orders as (

    select 
        ord.order_id, 
        cs.customer_id, 
        py.amount
    from orders ord
    left join customers cs using (customer_id)
    left join payments py using (order_id)
    
)

select * from fct_orders