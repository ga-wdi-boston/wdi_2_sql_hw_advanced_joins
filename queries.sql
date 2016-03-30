\c hw_joins

-- 1. Get posts containing a specific keyword (e.g. "about").

SELECT * FROM posts WHERE content ILIKE '%about%';


-- 2. Get a listing of all posts grouped by year.

SELECT EXTRACT(YEAR FROM created_at) AS year , title, content FROM posts ORDER BY year DESC;

-- 3. Get the top 5 wordiest posts by character count.
SELECT title, length(content) AS characters FROM posts ORDER BY char_length(content) DESC LIMIT 5;

-- 4. Find how many comments each user has across all of their posts.
SELECT users.login, count(comments) AS total_comments
  FROM comments, posts, users
  WHERE comments.post_id = posts.id AND posts.author_id = users.id
  GROUP BY users.id;

-- 5. Get a specific user's posts sorted by date of most recent comment.
SELECT * FROM (SELECT DISTINCT ON (posts.title) posts.title, comments.created_at AS most_recent_comment
  FROM posts, comments, users
  WHERE comments.post_id = posts.id AND posts.author_id = users.id AND users.login = 'Jill') AS tmp
  ORDER BY tmp.most_recent_comment DESC;

-- 6. Find how many comments each user has made per post category.
SELECT users.login, categories.name, count(comments) AS comments_count
  FROM comments, posts, users, categories
  WHERE comments.post_id = posts.id AND posts.author_id = users.id AND posts.category_id = categories.id
  GROUP BY users.login, categories.name
  ORDER BY users.login;

-- 7. Get the 5 most-commented-on posts that were created in the last 7 days.
SELECT posts.title, count(comments) AS comments_count, posts.created_at
  FROM posts, comments
  WHERE comments.post_id = posts.id AND posts.created_at > now() - '7 days' :: interval
  GROUP BY posts.title, posts.created_at
  ORDER BY posts.created_at;

-- 8. Get the 5 posts with the longest-running comment threads
--    (longest time between first and last comments).
SELECT posts.title, (max(comments.created_at) - min(comments.created_at)) AS runtime
  FROM posts, comments
  WHERE comments.post_id = posts.id
  GROUP BY posts.title
  ORDER BY runtime DESC LIMIT 5;

-- 9. Get all posts by a specific user that have comments,
--    but which that user hasn't commented on.
SELECT DISTINCT posts.title
  FROM posts, comments, users
  WHERE comments.post_id = posts.id AND posts.author_id = users.id AND comments.author_id != users.id AND users.login = 'George';

-- 10. Find which category of post each user has made the most comments on.

SELECT users.login, categories.name, count(comments) AS comments_count
  FROM users, categories, comments, posts
  WHERE comments.post_id = posts.id AND posts.author_id = users.id AND posts.category_id = categories.id
  GROUP BY users.login, categories.name
  ORDER BY users.login;


-- 6,9,10 not matching up perfectly


