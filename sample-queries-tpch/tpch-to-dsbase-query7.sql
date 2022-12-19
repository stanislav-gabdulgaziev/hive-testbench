select ss.ss_sold_date_sk dt,  sum(ss.ss_net_paid) net_paid, sum(ss.ss_sales_price) sales_price  
from store_sales ss 
GROUP by ss.ss_sold_date_sk 
HAVING sum(ss_net_paid)> 10000
UNION ALL 
select ws.ws_sold_date_sk dt ,  sum(ws.ws_net_paid) net_paid, sum(ws.ws_sales_price) sales_price  
from web_sales ws  
GROUP by ws.ws_sold_date_sk 
HAVING sum(ws_net_paid)> 10000
order by net_paid DESC 
limit 5;