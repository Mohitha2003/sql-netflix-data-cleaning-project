
-- NETFLIX_TITLES_COPY ANALYSIS--

-- explorating data analysis

use cleaningData;
select * from netflix_titles_copy;

--  Movies vs TV Shows 

with type as(
select type ,count(*) from netflix_titles_copy group by type
), 
type1 as(
select country,type ,count(*)as total from netflix_titles_copy   group by country,type order by country asc limit 5)

select * from type1;

-- Movies and TV Shows count by country

select country ,
sum(case when type="Movie" then 1 else 0 end) as Movies,
sum(case when type="TV Show" then 1 else 0 end) as Tv_show
from netflix_titles_copy
group by country order by country asc;

-- movies or shows released BY year

select release_year,
sum(case when type ="Movie" then 1 else 0 end) as movies,
sum(case when type="TV Show" then 1 else 0 end) as tv_shows
from netflix_titles_copy
group by release_year
order by release_year asc;

-- TOP content-rating movies and shows

select type,rating,count(*) as content_count from netflix_titles_copy where rating is not null
 group by type, rating order by content_count desc limit 5;

-- Bottom content-rating movies and shows

select type,rating,count(*) as Content_Count from netflix_titles_copy where rating is not null
group by type,rating order by Content_Count asc limit 5;

-- Top countries producing netflix content(MOVIES AND TV SHOWS)
select country,movie_count from(
select country,count(*) as movie_count ,dense_rank() over( order by count(*) desc) as top_countries_movies from netflix_titles_copy 
 where type="Movie" group by country) as n  
where top_countries_movies<=5;
 
select country,type,tvshow_count from(
select country,count(*) as tvshow_count,type,dense_rank() over(order by count(*) desc) as top_countries_shows from netflix_titles_copy 
where type="TV Show" group by country) as n  
where top_countries_shows<=5;

-- Longest movie duration
select *  from netflix_titles_copy where type="Movie"
order by cast(replace(duration,'min','')as unsigned) desc limit 5;

-- Longest TVshow duration
select *  from netflix_titles_copy where type="TV Show" 
order by cast(replace(replace(duration,'Seasons',''),'Season','')as unsigned) desc limit 5;

-- Top 5 directors based on number of movies they directed
select director,movie_count from(
select director,count(*)as movie_count, dense_rank() over( order by count(*) desc) as top_director from netflix_titles_copy where type="Movie" group by director)n 
where top_director<=5;

