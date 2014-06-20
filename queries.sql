\c hw_joins
-- 1. Get posts containing a specific keyword (e.g. "about").
SELECT * FROM posts WHERE content ILIKE '%about%';

-- 2. Get a listing of all posts grouped by year.
SELECT * FROM posts ORDER BY EXTRACT(year FROM created_at);

-- 3. Get the top 5 wordiest posts by character count.
SELECT * FROM posts ORDER BY LENGTH(content) DESC LIMIT 5;

-- 4. Find how many comments each user has across all of their posts.
SELECT users.id, users.login, count(comments)
  FROM users, comments, posts
  WHERE users.id = posts.author_id AND comments.post_id = posts.id
  GROUP BY users.id
  ORDER BY count(comments) DESC;

-- 5. Get a specific user's posts sorted by date of most recent comment.
SELECT users.login, posts.title, comments.content, comments.created_at
  FROM posts
  LEFT JOIN users ON (posts.author_id = users.id)
  LEFT JOIN comments ON (comments.post_id = posts.id)
  WHERE users.login = 'George'
  ORDER BY comments.created_at DESC;

-- 6. Find how many comments each user has made per post category.
SELECT users.login, count(comments), categories.name
  FROM users, comments, posts, categories
  WHERE users.id = comments.author_id AND
  comments.post_id = posts.id AND
  posts.category_id = categories.id
  GROUP BY categories.name, users.login
  ORDER BY users.login;

-- 7. Get the 5 most-commented-on posts that were created in the last 7 days.
SELECT posts.title, count(comments), posts.created_at
  FROM posts
  LEFT JOIN comments ON (posts.id = comments.post_id)
  WHERE posts.created_at > current_date - integer '7'
  GROUP BY posts.id
  ORDER BY count(comments) DESC
  LIMIT 5;
  -- fun fact: no posts were created in the last seven days
  -- some were created in the future though?
  -- it returned those, in order of comments.

-- 8. Get the 5 posts with the longest-running comment threads
--    (longest time between first and last comments).
SELECT posts.id, posts.title,
  max(comments.created_at) - min(comments.created_at) AS days
  FROM posts, comments
  WHERE posts.id = comments.post_id
  GROUP BY posts.id
  ORDER BY days DESC
  LIMIT 5;

-- 9. Get all posts by a specific user that have comments,
--    but which that user hasn't commented on.

SELECT posts.id, posts.title, posts.content
  FROM users, posts, comments
  WHERE posts.id = comments.post_id
  AND users.id = posts.author_id
  AND users.login = 'George'
  EXCEPT
    SELECT posts.id, posts.title, posts.content
    FROM users, posts, comments
    WHERE users.id = comments.author_id
    AND users.id = posts.author_id
    AND posts.id = comments.post_id;

-- 10. Find which category of post each user has made the most comments on.
SELECT DISTINCT ON (users.login) users.login, categories.name, count(comments)
  FROM users, posts, categories, comments
  WHERE users.id = comments.author_id
  AND comments.post_id = posts.id
  AND posts.category_id = categories.id
  GROUP BY categories.id, users.login
  ORDER BY users.login, count(comments) DESC;
