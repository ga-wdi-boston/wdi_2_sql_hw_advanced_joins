\c hw_joins

-- 1. Get posts containing a specific keyword (e.g. "about").
SELECT * FROM posts WHERE content ILIKE '%about%';

-- 2. Get a listing of all posts grouped by year.

select date_part('year', created_at), posts
  from posts
  group by date_part('year', created_at), posts;
-- 3. Get the top 5 wordiest posts by character count.
select * from posts ORDER BY LENGTH(content) LIMIT 5;

-- 4. Find how many comments each user has across all of their posts.
select u.login, count(c.*) AS num_comments_user
  from users u
  left join posts p
  on u.id = p.author_id
  left join comments c
  on p.id = c.post_id
  group by u.login
  order by num_comments_user DESC;

-- 5. Get a specific user's posts sorted by date of most recent comment.
select posts.title, MAX(comments.created_at) from users
  inner join posts
  on posts.author_id = users.id
  inner join comments
  on comments.post_id = posts.id
  where users.login = 'Jill'
  group by posts.title
  order by MAX(comments.created_at) desc;


-- 6. Find how many comments each user has made per post category.
select users.login, categories.name, count(comments.*)
  from users
  inner join comments
  on comments.author_id = users.id
  inner join posts
  on comments.post_id = posts.id
  inner join categories
  on posts.category_id = categories.id
  group by categories.name, users.login
  order by users.login;


-- 7. Get the 5 most-commented-on posts that were created in the last 7 days.
select posts.title, count(comments.*)
  from posts
  inner join comments
  on comments.post_id = posts.id
  where posts.created_at > current_date - 7
  group by posts.title
  order by count(comments.*) DESC
  LIMIT 5;


-- 8. Get the 5 posts with the longest-running comment threads
--    (longest time between first and last comments).
select posts.title, MAX(comments.created_at) - MIN(comments.created_at) AS difference
  from posts
  inner join comments
  on comments.post_id = posts.id
  group by posts.title
  order by difference desc
  LIMIT 5;


-- 9. Get all posts by a specific user that have comments,
--    but which that user hasn't commented on.
select posts.title
  from users
  left join posts
  on users.id = posts.author_id
  inner join comments
  on comments.post_id = posts.id
  where users.login = 'George'
  and comments.author_id <> posts.author_id
  group by posts.title;


-- 10. Find which category of post each user has made the most comments on.
select users.login, categories.name
  from users
  inner join comments
  on comments.author_id = users.id
  left join posts
  on users.id = posts.author_id
  inner join categories
  on posts.category_id =  categories.id
  group by users.login, categories.name;



