\c blog

INSERT INTO users (login)
  VALUES
    ('Kelly'),
    ('Chris'),
    ('Kim'),
    ('Jack'),
    ('Jill'),
    ('Went'),
    ('Hill'),
    ('Fetch');

INSERT INTO categories (name)
  VALUES
    ('Music'),
    ('Books'),
    ('Technology'),
    ('Dating'),
    ('Lifehacks'),
    ('climate change'),
    ('pets'),
    ('food'),
    ('Venture Capital');

-- Create blog posts

WITH temp (login, title, content, category, created_at) AS
(VALUES
  ('Jill', 'Harry Potter and the Philosophers Stone Review', 'It was good.', 'Books', '2012-01-01'),
  ('Kelly', 'Watch A Mariachi Band Perform Zelda Music At A Wedding', 'Impressive.', 'Music', '2013-01-01'),
  ('Chris', 'electric cars', 'blah blah', 'climate change', '2010-02-01'),
  ('Kim', 'polar bears', 'I saw a polar bear lose his home.', 'climate change', '2012-01-01'),
  ('Jack', 'why I love dogs', 'My dog loves to cuddle.', 'pets', '2012-01-01'),
  ('Jack', 'corn', 'It should be extinct by now.', 'food', '2012-01-01'),
  ('Jack', 'general electric not as good as toyota', 'Toyota has more respect for employees.', 'Lifehacks', '2012-01-01')
)
INSERT INTO posts
  (author_id, title, content, category_id, created_at)
SELECT
  users.id, temp.title, temp.content, categories.id, temp.created_at::date
FROM
  users JOIN temp
    ON temp.login = users.login
    JOIN categories
      ON temp.category = categories.name;

-- Create comments

WITH temp (login, title, content, created_at) AS
(VALUES
  ('Hill', 'Harry Potter and the Philosophers Stone Review', 'I read it in latin.', '2014-01-05'),
  ('Fetch', 'Harry Potter and the Philosophers Stone Review', 'I hope Harry marries Hermonie.', '2014-01-05'),
  ('Chris', 'polar bears', 'poor bear.', '2014-04-05'),
  ('Chris', 'electric cars', 'i totally want to buy a Tesla now!', '2014-04-27'),
  ('Chris', 'corn', 'who knew we were eating petroleum', '2014-04-21'),
  ('Jack', 'polar bears', 'we have to save them', '2014-04-29'),
  ('Jill', 'polar bears', 'ummm.', '2014-04-05'),
  ('Jill', 'electric cars', 'wow', '2014-04-27'),
  ('Jill', 'corn', 'never want to go to the supermarket again', '2014-04-30'),
  ('Jill', 'general electric not as good as toyota', 'tell me about it', '2014-04-05'),
  ('Jill', 'general electric not as good as toyota', 'you should just leave.', '2014-04-10'),
  ('Kelly', 'corn', 'we should just like, create a special supermarket', '2014-04-28')
)
INSERT INTO comments
  (author_id, post_id, content, created_at)
SELECT
  users.id, posts.id, temp.content, temp.created_at::date
FROM
  users JOIN temp
    ON temp.login = users.login
    JOIN posts
      ON temp.title = posts.title;
