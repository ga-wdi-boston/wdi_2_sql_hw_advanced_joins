\c blog

-- 1. How many comments has each user made per category?

SELECT users.user_name, categories.name AS category, count(comments.user_id) AS comments_per
  FROM users, posts, categories, comments
  WHERE users.id = comments.user_id AND comments.post_id = posts.id AND posts.category_id = categories.id
  GROUP BY users.user_name, categories.name;

-- 2. Get a listing of all posts grouped by year.

SELECT title, extract(year FROM created_at::DATE) AS year
  FROM posts
  ORDER BY created_at DESC;


-- 3. How many comments does each user have across all of their posts?

SELECT DISTINCT users.user_name, posts.title AS post_title, count(posts.id = comments.post_id) AS comments_on_posts
  FROM posts, users, comments
  WHERE users.id = posts.user_id AND posts.id = comments.post_id
  GROUP BY users.user_name, posts.title;



-- 4. Which posts contain a specific keyword?

SELECT title, content FROM posts WHERE content ILIKE '% the %';
-- SELECT title, content FROM posts WHERE content ~* ' the ';



-- 5.  Which category of post has each user made the most comments on?



-- 6.  Get a specific user's posts sorted by date of most recent comment.

SELECT DISTINCT users.user_name AS post_owner, posts.title, comments.content AS comment, comments.created_at
  FROM posts, users, comments
  WHERE users.id = posts.user_id AND posts.id = comments.post_id
  ORDER BY comments.created_at DESC LIMIT 1;


-- 7. Get all posts by a specific user that have comments, but which that user hasn't commented on.



-- 8. Get the top 5 most-commented-on posts that were created in the last 7 days.

SELECT posts.title, posts.created_at, count(posts.id = comments.post_id) FROM posts
  LEFT OUTER JOIN comments
  ON (posts.id = comments.post_id)
  WHERE (posts.created_at >= current_date - interval '7 days')
  GROUP BY posts.title, posts.created_at LIMIT 5;


-- 9.  Get the top 5 wordiest posts (just by character count – don't actually count words).

--SELECT title, sum(length(content)) AS character_count FROM posts GROUP BY title LIMIT 5;
SELECT title, sum(length(content)) AS character_count FROM posts GROUP BY title ORDER BY character_count DESC LIMIT 5;


-- 10 Get all posts sorted by longest-running comment thread (time between first and last comments).

SELECT posts.title, comments.content, max(comments.created_at)
  FROM posts, comments
  WHERE posts.id = comments.post_id
  GROUP BY posts.title, comments.content;




-- Inner Join
-- SELECT b.id, b.title, b.published_on, a.name, a.birthday
--     FROM authors a, books b
--     WHERE a.id = b.author_id
--     and a.name = 'Stephen King'


-- -- Left joins
-- SELECT books.title, authors.name FROM books
--   LEFT OUTER JOIN authors
--   ON (books.author_id = authors.id);

-- SELECT * FROM books
--   LEFT OUTER JOIN authors
--   ON (books.author_id = authors.id);

-- Right joins

-- Outer joins

-- Full joins
