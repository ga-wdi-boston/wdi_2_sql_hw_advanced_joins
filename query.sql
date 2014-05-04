\c blog

-- 1. How many comments has each user made per category?

SELECT users.login, categories.name, COUNT(categories.name) AS comments_count
  FROM users
    INNER JOIN comments ON comments.author_id = users.id
    INNER JOIN posts ON comments.post_id = posts.id
    INNER JOIN categories ON posts.category_id = categories.id
  GROUP BY users.login, categories.name
  ORDER BY users.login;


-- 2. Get a listing of all posts grouped by year

SELECT extract(year from posts.created_at) AS year, posts.title
  FROM posts
  ORDER BY year;

-- 3. How many comments does each user have across all of their posts?

SELECT users.login, COUNT(*) AS total_comments
  FROM users
    INNER JOIN posts ON posts.author_id = users.id
    INNER JOIN comments ON comments.post_id = posts.id
  GROUP BY users.login;

-- 4. Which posts contain a specific keyword?

SELECT posts.title
  FROM posts
  WHERE posts.content ILIKE '%on%';

-- 5. Which category of post has each user made the most comments on?

SELECT content FROM comments ORDER BY comments.login DESC;

-- 6. Get a specific user's posts sorted by date of most recent comment.

SELECT users.login, posts.title, posts.content, posts.category_id, comments.id, comments.created_at FROM users, posts, comments WHERE users.id = posts.author_id AND
posts.id = comments.post_id AND  users.login = 'Ethan'
ORDER BY comments.created_at DESC;

-- 7. Get all posts by a specific user which that user themselves has *not* commented on, but which have at least one comment.

WITH comments_on_user_posts AS (
  SELECT users.id AS user_id,
      posts.id AS post_id,
      posts.title AS post_title,
      comments.author_id AS comment_author_id
    FROM users
      INNER JOIN posts ON posts.author_id = users.id
      INNER JOIN comments ON comments.post_id = posts.id
    WHERE users.login = 'Ethan'
)
SELECT DISTINCT post_title
  FROM comments_on_user_posts
  WHERE post_id NOT IN (
    SELECT DISTINCT post_id
      FROM comments_on_user_posts
      WHERE user_id = comment_author_id
  );

-- 8. Get the top 5 most-commented-on posts that were created in the last 7 days.

SELECT posts.title, COUNT(*) AS comments_count
  FROM posts
    INNER JOIN comments ON comments.post_id = posts.id
  WHERE posts.created_at > current_date - 7
  GROUP BY posts.title, posts.created_at
  ORDER BY posts.created_at;


-- 9. Get the top 5 wordiest posts, in terms of character count.

SELECT posts.title, char_length(posts.content) AS characters
  FROM posts
  ORDER BY characters DESC
  LIMIT 5;

-- 10. Get a listing of all posts sorted by longest-running comment thread (length of time between the first and last comments).

SELECT posts.title, (MAX(comments.created_at) - MIN(comments.created_at)) AS runtime
  FROM posts
    INNER JOIN comments ON comments.post_id = posts.id
  GROUP BY posts.title
  ORDER BY runtime DESC;
