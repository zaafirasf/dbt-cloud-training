select 

    id as payment_id, 
    orderid as order_id,
    paymentmethod as payment_method, 
    amount / 100 as amount,
    created as created_at, 
    _batched_at as batched_at

from dbt-tutorial.stripe.payment