{{
  config(
    materialized='table'
  )
}}


select e.event_id, 
e.session_id, 
e.user_id, 
e.page_url, 
e.created_at, 
e.event_type, 
case when e.event_type ='page_view'and o.order_id is not null then 'Y'
     when e.event_type ='page_view'and o.order_id is null then 'N'
     end as OrderFlag,
u.first_name,
u.last_name,
u.email,
u.phone_number,
u.address_id,
o.order_id,
o.promo_id,
o.created_at as order_created_at,
o.order_cost,
o.shipping_cost,
o.order_total,
o.tracking_id,
o.status
from {{ ref('stg_postgres_events')}} e
left join {{ref('stg_postgres_users')}} u on e.user_id = u.user_id
left join {{ ref('stg_postgres_orders')}} o on u.user_id = o.user_id
where e.event_type = 'page_view'
and o.created_at >= e.created_at