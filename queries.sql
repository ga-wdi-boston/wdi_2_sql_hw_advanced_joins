\c blog

-- 2. Get a listing of all posts grouped by year.

SELECT title, extract(year FROM created_at::DATE) AS year
  FROM posts
  ORDER BY created_at DESC;




-- 4. Which posts contain a specific keyword?

SELECT title, content FROM posts WHERE content ILIKE '% the %';
-- SELECT title, content FROM posts WHERE content ~* ' the ';


-- 6.  Get a specific user's posts sorted by date of most recent comment.

SELECT users.user_name, posts.title, comments.content, comments.created_at
  FROM posts, users, comments
  WHERE users.id = posts.user_id AND posts.id = comments.post_id
  ORDER BY comments.created_at DESC LIMIT 1;



-- SELECT users.user_name, posts.title
--   FROM posts, users
--   WHERE users.id = posts.user_id;


-- 9.  Get the top 5 wordiest posts (just by character count – don't actually count words).

--SELECT title, sum(length(content)) AS character_count FROM posts GROUP BY title LIMIT 5;
SELECT title, sum(length(content)) AS character_count FROM posts GROUP BY title ORDER BY character_count DESC LIMIT 5;


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
