libname chinook "C:\Users\cxie\Desktop\BRT-master\Extra_dataset";run;
proc sql;
select distinct c.lastname || c.firstname
from chinook.invoices as a, chinook.customers as b, chinook.employees as c
where  a.customerid = b.customerid
  and b.supportrepid = c.employeeid
  and a.total >= all(select a.total from chinook.invoices as a)
  and invoicedate > '01Jan2009'd

group by c.employeeid
;
quit;
run;
proc sql outobs=5;
select a.name
from chinook.tracks as a, chinook.invoice_items as b
where a.trackid = b.trackid
group by a.trackid
order by b.unitprice*b.quantity desc
;
quit;
run;
proc sql;
select USA_Total, Non_USA_Total
(case when country = "USA" then select sum(b.total) as USA_Total
      else select sum(b.total) as Non_USA_Total
	  end) as Total
from chinook.customers as a, chinook.invoices as b
where a.customerid = b.customerid
group by a.country
;
quit;
run;

proc sql;
select a.country
from chinook.customers as a, chinook.invoices as b
where a.customerid = b.customerid
    and b.total>= all(select b.total from chinook.invoices as b)
group by a.customerid
;
quit;
run;
proc sql;
select a.customerid, sum(b.total) as sales
from chinook.customers as a, chinook.invoices as b
where a.customerid = b.customerid
group by a.customerid
having sum(b.total) > (select 0.8*max(sum(b.total)) 
                   from chinook.customers as a, chinook.invoices as b
                   where a.customerid = b.customerid
                   group by a.customerid)

;
quit;
run;
proc sql;
select employeeid, floor(YRDIF(datepart(birthdate), today(),"AGE")) as Age
from chinook.employees
where birthdate < (select birthdate from chinook.employees where title = "General Manager")
;
quit;
run;

proc sql;
select b.trackid, b.name
from chinook.invoice_items as a, chinook.tracks as b, chinook.albums as c, chinook.artists as d
where a.trackid = b.trackid
  and b.albumid = c.albumid
  and c.artistid = d.artistid
  and d.name = "Alanis Morissette"
group by b.trackid
having count(*)> (select count(*) 
                  from chinook.invoice_items as a, chinook.tracks as b, chinook.albums as c, chinook.artists as d
				  where a.trackid = b.trackid
  and b.albumid = c.albumid
  and c.artistid = d.artistid
  and d.name = "Aerosmith"
  )
;
quit;
run;
proc sql;
select trackid
from chinook.tracks
where length(name)<(select length(name)
     from chinook.tracks
	 where scan(lowcase(composer),1) = 'a')
group by trackid
;
quit;
run;

