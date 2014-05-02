-- How many comments has each user made per category?
-- Get a listing of all posts grouped by year.
-- How many comments does each user have across all of their posts?
-- Which posts contain a specific keyword?
-- Which category of post has each user made the most comments on?
-- Get a specific user's posts sorted by date of most recent comment.
-- Get all posts by a specific user that have comments, but which that user hasn't commented on.
-- Get the top 5 most-commented-on posts that were created in the last 7 days.
-- Get the top 5 wordiest posts (just by character count – don't actually count words).
-- Get all posts sorted by longest-running comment thread (time between first and last comments).

\c blog
\echo 'number of posts per author: '
SELECT author_id, count(*) FROM posts GROUP BY author_id ORDER BY author_id;

\echo 'Which posts contain the word ipsum?'
SELECT * FROM posts WHERE body LIKE '%ipsum%';


\echo 'this doesnt work yet'
SELECT count(*) FROM users WHERE users.id = comments.author_id;

\echo 'Comments per user per category: '
-- SELECT users.username AS commenter, categories.name AS category_name, COUNT(users.username) FROM users
SELECT users.username, categories.name, count(*)
 FROM comments, users, categories
  WHERE comments.author_id = users.id
  GROUP BY users.username, categories.name;


SELECT users.username, categories.name, COUNT(categories.name)
  FROM users
    INNER JOIN comments ON comments.author_id = users.id
    INNER JOIN posts ON comments.post_id = posts.id
    INNER JOIN categories ON posts.category_id = categories.id
    GROUP BY users.username, categories.name
    ORDER BY users.username;

SELECT date_part('year', posts.created_at)
  FROM posts
  GROUP BY date_part('year', posts.created_at);

SELECT users.username, posts.title, posts.category_id, comments.body, comments.author_id FROM users, posts
  WHERE users.id = posts.author_id
    AND posts.id = comments.post_id
    AND users.username = 'Terri'
    ORDER BY comments.created_at DESC;







