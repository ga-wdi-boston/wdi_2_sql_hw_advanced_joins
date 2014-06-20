\c hw_joins

-- 1. Get posts containing a specific keyword (e.g. "about").
SELECT title FROM posts WHERE content ILIKE '%about%';

-- 2. Get a listing of all posts grouped by year.
SELECT title, EXTRACT (YEAR FROM created_at) FROM posts
  ORDER BY EXTRACT (YEAR FROM created_at);

-- 3. Get the top 5 wordiest posts by character count.
SELECT title FROM posts ORDER BY char_length(content) DESC LIMIT 5;

-- 4. Find how many comments each user has across all of their posts.
SELECT users.login, COUNT(*)
  FROM users, comments, posts
  WHERE users.id = posts.author_id AND posts.id = comments.post_id
  GROUP BY users.login;

-- 5. Get a specific user's posts sorted by date of most recent comment.
SELECT posts.title, users.login, comments.created_at
  FROM users, posts, comments
  WHERE users.id = posts.author_id AND posts.id = comments.post_id AND users.id = 5
  ORDER BY comments.created_at DESC;

  --doesnt eliminate duplicate posts (records for each comment)

-- 6. Find how many comments each user has made per post category.
SELECT users.login, categories.name, COUNT(*)
  FROM categories, users, posts, comments
  WHERE users.id = comments.author_id AND comments.post_id = posts.id AND posts.category_id = categories.id
  GROUP BY users.login, categories.name
  ORDER BY users.login;

-- 7. Get the 5 most-commented-on posts that were created in the last 7 days.
SELECT posts.title, COUNT(*)
  FROM comments, posts
  WHERE posts.created_at >= current_date - interval '7 days' AND posts.id = comments.post_id
  GROUP BY posts.title
  ORDER BY COUNT(*) DESC
  LIMIT 5;

-- 8. Get the 5 posts with the longest-running comment threads
--    (longest time between first and last comments).

-- 9. Get all posts by a specific user that have comments,
--    but which that user hasn't commented on.


SELECT users.login, posts.title FROM users
  LEFT OUTER JOIN posts
  ON (users.id = posts.author_id)
    LEFT OUTER JOIN comments
    ON (posts.id = comments.post_id)
      WHERE users.id = 13 AND comments.author_id != users.id;

  --doesnt eliminate multiple comments on same post


-- 10. Find which category of post each user has made the most comments on.

