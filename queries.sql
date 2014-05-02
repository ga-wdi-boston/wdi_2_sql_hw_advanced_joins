\c blog

\echo '1. How many comments has each user made per category?'


\echo '2. Get a listing of all posts grouped by year.'
  SELECT created_at, count(created_at) FROM posts GROUP BY created_at;

\echo '3. How many comments does each user have across all of their posts?'

\echo '4. Which posts contain a specific keyword?'
  SELECT * FROM posts WHERE content ~*' bear ';

\echo '5. Which category of post has each user made the most comments on?'


\echo '6. Get a specific users posts sorted by date of most recent comment.'


-- This one will give you the most recent comment for a given post...
--  SELECT c.content, c.created_at
--   FROM comments c, posts p
--   WHERE
--   p.id = c.post_id AND
--   p.id = 6
--   ORDER BY c.created_at DESC LIMIT 1;

-- -- ...and this one will give you the posts for a given User, in this case Jack.
-- -- How do I put this together with the other one?
-- SELECT p.title, p.content, c.content, c.created_at FROM posts p, users u, comments c
--  WHERE
--  p.id = c.post_id AND
--  u.id = p.author_id AND
--  u.login = 'Jack';

-- It seems like a double-select query is needed, but I could not find anything
-- in the postgres documentation. I tried looking up "nested" queries,
-- and, believe it or not, that isn't the same thing.

SELECT posts.title, comments.content, comments.created_at FROM posts
  JOIN comments ON comments.post_id = posts.id
  JOIN users ON posts.author_id = users.id
WHERE users.login = 'Jack'
ORDER BY comments.created_at DESC;

\echo '7. Get all posts by a specific user which that user themselves has *not* commented on, but which have at least one comment.'


\echo '8. Get the top 5 most-commented-on posts that were created in the last 7 days.'

\echo '9. Get the top 5 wordiest posts, in terms of character count.'
SELECT * FROM posts ORDER BY char_length(content) DESC LIMIT 5;


\echo '10. Get a listing of all posts sorted by longest-running comment thread (length of time between the first and last comments).'
