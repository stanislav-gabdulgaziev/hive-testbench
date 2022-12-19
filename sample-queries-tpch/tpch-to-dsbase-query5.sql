select ss.ss_sold_time_sk,  sum(ss.ss_net_paid) ss_net_paid, sum(ss.ss_sales_price) ss_sales_price  
from store_sales ss 
GROUP by ss.ss_sold_time_sk
HAVING sum(ss_net_paid)> 10000
limit 5;