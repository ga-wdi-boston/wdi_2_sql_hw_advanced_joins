\c hw_joins
-- 1. Get posts containing a specific keyword (e.g. "about").

SELECT * FROM posts WHERE content LIKE '%about%';

-- 2. Get a listing of all posts grouped by year.

SELECT title, EXTRACT (year FROM created_at) FROM posts ORDER BY EXTRACT (year FROM created_at);

-- 3. Get the top 5 wordiest posts by character count.

SELECT title, length(content) FROM posts ORDER BY length(content) DESC LIMIT 5;

-- 4. Find how many comments each user has across all of their posts.

SELECT users.login, COUNT(comments.*)
  FROM users, posts, comments
  WHERE users.id = posts.author_id AND posts.id = comments.post_id
  GROUP BY users.login;

-- 5. Get a specific user's posts sorted by date of most recent comment.

SELECT posts.title, max(comments.created_at) AS most_recent_comment_date
  FROM
    users INNER JOIN posts
      ON users.id = posts.author_id
      INNER JOIN comments
        ON posts.id = comments.post_id
  WHERE users.login = 'Jill'
  GROUP BY posts.title;

-- 6. Find how many comments each user has made per post category.

SELECT DISTINCT users.login, categories.name, COUNT(comments.*) AS comments_count
  FROM
    users INNER JOIN comments
      ON users.id = comments.author_id
      INNER JOIN posts
      ON comments.post_id = posts.id
      INNER JOIN categories
      ON posts.category_id = categories.id

  GROUP BY users.login, categories.name
  ORDER BY users.login;

-- 7. Get the 5 most-commented-on posts that were created in the last 7 days.

SELECT posts.title, COUNT(comments.*) AS comments_count
  FROM
    posts INNER JOIN comments
      ON posts.id = comments.post_id

  WHERE posts.created_at > current_date - interval '7' day

  GROUP BY posts.title
  ORDER BY comments_count DESC LIMIT 5;

-- 8. Get the 5 posts with the longest-running comment threads
--    (longest time between first and last comments).


-- 9. Get all posts by a specific user that have comments,
--    but which that user hasn't commented on.


-- 10. Find which category of post each user has made the most comments on.

-- SELECT users.login, categories.name, COUNT(comments.*)
--   FROM
--     comments INNER JOIN posts
--       ON comments.post_id = posts.id
--       INNER JOIN categories
--         ON posts.category_id = categories.id

--   WHERE









