with customers as (
    select * from {{ref ('stg_customers') }}
),

orders as (
    select * from {{ref ('stg_orders')}}
),

payments as (
    select * from {{ref('stg_payments')}}
),

customer_orders as (
  select
      customer_id,
      min(order_date) as first_order_date,
      max(order_date) as most_recent_order_date,
      count(order_id) as number_of_orders, 
      sum(py.amount) as lifetime_value
  from orders
  left join payments py using (order_id)
  group by 1
),

final as (
  select
      cu.customer_id,
      cu.first_name,
      cu.last_name,
      co.first_order_date,
      co.most_recent_order_date,
      coalesce(co.number_of_orders, 0) as number_of_orders, 
      co.lifetime_value
  from customers cu
  left join customer_orders co using (customer_id)
)

select * from final order by customer_id asc