with dt as (
  select d_date, d_year, d_date_sk  
  from  date_dim dd 
  where d_year > 2001
),
cust as (
  select c.c_email_address, c.c_customer_sk  
  from customer c  
/*  
 where c.c_birth_year >1997 
 */
),
itm as (
  select
  i.i_item_desc , i.i_item_sk 
  from item i 
  where
  i.i_item_sk BETWEEN 60 AND 76
)
select ss.ss_sales_price, dt.d_year, cust.c_email_address , itm.i_item_desc
from store_sales ss ,dt,cust, itm
where ss.ss_sold_date_sk = dt.d_date_sk
and ss.ss_customer_sk = cust.c_customer_sk
and ss.ss_item_sk = itm.i_item_sk
limit 5;