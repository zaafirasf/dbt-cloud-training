with source as (
    
    select * from {{ source ('stripe', 'payment')}}

),

staged as (

    select 

        id as payment_id, 
        orderid as order_id,
        paymentmethod as payment_method, 
        status as status,
        {{ cents_to_dollars('amount', 4) }} as amount,
        created as created_at, 
        _batched_at as batched_at

    from source

)

select * from staged