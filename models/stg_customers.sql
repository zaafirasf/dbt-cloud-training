with customers as (

  select
      id as customer_id, 
      first_name, 
      last_name
    
  from `dbt-tutorial.jaffle_shop.customers`

)

select * from customers order by customer_id asc