libname Chinook "C:\Users\cxie\Desktop\BRT-master\Extra_dataset";run;
proc sql;
select distinct t.name, sum(Quantity) as sold
from chinook.invoice_items as i, chinook.tracks as t, chinook.customers as c, chinook.inovoices as a
where t.trackid = i.trackid
 and i.invoiceid = a.invoiceid
 and c.customerid = a.customerid
group by t.name
having supportrepid = 3
;
quit;
run;
proc sql;
select g.name
from chinook.genres as g, chinook.tracks as t, chinook.invoice_items as i
where t.genreid = g.genreid
 and t.trackid=i.trackid
 group by g.name
 having sum(quantity)>100;
quit;
run;
proc sql;
select distinct e.employeeid as empployee_nbr, e.firstname, e.lastname, sum(total) as total_sales
from chinook.employees as e, chinook.invoices as i, chinook.customers as c
where i.customerid=c.customerid
 and e.employeeid=c.supportrepid
 and c.country= 'USA'
group by e.employeeid, e.firstname, e.lastname
having sum(total)>150
order by 4 desc
;
quit;
run;
proc sql;
select distinct a.employeeid as empployee_nbr, a.firstname, a.lastname, sum(total) as total_sales
from chinook.employees as e, chinook.invoices as i, chinook.customers as c, chinook.employees as a
where i.customerid = c.customerid
 and c.supportrepid = e.employeeid
 and e.reportsto = a.employeeid
 and c.customerid > 25
group by a.employeeid, a.firstname, a.lastname
order by 4
;
quit;
run;
proc sql;
select distinct g.name as genre
from chinook.playlists as p, chinook.playlist_track as t, chinook.tracks as a, chinook.genres as g
where p.playlistid = t.playlistid
 and t.trackid = a.trackid
 and a.genreid = g.genreid
 and g.name like 'classical%'
;
quit;
run;
proc sql;
select distinct p.name
from chinook.playlists as p, chinook.genres as g, chinook.playlist_track as t, chinook.tracks as f
where p.playlistid = t.playlistid
 and t.trackid = f.trackid
 and lowcase(g.name) contains ('rock')
 and lowcase(g.name) NOT contains ('pop')
 ;
 quit;
 run;
 proc sql;
select distinct e.employeeid as empployee_nbr, e.firstname ||e.lastname as name, e.city, count(supportrepid) as customer_nbr
from chinook.employees as e join chinook.customers as c
 on e.employeeid=c.supportrepid
 group by 1,2,3
 ;
 quit;
 run;
proc sql;
select distinct a.name
from chinook.artists as a, chinook.albums as b, chinook.tracks as t, chinook.invoices as i, chinook.invoice_items as s
where b.artistid = a.artistid
 and t.albumid = b.albumid
 and i.invoiceid = s.invoiceid
 having i.customerid = 1 & 2
 ;
 quit;
 run;
 proc sql;
select distinct t.trackid, t.name, sum(quantity*i.unitprice) as sales
from  chinook.tracks as t left join chinook.invoice_items as i
on t.trackid=i.trackid
group by t.trackid
;
quit;
run;
proc sql;
select distinct m.name, t.name
from chinook.tracks as t, chinook.media_types as m, chinook.invoice_items as s, chinook.invoices as i
where t.trackid = s.trackid
and i.invoiceid = s.invoiceid
and i.customerid<>33;
having sum(quantity*s.unitprice)>1 
quit;
run;


