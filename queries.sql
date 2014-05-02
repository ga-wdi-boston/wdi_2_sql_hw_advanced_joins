\c blog
\echo 'How many comments has each user made per category?'
SELECT users.login, count(*), categories.name
FROM comments, users, categories
WHERE comments.author_id = users.id
GROUP BY users.login, categories.name;

\echo 'Get a listing of all posts grouped by year.'
-- DATA: Multiple years of data
SELECT posts.created_at, posts.id
FROM posts
GROUP BY posts.created_at, posts.id
ORDER BY posts.created_at DESC, posts.id;

\echo 'How many comments does each user have across all of their posts?'
SELECT users.login, count(*) AS num_comments
FROM posts, comments, users
WHERE posts.author_id = users.id
GROUP BY users.login
ORDER BY num_comments DESC, users.login;

\echo 'Which posts contain a specific keyword?'
SELECT posts.id, posts.content
FROM posts
WHERE posts.content
SIMILAR TO '%Wedding%';

\echo 'Which category of post has each user made the most comments on?'
SELECT users.login, count(*) AS the_count, categories.name
FROM comments, users, categories
WHERE comments.author_id = users.id
GROUP BY categories.name, users.login
ORDER BY the_count DESC;

\echo 'Get a specific users posts sorted by date of most recent comment.'
SELECT posts.id, users.login
FROM posts, comments, users
GROUP BY comments.created_at, posts.id
ORDER BY comments.created_at DESC, posts.id;

\echo 'Get all posts by a specific user which that user themselves has not commented on, but which have at least one comment.'

\echo 'Get the top 5 most-commented-on posts that were created in the last 7 days.'
-- DATA: Need data from last 7 days

\echo 'Get the top 5 wordiest posts, in terms of character count.'

\echo 'Get a listing of all posts sorted by longest-running comment thread (length of time between the first and last comments).'
