libname chinook "C:\Users\cxie\Desktop\BRT-master\Extra_dataset"; run;
proc sql;
select count (title)
from chinook.employees
where title like "%Manager%"
;
quit;
run;
proc sql;
select count(distinct title)
from chinook.albums
where title like "%Disc 2%"
;
quit;
run;
proc sql;
select (count (distinct trackid)/count(distinct invoiceid))
from chinook.invoice_items
;
quit;
run;
proc sql;
select count(distinct customerid),country
from chinook.customers
where postalcode^="0"
group by country
order by country asc
;
quit;
proc sql;
select sum(total)
from chinook.invoices
;
quit;
run;
proc sql;
select sum(total),datepart(mm, invoicedate)as month
from chinook.invoices
;
quit;
run;
proc sql;
select count(invoiceid)/count(distinct customerid),customerid
from chinook.invoices
where date_format(invoicedate, '%y'='09')&date_format(invoice, '%m'='APR')
group by customerid
;
quit;
run;
proc sql;
select yrdif(birthdate,today(),'AGE') as age, yrdif(hiredate, today(),'YEAR') as year
from chinook.employees
where yrdif(birthdate,today(),'AGE')>25
;
quit;
run;
proc sql;
select name
from chinook.playlists
where find_in_set(substring(name,1,1),'B')
;
quit;
run;
proc sql;
select count(distinct customerid), country
from chinook.customers
group by country
;
quit;
run;
proc sql;
select invoiceid, total/sum(total) as percentage
from chinook.invoices
;
quit;
run;





