\c hw_joins

-- 1. Get posts containing a specific keyword (e.g. "about").
SELECT users.login, posts.title, posts.content FROM posts
INNER JOIN users
ON (users.id = posts.author_id)
WHERE content ILIKE '%about%';

-- 2. Get a listing of all posts grouped by year.
SELECT date_part('year', created_at) AS year, count(*) FROM posts
GROUP BY year
ORDER BY year;

SELECT date_part('year', created_at) AS year, content FROM posts
ORDER BY year;


-- 3. Get the top 5 wordiest posts by character count.
select title, content, length(content) AS wordiest FROM posts
ORDER BY wordiest DESC
LIMIT 3;

-- 4. Find how many comments each user has across all of their posts.
select users.login, COUNT(comments.*) as total_comments FROM comments
INNER JOIN posts ON (comments.post_id = posts.id )
INNER JOIN users ON (users.id =  posts.author_id)
GROUP BY users.login
ORDER BY total_comments DESC;

-- 5. Get a specific user's posts sorted by date of most recent comment.
select posts.title, MAX(comments.created_at) as recent_posts FROM comments
INNER JOIN posts ON (comments.post_id = posts.id )
INNER JOIN users ON (users.id =  posts.author_id)
WHERE users.login = 'George'
GROUP BY posts.title
;

-- 6. Find how many comments each user has made per post category.
SELECT users.login, categories.name,COUNT(comments.*) FROM users
INNER JOIN comments ON (comments.author_id = users.id)
INNER JOIN posts ON (posts.id =  comments.post_id)
INNER JOIN categories ON (categories.id = posts.category_id)
group by users.login, categories.name
ORDER BY users.login;
;

-- 7. Get the 5 most-commented-on posts that were created in the last 7 days.
select posts.title, COUNT(comments.*) as total_comments , MAX(comments.created_at) as max_date FROM comments
INNER JOIN posts ON (comments.post_id = posts.id )
GROUP BY posts.title
--HAVING comments.created_at > (current_timestamp - INTERVAL '7 day')::date
;


-- 8. Get the 5 posts with the longest-running comment threads
--    (longest time between first and last comments).
select posts.title, MAX(comments.created_at)-MIN(comments.created_at) as time_diff  FROM comments
INNER JOIN posts ON (comments.post_id = posts.id)
GROUP BY posts.title
ORDER BY time_diff DESC
LIMIT 5
;

-- 9. Get all posts by a specific user that have comments,
--    but which that user hasn't commented on.



-- 10. Find which category of post each user has made the most comments on.

