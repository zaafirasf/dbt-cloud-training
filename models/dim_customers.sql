{{

    config (
        materialized='table'
    )
}}

with orders as (

  select 
      id as order_id,
      user_id as customer_id,
      order_date,
      status

  from `dbt-tutorial.jaffle_shop.orders`

),

customer_orders as (

  select 
      customer_id, 
      min(order_date) as first_order_date,
      max(order_date) as most_recent_order_date,
      count(order_id) as number_of_orders
  
  from orders

  group by 1
), 

customers as (

  select
      id as customer_id, 
      first_name, 
      last_name
    
  from `dbt-tutorial.jaffle_shop.customers`

),

final as (

  select
      cu.customer_id,
      cu.first_name, 
      cu.last_name, 
      co.first_order_date, 
      co.most_recent_order_date,
      coalesce(co.number_of_orders, 0) as number_of_orders
      
  from customers cu

  left join customer_orders co using (customer_id)

)

select * from final order by customer_id asc