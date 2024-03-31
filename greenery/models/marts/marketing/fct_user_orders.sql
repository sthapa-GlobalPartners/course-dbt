{{
  config(
    materialized='table'
  )
}}


with dimusercte as
(
select user_id, 
first_name, 
last_name, 
email, 
phone_number,
created_at, 
updated_at, 
address_id, 
address, 
zipcode, 
state, 
country
from {{ref('dim_users')}}
)
,
ordercte as
(
select order_id, 
user_id, 
created_at, 
order_total
from {{ref('stg_postgres_orders')}}
)

select o.user_id, 
d.first_name, 
d.last_name, 
d.email, 
d.phone_number,
d.created_at, 
d.updated_at, 
d.address_id, 
d.address, 
d.zipcode, 
d.state, 
d.country,
count(o.order_id) ordercount, 
min(o.created_at) first_order_created_at,
max(o.created_at) last_order__created_at,
sum(o.order_total) totalspend
from dimusercte d
left join ordercte o on d.user_id = o.user_id
group by o.user_id, 
d.first_name, 
d.last_name, 
d.email, 
d.phone_number,
d.created_at, 
d.updated_at, 
d.address_id, 
d.address, 
d.zipcode, 
d.state, 
d.country
