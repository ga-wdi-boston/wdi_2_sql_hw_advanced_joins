-- WDI SQL Join HW
-- Blair Caple
-- June 19, 2014


-- 1. Get posts containing a specific keyword (e.g. "about").
SELECT title
  FROM posts
  WHERE content ilike '%about%';


-- 2. Get a listing of all posts grouped by year.
SELECT date_part('year', p.created_at) AS year, p.title
  FROM posts p
  ORDER BY year;


-- 3. Get the top 5 wordiest posts by character count.
SELECT title, length(content) AS characters
  FROM posts
  ORDER BY characters DESC
  LIMIT 5;


-- bonus by word count!!
SELECT title, array_length(regexp_split_to_array(content, E'\\s+'), 1) AS words
  FROM posts
  ORDER BY words DESC
  LIMIT 5;


-- 4. Find how many comments each user hAS across all of their posts.
SELECT u.login, COUNT(c.*) AS total_comments
  FROM users u
  INNER JOIN posts p
    ON p.author_id = u.id
  LEFT JOIN comments c
    ON c.post_id = p.id
  GROUP BY u.login
  ORDER BY total_comments DESC;


-- 5. Get a specific user's posts sorted by date of most recent comment.
SELECT u.login, p.title, MAX(c.created_at) AS most_recent_comment
FROM users u
INNER JOIN posts p
  ON p.author_id = u.id
INNER JOIN comments c
  ON c.post_id = p.id
GROUP BY u.login, p.title
ORDER BY u.login, most_recent_comment DESC;


-- 6. Find how many comments each user has made per post category.
SELECT u.login, ca.name, COUNT(co.*) AS total_comments_made
FROM users u
INNER JOIN comments co
  ON co.author_id = u.id
LEFT JOIN posts p
  ON p.id = co.post_id
LEFT JOIN categories ca
  ON ca.id = p.category_id
GROUP BY u.login, ca.name
ORDER BY u.login;


-- 7. Get the 5 most-commented-on posts that were created in the last 7 days.

-- Note: This does not fetch the same records as the instructor's results
-- because the last two posts do not occur within 7 days of each other.
SELECT p.title, COUNT(c.*) AS total_comments
FROM posts p
INNER JOIN comments c
  ON c.post_id = p.id
WHERE p.created_at > (SELECT MAX(p1.created_at) - 7 FROM posts p1)
GROUP BY p.title
LIMIT 5;


-- 8. Get the 5 posts with the longest-running comment threads
--    (longest time between first and lASt comments).
SELECT p.title, MAX(c.created_at) - MIN(c.created_at) AS runtime
FROM posts p
INNER JOIN comments c
  ON c.post_id = p.id
GROUP BY p.title
ORDER BY runtime DESC
LIMIT 5;


-- 9. Get all posts by a specific user that have comments,
--    but which that user hasn't commented on.

-- This does not fetch the same records as the instructor's results!
SELECT u.login, p.title, COUNT(c.*) AS comment_count
FROM users u
INNER JOIN posts p
  ON p.author_id = u.id
INNER JOIN comments c
  ON c.post_id = p.id AND c.author_id != u.id
GROUP BY u.login, p.title
ORDER BY u.login, p.title;

-- This shows the detail underlying the above query
select u1.login, p.title, u2.login as commentor
from users u1
inner join posts p
  on p.author_id = u1.id
inner join comments c
  on c.author_id != u1.id and c.post_id = p.id
inner join users u2
  on u2.id = c.author_id
order by u1.login, p.title;



-- 10. Find which category of post each user has made the most comments on.
SELECT DISTINCT ON (u.login, total_comments_made) u.login, ca.name,
  COUNT(co.*) as total_comments_made
FROM users u
INNER JOIN comments co
  ON co.author_id = u.id
INNER JOIN posts p
  ON p.id = co.post_id
INNER JOIN categories ca
  ON ca.id = p.category_id
GROUP BY u.login, ca.name
ORDER BY u.login, total_comments_made DESC;
