Part1. dbt Snapshots
2.Which products had their inventory change from week 3 to week 4? 

select *
from DEV_DB.DBT_SIRJANATHAPAGLOBALPCOM.INVENTORY_SNAPSHOT
where 1=1 
and cast(dbt_updated_at as date) >= '4/8/2024'
or cast(dbt_valid_to as date) >='4/8/2024'
order by product_id, dbt_updated_at

PRODUCT_ID	NAME	PRICE	INVENTORY	DBT_SCD_ID	DBT_UPDATED_AT	DBT_VALID_FROM	DBT_VALID_TO
4cda01b9-62e2-46c5-830f-b7f262a58fb1	Pothos	30.5	0	c5dbb6dec8b9da112b5a58543df790ca	2024-04-06 16:52:37.690	2024-04-06 16:52:37.690	2024-04-13 18:51:52.726
4cda01b9-62e2-46c5-830f-b7f262a58fb1	Pothos	30.5	20	cee5e9509cbf24b509df379d3ccb3d93	2024-04-13 18:51:52.726	2024-04-13 18:51:52.726	null
55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3	Philodendron	45	15	1007629770802cc9c3c5e6cecb9df9ef	2024-04-06 16:52:37.690	2024-04-06 16:52:37.690	2024-04-13 18:51:52.726
55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3	Philodendron	45	30	07119d84a19a83b70b2e38eb5c27d3f2	2024-04-13 18:51:52.726	2024-04-13 18:51:52.726	null
689fb64e-a4a2-45c5-b9f2-480c2155624d	Bamboo	15.25	44	7c0e655adda69067ed0af2b152acaa5e	2024-04-06 16:52:37.690	2024-04-06 16:52:37.690	2024-04-13 18:51:52.726
689fb64e-a4a2-45c5-b9f2-480c2155624d	Bamboo	15.25	23	7508fcfe98aea1896c0d703fe74e6830	2024-04-13 18:51:52.726	2024-04-13 18:51:52.726	null
b66a7143-c18a-43bb-b5dc-06bb5d1d3160	ZZ Plant	25	53	03455c7c41d7df72da5316ec165cf7f3	2024-04-06 16:52:37.690	2024-04-06 16:52:37.690	2024-04-13 18:51:52.726
b66a7143-c18a-43bb-b5dc-06bb5d1d3160	ZZ Plant	25	41	0d9281ba8eb9f47ababa8acd7096ab4f	2024-04-13 18:51:52.726	2024-04-13 18:51:52.726	null
be49171b-9f72-4fc9-bf7a-9a52e259836b	Monstera	50.75	50	d39e12af6ea4408804ed5fc2f07e4af5	2024-04-06 16:52:37.690	2024-04-06 16:52:37.690	2024-04-13 18:51:52.726
be49171b-9f72-4fc9-bf7a-9a52e259836b	Monstera	50.75	31	7403f19d6b867d3c94cdfffdccfeb49d	2024-04-13 18:51:52.726	2024-04-13 18:51:52.726	null
fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80	String of pearls	80.5	0	4a643828b0f0edd3c453effdf85926f7	2024-04-06 16:52:37.690	2024-04-06 16:52:37.690	2024-04-13 18:51:52.726
fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80	String of pearls	80.5	10	6386689621b9efe247b482a86d0e320a	2024-04-13 18:51:52.726	2024-04-13 18:51:52.726	null




3.Now that we have 3 weeks of snapshot data, can you use the inventory changes to determine which products had the most fluctuations in inventory? Did we have any items go out of stock in the last 3 weeks? 

select count(*), name
from DEV_DB.DBT_SIRJANATHAPAGLOBALPCOM.INVENTORY_SNAPSHOT
where 1=1
and dbt_valid_to is not null 
group by product_id, name


INVENTORYCHANGESCOUNT	NAME
2	ZZ Plant
2	Bamboo
3	Pothos
3	Philodendron
3	Monstera
3	String of pearls



Question: Did we have any items go out of stock in the last 3 weeks? 

select *
from DEV_DB.DBT_SIRJANATHAPAGLOBALPCOM.INVENTORY_SNAPSHOT
where 1=1
and inventory = 0
order by product_id

PRODUCT_ID	NAME	PRICE	INVENTORY	DBT_SCD_ID	DBT_UPDATED_AT	DBT_VALID_FROM	DBT_VALID_TO
4cda01b9-62e2-46c5-830f-b7f262a58fb1	Pothos	30.5	0	c5dbb6dec8b9da112b5a58543df790ca	2024-04-06 16:52:37.690	2024-04-06 16:52:37.690	2024-04-13 18:51:52.726
fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80	String of pearls	80.5	0	4a643828b0f0edd3c453effdf85926f7	2024-04-06 16:52:37.690	2024-04-06 16:52:37.690	2024-04-13 18:51:52.726



Part2.Modelling challenge

Created fct_product_funnel.sql and updated _product_model.yml file.

select session_id,
    sum(case when event_type = 'page_view' then 1 else 0 end) as page_view,
    sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_cart,
    sum(case when event_type = 'checkout' then 1 else 0 end) as checkout,
    sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_shipped,
from {{ ref('stg_postgres_events')}}
group by session_id


Part3: Reflection questions

if you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step?
Our company has just started using dbt, so now I learned the dbt fundamentals I feel confindent to build the models with logical DAG.



