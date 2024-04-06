{%- macro event_types_by_session(session_id, event_type) -%}

select  {{session_id}} ,count{{(event_type)}}
from {{ ref('STG_POSTGRES_EVENTS')}}
group by {{session_id}}

{%- endmacro -%}





