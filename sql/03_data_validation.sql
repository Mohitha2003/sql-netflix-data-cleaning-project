- validate again

select * from netflix_titles_copy 
where (type is null or type ='')
and (title is null or title ='')
and(director is null or title='')
and(cast is null or cast='')
and(country is null or country='');

select * from netflix_titles_copy;