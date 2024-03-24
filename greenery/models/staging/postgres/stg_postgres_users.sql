{{ config(materialized='table') }}
Select user_id,
FIRST_NAME,
LAST_NAME,
EMAIL,
PHONE_NUMBER,
created_at,
updated_at,
ADDRESS_ID
 
 from {{source('postgres','Users')}}