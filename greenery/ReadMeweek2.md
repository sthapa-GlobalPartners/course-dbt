Q.What is our user repeat rate?
0.798387

--Getting users who purchased
with ordercte as
(
select  user_id, count(distinct order_id) orderID
from DEV_DB.DBT_SIRJANATHAPAGLOBALPCOM.STG_POSTGRES_ORDERS
group by user_id
)
--Getting users who purchsed 2 or more times
,repeatusercte as (
select  user_id
from ordercte
where orderid >=2
)
--Getting the count of both users who purchased and users who purchased 2 or more times
,usercount as 
(
select count(r.user_id) repeatusers, count(o.user_id) totalusercount
from ordercte o
left join repeatusercte r on o.user_id = r.user_id
)

select div0(repeatusers, totalusercount) repeatrate
from usercount

Q.What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
who most likely will purchase again;;;
*Frequency of Order- order multiple times
*Recent Orders
*Different types of product purchased
*Used Promos - will make them attract more to order again.

who most likely not purchase again;;;
*No order made for long period of time
*Less variety of product purchased
*Has not used any promo

If we have records about customer reviews or feedback on their orders, that would add to this analysis. If they had good experience they would write good reviews that means they will most probably be coming back and vice versa for bad experience.

Q.Explain the product mart models you added. Why did you organize the models in the way you did?
dim_products table has all the product details customers had ordered with user_id so that we can add user table if needed for more information on users.
dim_users table has information about users including address table informations.
fct_page_views has informations on how many order was taken place, first order created, last order created and total spend where I pulled data from staging order table and dim user table.
fct_page_views has all the records belongs to page view with order flag which indicate "Y" for users viewed the page and purchased the product and "N" for users viewed the page but didn't make any purchase.

Q.Which products had their inventory change from week 1 to week 2? 
Pothos
Philodendron
Monstera
String of pearls
