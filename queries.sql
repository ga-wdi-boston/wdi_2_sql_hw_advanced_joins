\c hw_joins

-- 1. Get posts containing a specific keyword (e.g. "about").
-- USE PARTIAL STRINGS, ILIKE
SELECT * FROM posts ILIKE '%on%'

-- 2. Get a listing of all posts grouped by year.
-- ORDER BY desc?
-- GROUP BY
SELECT EXTRACT(YEAR FROM created_at), count(*)
  FROM posts
  GROUP BY EXTRACT(YEAR FROM created_at)
  ORDER BY EXTRACT(YEAR FROM created_at) DESC;

-- 3. Get the top 5 wordiest posts by character count.
SELECT title, LENGTH(content) FROM posts
  ORDER BY LENGTH(content) DESC LIMIT(5);

-- 4. Find how many comments each user has across all of their posts.
SELECT p.title, p.author_id, count(p.*), count(c.*)
  FROM
    users u JOIN posts p
      ON u.id = p.author_id
      JOIN comments c
        ON p.id = c.post_id
      GROUP BY p.author_id;

-- 5. Get a specific user's posts sorted by date of most recent comment.


-- 6. Find how many comments each user has made per post category.


-- 7. Get the 5 most-commented-on posts that were created in the last 7 days.


-- 8. Get the 5 posts with the longest-running comment threads
--    (longest time between first and last comments).
-- DATE RANGES
 SELECT DATEDIFF(DAY MIN(created_at), MAX(created_at))
  FROM posts
  WHERE post_id = 1;

-- 9. Get all posts by a specific user that have comments,
--    but which that user hasn't commented on.
-- AKA POSTS WHERE POSTER HASNT COMMENTED, USE TRANSACTIONS
SELECT u.login, p.title, c. FROM users u, posts p WHERE u.id = p.author_id;






-- 10. Find which category of post each user has made the most comments on.
