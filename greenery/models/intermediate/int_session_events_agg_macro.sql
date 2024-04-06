{{
  config(
    materialized='table'
  )
}}

select  session_id, created_at, user_id
{{ event_types ('stg_postgres_events', 'event_type') }}
from {{ ref('stg_postgres_events') }}
group by 1, 2, 3