-- 1. Get posts containing a specific keyword (e.g. "about").
SELECT * FROM posts WHERE content ILIKE '%about%';

-- 2. Get a listing of all posts grouped by year.
SELECT id, content, EXTRACT(year FROM created_at) AS yyyy FROM posts GROUP BY 1,2 ORDER BY created_at;

-- 3. Get the top 5 wordiest posts by character count.
SELECT length(content), content FROM posts ORDER BY length(content) DESC LIMIT 5;

--4. Find how many comments each user has across all of their posts.
SELECT posts.author_id, count(comments.*) AS num_comments_on_posts
FROM posts
LEFT JOIN comments
ON posts.author_id = comments.post_id
GROUP BY posts.author_id
ORDER BY num_comments_on_posts DESC;

-- FOR BELOW, TRYING TO INCLUDE LOGIN NAME IF THAT IS EASIER TO READ
-- SELECT posts.author_id, users.login, count(comments.*) AS num_comments_on_posts
-- FROM posts, users
-- LEFT JOIN comments
-- ON posts.author_id = comments.post_id
-- GROUP BY users.login
-- ORDER BY num_comments_on_posts DESC;

-- DON'T UNDERSTAND ERROR FOR BELOW: "posts.author_id" must appear in the GROUP BY clause or be used in an aggregate function
-- SELECT posts.author_id, count(comments), users.login
-- FROM posts, comments, users
-- WHERE posts.author_id = comments.post_id
-- GROUP BY users.login;

-- 5. Get a specific user's posts sorted by date of most recent comment.


-- 6. Find how many comments each user has made per post category.


-- 7. Get the 5 most-commented-on posts that were created in the last 7 days.


-- 8. Get the 5 posts with the longest-running comment threads
--    (longest time between first and last comments).


-- 9. Get all posts by a specific user that have comments,
--    but which that user hasn't commented on.


-- 10. Find which category of post each user has made the most comments on.
