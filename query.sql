\c blog

-- 1. How many comments has each user made per category?


-- 2. Get a listing of all posts grouped by year
--SELECT content FROM posts WHERE created_at > now() - interval '1 year';

-- 3. How many comments does each user have across all of their posts?


-- 4. Which posts contain a specific keyword?
--SELECT * FROM posts WHERE content ILIKE 'was%';

-- 5. Which category of post has each user made the most comments on?
--SELECT content FROM comments ORDER BY comments.login DESC;

-- 6. Get a specific user's posts sorted by date of most recent comment.
--SELECT * FROM posts ORDER BY created_at;

-- 7. Get all posts by a specific user which that user themselves has *not* commented on, but which have at least one comment.
-- SELECT content FROM posts WHERE login = 'Jill'


-- 8. Get the top 5 most-commented-on posts that were created in the last 7 days.


-- 9. Get the top 5 wordiest posts, in terms of character count.
--SELECT content FROM posts ORDER BY content DESC;

-- 10. Get a listing of all posts sorted by longest-running comment thread (length of time between the first and last comments).

