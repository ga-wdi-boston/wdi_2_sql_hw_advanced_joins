\c blog

-- -- How many comments has each user made
-- -- per category?
  -- SKIPPED TEMPORARILY


-- Get a listing of all posts grouped by year.
  -- SKIPPED TEMPORARILY

-- How many comments does each user have across
-- all of their posts?
  -- SKIPPED TEMPORARILY

-- Which posts contain a specific keyword?
-- SELECT *
--   FROM posts
--   WHERE title LIKE '%Potter%'

-- Which category of post has each user made the
-- most comments on?



-- Get a specific users posts sorted by date of
-- most recent comment.
-- SELECT u.login, p.title, p.content, p.category_id, c.content, c.created_at
--   FROM  users u, posts p, comments c
--   WHERE u.id = p.author_id
--   AND p.id = c.post_id
--   AND u.login = 'Jack' ORDER BY c.created_at DESC


-- Get all posts by a specific user which that
-- user themselves has not commented on, but
-- which have at least one comment.
-- SELECT u.login, p.author_id, p.title, c.author_id, c.id, c.post_id
--   FROM users u, posts p, comments c
--   WHERE u.id = p.author_id
--   AND p.id = c.post_id
--   AND u.login = 'Jill'
--   AND p.author_id <> c.id

-- Get the top 5 most-commented-on posts that
-- were created in the last 7 days.

-- Get the top 5 wordiest posts, in terms of
-- character count.

-- Get a listing of all posts sorted by
-- longest-running comment thread (length of
-- time between the first and last comments).
