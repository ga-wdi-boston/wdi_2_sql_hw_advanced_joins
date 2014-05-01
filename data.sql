\c blog

INSERT INTO users (login, created_at)
  VALUES ('Kelly', '2012-01-22 04:05:00'),
    ('Chris', '2013-01-25 07:28:00'),
    ('Kim', '2012-02-27 08:57:00'),
    ('Jack','2013-02-27 10:37:00'),
    ('Jill', '2012-01-27 13:13:00'),
    ('Went', '2013-01-28 17:12:00'),
    ('Hill', '2012-01-30 21:48:00'),
    ('Fetch', '2014-01-01 23:34:00');

INSERT INTO categories (name)
  VALUES ('Music'),
    ('Books'),
    ('Technology'),
    ('Dating'),
    ('Lifehacks'),
    ('Lifestyle'),
    ('Celebrity'),
    ('Food');

-- Create blog posts

WITH temp (login, title, content, category, created_at) AS
(VALUES
  ('Jill', 'Harry Potter and the Philosophers Stone Review', 'It was good.', 'Books', '2012-03-01 23:34:00'),
  ('Jill', 'Harry Potter and the Chamber of Secrets', 'It was great.', 'Books', '2012-08-27 23:34:00'),
  ('Jill', 'Harry Potter and the Goblet of Fire', 'It was excellent and amazing all in one.', 'Books', '2013-03-18 23:34:00'),
  ('Jill', 'Upcoming Hackathons', 'Can not wait for the next hackaton.', 'Technology', '2013-11-20 23:34:00'),
  ('Kelly', 'Watch A Mariachi Band Perform Zelda Music At A Wedding', 'Impressive.', 'Music', '2013-03-21 23:34:00'),
  ('Chris', 'Harry Potter and the Philosophers Stone Review', 'Looking forward to the next book.', 'Books', '2013-06-28 23:34:00'),
  ('Chris', 'North West', 'Bad name for a child.', 'Celebrity', '2013-10-14 23:34:00'),
  ('Chris', 'Gluten free waffles', 'Where is the fun in that?', 'Food', '2014-01-05 23:34:00'),
  ('Kim', 'Ruby Updates', 'Updating my computer right away.', 'Technology', '2013-02-27 23:34:00'),
  ('Jack', 'How to live a more stress free life', 'Will give these tips a try this weekend', 'Lifehacks', '2013-03-15 23:34:00'),
  ('Jack', 'Harry Potter and the Philosophers Stone Review', 'Best book ever.', 'Books', '2014-01-23 23:34:00'),
  ('Went', 'Justin Timberlake Album Release Party', 'How come no one invited me?', 'Music', '2013-04-01 23:34:00')
)

INSERT INTO posts
  (author_id, title, content, created_at, category_id)
SELECT
  users.id, temp.title, temp.content, temp.created_at::timestamp, categories.id
FROM
  users JOIN temp
    ON temp.login = users.login
    JOIN categories
      ON temp.category = categories.name;

-- Create comments
WITH temp (login, title, content, created_at) AS
(VALUES
  ('Chris','Harry Potter and the Philosophers Stone Review', 'I read it in latin.', '2014-03-01 23:34:00'),
  ('Chris', 'Harry Potter and the Goblet of Fire', 'It was excellent and amazing all in one.', '2014-03-25 23:34:00'),
  ('Jill', 'Watch A Mariachi Band Perform Zelda Music At A Wedding', 'Such good. Very music.', '2013-11-21 23:34:00'),
  ('Jill', 'Justin Timberlake Album Release Party', 'How come no one invited me?', '2013-06-03 23:34:00'),
  ('Jack', 'Upcoming Hackathons', 'Can not wait for the next hackaton.', '2013-12-20 23:34:00'),
  ('Hill', 'Watch A Mariachi Band Perform Zelda Music At A Wedding', 'Such good. Very music.', '2014-02-12 23:34:00'),
  ('Kelly',  'How to live a more stress free life', 'Will give these tips a try this weekend', '2014-03-15 23:34:00'),
  ('Hill', 'Ruby Updates', 'Updating my computer right away.', '2013-10-22 23:34:00'),
  ('Hill', 'Ruby Updates', 'Updating my computer right away.', '2014-01-19 23:34:00'),
  ('Fetch', 'Justin Timberlake Album Release Party', 'How come no one invited me?', '2014-2-11 23:34:00')
)
INSERT INTO comments
  (author_id, post_id, content, created_at)
SELECT
  users.id, posts.id, temp.content, temp.created_at::timestamp
FROM
  users JOIN temp
    ON temp.login = users.login
    JOIN posts
      ON temp.title = posts.title;
