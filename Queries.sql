--Creating buffer of 1km for each school
create or replace view city_school_buffer as 
select id, city, ST_Buffer(ST_Transform(wkb_geometry,3857),1000) as school_buffer from city_schools;


--Counting number of fast food centers in each 
create or replace view city_fastfood_view as
(select s.id, s.city, s.school_buffer,count(*) as count_of_fastfood from city_fastfood as f, city_school_buffer as s
 where st_contains(st_transform(s.school_buffer,4326),f.wkb_geometry)
 group by s.id, s.city, s.school_buffer
 order by count_of_fastfood desc
);