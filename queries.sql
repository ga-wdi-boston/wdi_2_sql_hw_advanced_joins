\c hw_joins

-- 1. Get posts containing a specific keyword (e.g. "about").
SELECT * FROM posts
WHERE content LIKE '%about%';

-- 2. Get a listing of all posts grouped by year.
SELECT EXTRACT (YEAR FROM created_at) AS PostYear, posts.title
  FROM posts
  GROUP BY PostYear, posts.title
  ORDER BY PostYear;

--  References:
--    Grab just the year:
--      http://www.w3schools.com/sql/func_extract.asp
--    Group:
--      http://www.tizag.com/sqlTutorial/sqlgroupby.php

-- 3. Get the top 5 wordiest posts by character count.
SELECT CHAR_LENGTH(content) as LengthOfContent, posts.title
  FROM posts
  GROUP BY posts.title, LengthOfContent
  ORDER BY LengthOfContent DESC
  LIMIT 5;

--  References:
--    Length
--      http://www.postgresql.org/docs/8.1/static/functions-string.html

-- 4. Find how many comments each user has across all of their posts.

-- This is calculating the number of comments per post and who wrote the post but posts by the same author need to be merged
SELECT users.login,posts.title,COUNT(Comments.content) AS NumberOfComments
  FROM comments
  LEFT JOIN posts
  ON comments.post_id=posts.id
  LEFT JOIN users
  ON posts.author_id=users.id
  GROUP BY login, title;

-- This is calculating the number of comments per user
SELECT users.login,COUNT(Comments.content) AS NumberOfComments
  FROM comments
  LEFT JOIN users
  ON comments.author_id=users.id
  GROUP BY login;

-- This is calculating the number of posts per category
SELECT categories.name,COUNT(posts.title) AS NumberOfPosts
  FROM posts
  LEFT JOIN categories
  ON posts.category_id=categories.id
  GROUP BY name;


--  References
--    Group by
--      http://www.w3schools.com/sql/sql_groupby.asp
--      http://stackoverflow.com/questions/14995000/sql-inner-join-more-than-two-tables

-- 5. Get a specific user's posts sorted by date of most recent comment.


-- 6. Find how many comments each user has made per post category.


-- 7. Get the 5 most-commented-on posts that were created in the last 7 days.


-- 8. Get the 5 posts with the longest-running comment threads
--    (longest time between first and last comments).


-- 9. Get all posts by a specific user that have comments,
--    but which that user hasn't commented on.


-- 10. Find which category of post each user has made the most comments on.
