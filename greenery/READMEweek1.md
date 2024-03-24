How many users do we have?
130

select count(user_id) from DEV_DB.DBT_SIRJANATHAPAGLOBALPCOM.STG_POSTGRES_USERS

On average, how many orders do we receive per hour?
7.52 

with dailyhourlyorder as
(select count(order_id) count, hour(created_at) created_hr, day(created_at) day
from DEV_DB.DBT_SIRJANATHAPAGLOBALPCOM.STG_POSTGRES_ORDERS
group by day(created_at), hour(created_at))

select avg(count)
from dailyhourlyorder

On average, how long does an order take from being placed to being delivered?
3.89

with avgdeliverydays as
(select order_id, datediff(day, min(created_at), min(delivered_at)) as deliverydays
from DEV_DB.DBT_SIRJANATHAPAGLOBALPCOM.STG_POSTGRES_ORDERS
group by order_id
)

select avg(deliverydays)
from avgdeliverydays

How many users have only made one purchase? Two purchases? Three+ purchases?

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

ONEPURCHASE	TOWPURCHASE	THREEPLPURCHASE
25	28	71

with ordercountcte as
(select user_id, count(order_id) ordercount
from DEV_DB.DBT_SIRJANATHAPAGLOBALPCOM.STG_POSTGRES_ORDERS
group by user_id
)

select count(case when ordercount = 1 then user_id end) as onepurchase,
count(case when ordercount = 2 then user_id end) as towpurchase,
count(case when ordercount >= 3 then user_id end) as threeplpurchase
from ordercountcte

On average, how many unique sessions do we have per hour?
61.2586

with avgsession as
(select count(session_id) sessioncount, day(created_at) createddays, hour(created_at) createdhrperday
from DEV_DB.DBT_SIRJANATHAPAGLOBALPCOM.STG_POSTGRES_EVENTS
group by day(created_at), hour(created_at)
)
select avg(sessioncount)
from avgsession