libname chinook "C:\Users\cxie\Desktop\BRT-master\Individual assignment\chinook";run;

proc sql;
create table chinook.track_mix as
select t.trackid as Track_ID, t.name as Track, al.title as Album, ar.name as Artist, g.name as Genre, t.composer as Composer, t.Milliseconds/3600 as Minutes,t.unitprice as Unit_Price 
from chinook.tracks as t, chinook.albums as al, chinook.genres as g, chinook.artists as ar
where t.albumid=al.albumid
  and t.genreid=g.genreid
  and al.artistid= ar.artistid
group by t.trackid
;
quit;
run;
