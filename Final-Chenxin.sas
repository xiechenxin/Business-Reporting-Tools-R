libname chinook "C:\Users\cxie\Desktop\BRT-master\Extra_dataset"; run;
proc sql;
select c.firstname || c.lastname as name, sum(a.total) as Highest_Sales
from chinook.invoices as a, chinook.customers as b, chinook.employees as c, 
where a.customerid = b.customerid
   and b.supoprtrepid = c.employeeid
   and year(datepart(invoicedate))= 2011
group by c.employeeid, month(datepart(invoicedate)) as month
having sum(a.total)>= all (select max(sum(d.total)) 
                           from chinook.invoices as d, chinook.customers as e, chinook.employees as f, 
						   where d.customerid = e.customerid
                             and e.supoprtrepid = f.employeeid
                             and year(datepart(invoicedate))= 2011
                             group by c.employeeid, month(datepart(invoicedate)) as month)
order by 2 desc
;
quit;
run;

proc sql;
create table Albums as
select distinct b.albumid, b.title as Album_Name, c.name as Genre_Name, sum(milliseconds)/(1000*60) as Duration_By_Minute
from chinook.tracks as a inner join chinook.albums as b
     on a.albumid = b.albumid
     inner join chinook.genres as c
	 on a.genreid = c.genreid
group by 1,3
having count(c.name) = 1
;
quit;
run;

proc sql;
select a.trackid, count(c.customerid) as Count
from chinook.tracks as a, chinook.invoice_items as b, chinook.invoices as c
where a.trackid = b.trackid
  and b.invoiceid = c.invoiceid
group by 1
;
quit;
run;

proc sql;
select country, count(customerid) as nbr_customers
from chinook.customers
where lowcase(lastname) like ("s%")
group by country
order by country
;
quit;
run;

proc sql;
select a.customerid, Location, sum(total)as Total_sales
from (select customerid, 
        case when a.country = "USA" then "USA"
        else "Non-USA"
	    end as Location
      from chinook.customers) as l,
	 chinook.customers as a, chinook.invoices as b, 
where a.customerid = b.customerid
group by 1,2
having sum(total) > (select 0.8*max(sales)
                     from (select sum(total)as sales
				        from chinook.customers as c, chinook.invoices as d
						where c.customerid = d.customerid
						group by c.customerid )
				   	)
order by 1  
;
quit;
run;

proc sql;
select c.firstname, c.lastname, type
from chinook.employees as a inner join chinook.customers as b
    on a.city = b.city
	(select *
	 case when *** then "customer"
   else "employee"
   end as type
     from chinook.customers) as c
where lowcase(a.title) contains "manager"
;
quit;
run;
