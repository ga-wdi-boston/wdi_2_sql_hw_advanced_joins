\c blog

-- 1. My posts sorted by date

SELECT posts.title, users.user_name, posts.created_at, posts.content, categories.name
  FROM users, posts, categories
  WHERE posts.created_at >= current_date - interval '7 days';




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
