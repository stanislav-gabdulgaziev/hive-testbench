select dd.d_date, c.c_email_address, ss.ss_net_paid, ss.ss_sales_price  
from store_sales ss, customer c, date_dim dd 
where ss.ss_customer_sk = c.c_customer_sk 
and ss.ss_sold_date_sk = dd.d_date_sk 
limit 5;