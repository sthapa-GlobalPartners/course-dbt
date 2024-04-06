Question1:
What is our overall conversion rate? 

0.384452


;with cte1 as --Getting # of unique sessions with a purchase event
(
select count(distinct session_id) Purchased_unique_session, e.order_id--361
from DEV_DB.DBT_SIRJANATHAPAGLOBALPCOM.STG_POSTGRES_EVENTS e
join DEV_DB.DBT_SIRJANATHAPAGLOBALPCOM.STG_POSTGRES_ORDERS o on e.order_id = o.order_id
group by e.order_id
)


, cte2 as --Getting total number of unique sessions
(
select count(distinct session_id) unique_session_id, order_id --361+578 with no orderID
from DEV_DB.DBT_SIRJANATHAPAGLOBALPCOM.STG_POSTGRES_EVENTS
group by order_id
)


, cte3 as
(
select count(Purchased_unique_session) Purchased_unique_session, sum(unique_session_id) unique_session_id  --361/939
from cte2 c2
left join cte1 c1 on c1.order_id = c2.order_id
)


select div0(Purchased_unique_session, unique_session_id)--0.384452
from cte3



Question2:

What is our conversion rate by product?


;with cte1 as --the # of unique sessions with a purchase event of that product


(
select count(distinct e.session_id) session_id, ot.product_id--30
from DEV_DB.DBT_SIRJANATHAPAGLOBALPCOM.STG_POSTGRES_EVENTS e
left join DEV_DB.DBT_SIRJANATHAPAGLOBALPCOM.STG_POSTGRES_ORDERS o on e.order_id = o.order_id
left join DEV_DB.DBT_SIRJANATHAPAGLOBALPCOM.STG_POSTGRES_ORDER_ITEMS ot on o.order_id = ot.order_id
where ot.order_id is not null
group by ot.product_id
)


, cte2 as --total number of unique sessions that viewed that product



(
select count(distinct e.session_id) session_id2, p.product_id, p.name--30
from DEV_DB.DBT_SIRJANATHAPAGLOBALPCOM.STG_POSTGRES_EVENTS e
left join DEV_DB.DBT_SIRJANATHAPAGLOBALPCOM.STG_POSTGRES_PRODUCTS p on e.product_id = p.product_id
where e.event_type = 'page_view'
group by p.product_id, p.name 



)
select c2.name, div0(c1.session_id, c2.session_id2) conversionrate
from cte1 c1
join cte2 c2 on c1.product_id = c2.product_id
group by c2.name,c1.session_id, c2.session_id2



NAME	CONVERSIONRATE
String of pearls	0.609375
Arrow Head	0.555556
Pilea Peperomioides	0.474576
Jade Plant	0.478261
Money Tree	0.464286
Aloe Vera	0.492308
Bird of Paradise	0.45
Angel Wings Begonia	0.393443
Pink Anthurium	0.418919
Fiddle Leaf Fig	0.5
Monstera	0.510204
Orchid	0.453333
Boston Fern	0.412698
Bamboo	0.537313
Ficus	0.426471
Devil's Ivy	0.488889
Philodendron	0.483871
Alocasia Polly	0.411765
Dragon Tree	0.467742
Majesty Palm	0.492537
Pothos	0.344262
Snake Plant	0.39726
Rubber Plant	0.518519
Spider Plant	0.474576
Peace Lily	0.409091
Ponytail Palm	0.4
ZZ Plant	0.539683
Birds Nest Fern	0.423077
Cactus	0.545455
Calathea Makoyana	0.509434