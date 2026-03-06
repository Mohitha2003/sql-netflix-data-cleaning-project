-- create a copy of this dataset

create table netflix_titles_copy as
select * from netflix_titles;

select * from netflix_titles_copy;
select count(*) from netflix_titles_copy;

-- check duplicates

select* from(
select *,row_number() over(partition by director) as row_num from netflix_titles_copy)n
where row_num>1;

-- check for null values

select title from netflix_titles_copy where  title='' or title is null;
select director from netflix_titles_copy where  director='' or director is null;
select country from netflix_titles_copy where  country='' or country is null;
select cast from netflix_titles_copy where cast='' or cast is null;
select date_added from netflix_titles_copy where  date_added='' or date_added is null;
select release_year from netflix_titles_copy where release_year='' or release_year is null;
select rating from netflix_titles_copy where  rating='' or rating is null;
select duration from netflix_titles_copy where  duration='' or duration is null;
select listed_in from netflix_titles_copy where  listed_in='' or listed_in is null;
select `description` from netflix_titles_copy where  `description`='' or `description` is null;



-- fill the data if it is null or blank

update netflix_titles_copy n1 join
netflix_titles_copy n2 on n1.show_id=n2.show_id
set n1.director=n2.director
where (n1.director is null or n1.director ='')
and n2.director is not null;

update netflix_titles_copy 
set director="unknown"
where director is null or director ='';

update netflix_titles_copy
set cast="unknown"
where cast is null or cast='';

-- fix data types

update netflix_titles_copy
set date_added=str_to_date(date_added ,'%M %d,%Y');

alter table netflix_titles_copy modify date_added date;
desc netflix_titles_copy;

alter table netflix_titles_copy modify release_year int;
