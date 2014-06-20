-- Jake Austin
--GA WDI Boston June
-- June 19, 2014
\c hw_joins
-- 1. Get posts containing a specific keyword (e.g. "about").
SELECT title FROM posts WHERE content ILIKE '%about%';

-- 2. Get a listing of all posts grouped by year.
--  These are in descending order but not actually grouped by year
--  According to David the fix is wierd, he will show me tomorrow
SELECT p.title, extract(year from created_at) AS year
  FROM posts p
  ORDER BY year;

-- 3. Get the top 5 wordiest posts by character count.
SELECT p.title, length(p.content) as length
  FROM posts p
  ORDER BY length DESC LIMIT 5;

-- 4. Find how many comments each user has across all of their posts.
SELECT u.login, COUNT(c.*)
  FROM users u, posts p, comments c
  WHERE c.post_id = p.id AND p.author_id = u.id
  GROUP BY u.login;

-- 5. Get a specific user's posts sorted by date of most recent comment.
--   For George, one post gets reported TWICE - David said to debug tomorrow
-- rewrite with inner joins (might fix cartesian error)
SELECT DISTINCT p.title, c.created_at
  FROM users u, posts p, comments c
  WHERE u.login = 'Jill' AND p.author_id = u.id AND c.post_id = p.id
  ORDER BY c.created_at DESC;

-- 6. Find how many comments each user has made per post category.
SELECT u.login, ca.name, COUNT(c.*)
  FROM users u
  INNER JOIN comments c
    on c.author_id = u.id
  LEFT JOIN posts p
    on c.post_id = p.id
  LEFT JOIN categories ca
    on p.category_id = ca.id
  GROUP BY u.login, ca.name
  ORDER BY u.login;

-- 7. Get the 5 most-commented-on posts that were created in the last 7 days.
SELECT p.title, COUNT(c.*)
  FROM posts p
  INNER JOIN comments c
    on c.post_id = p.id
  WHERE p.created_at > current_date - 7
  GROUP BY p.title
  ORDER BY COUNT(c.*)
  DESC LIMIT 5;

-- 8. Get the 5 posts with the longest-running comment threads
--    (longest time between first and last comments).
SELECT p.title, max(c.created_at) - min(c.created_at) AS runtime
  FROM posts p
  INNER JOIN comments c
    on c.post_id = p.id
  GROUP BY p.title
  ORDER BY runtime
  DESC LIMIT 5;

-- 9. Get all posts by a specific user that have comments,
--    but which that user hasn't commented on.

-- totally not working
SELECT u.login, p.title
  FROM  posts p, users u, comments c
    WHERE p.author_id = u.id AND c.post_id = p.id AND c.author_id != u.id
  GROUP BY u.login, p.title;




-- 10. Find which category of post each user has made the most comments on.
