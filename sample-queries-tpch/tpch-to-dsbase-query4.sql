select max(dd.d_date), count(c.c_email_address), sum(ss.ss_net_paid), sum(ss.ss_sales_price)  
from store_sales ss, customer c, date_dim dd 
where ss.ss_customer_sk = c.c_customer_sk 
and ss.ss_sold_date_sk = dd.d_date_sk 
GROUP by ss.ss_sold_time_sk
limit 5;