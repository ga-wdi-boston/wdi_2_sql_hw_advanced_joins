-- 1. Get posts containing a specific keyword (e.g. "about").
SELECT * FROM posts WHERE content ILIKE '%about%';


-- 2. Get a listing of all posts grouped by year.
SELECT p.content, DATE_PART('year', p.created_at)
  FROM posts p
  ORDER BY DATE_PART('year', p.created_at);

-- 3. Get the top 5 wordiest posts by character count.
SELECT p.content
  FROM posts p
  WHERE Length(p.content) > 5
  ORDER BY Length(p.content) DESC
  LIMIT 5;


-- 4. Find how many comments each user has across all of their posts.
SELECT  u.login, count(c)
  FROM users u, comments c
  WHERE u.id = c.author_id
  GROUP BY u.login;

-- 5. Get a specific user's posts sorted by date of most recent comment.


-- 6. Find how many comments each user has made per post category.


-- 7. Get the 5 most-commented-on posts that were created in the last 7 days.
SELECT p.content, count(c)
  FROM posts p, comments c
  WHERE p.id = c.post_id
  GROUP BY p.content
  ORDER BY count(c) DESC
  LIMIT 5;

-- 8. Get the 5 posts with the longest-running comment threads
--    (longest time between first and last comments).


-- 9. Get all posts by a specific user that have comments,
--    but which that user hasn't commented on.


-- 10. Find which category of post each user has made the most comments on.
