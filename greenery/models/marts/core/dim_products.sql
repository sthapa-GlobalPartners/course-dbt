{{
  config(
    materialized='table'
  )
}}

with productcte as

( 
select product_id, name, price, inventory
from {{ref('stg_postgres_products')}}
),
orderitemcte as
(
select order_id, product_id
from {{ref('stg_postgres_order_items')}}
),
ordercte as
(
select order_id, user_id
from {{ref('stg_postgres_orders')}}
)

select p.product_id, p.name, p.price, p.inventory, o.order_id, o.user_id
from productcte p 
left join orderitemcte oi on p.product_id = oi.product_id
left join ordercte o on oi.order_id = o.order_id
where o.order_id is not null 