select max(dd.d_date)  ,  sum(ss.ss_net_paid) ss_net_paid, sum(ss.ss_sales_price) ss_sales_price  
from store_sales ss inner join date_dim dd 
on ss.ss_sold_date_sk = dd.d_date_sk 
GROUP by dd.d_date  
HAVING sum(ss_net_paid)> 10000
order by ss_net_paid DESC
limit 5;