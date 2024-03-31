{{
  config(
    materialized='table'
  )
}}

with usercte as

(select user_id, 
first_name, 
last_name, 
email, 
phone_number,
created_at, 
updated_at, 
address_id
from {{ref('stg_postgres_users')}}
)
, addresscte as
(select address_id, 
address, 
zipcode, 
state, 
country

from {{ref('stg_postgres_addresses')}}
)

select u.user_id, 
u.first_name, 
u.last_name, 
u.email, 
u.phone_number,
u.created_at, 
u.updated_at, 
u.address_id, 
a.address, 
a.zipcode, 
a.state, 
a.country
from usercte u
left join addresscte a on u.address_id = a.address_id