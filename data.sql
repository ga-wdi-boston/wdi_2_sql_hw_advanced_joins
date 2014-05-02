\c blog

INSERT INTO users (login)
  VALUES
    ('dave'),
    ('alex'),
    ('tom'),
    ('george'),
    ('kathleen'),
    ('ethan'),
    ('mike'),
    ('amanda'),
    ('christine'),
    ('katie'),
    ('lisa');

INSERT INTO categories (name)
  VALUES
    ('Music'),
    ('Books'),
    ('Technology'),
    ('Dating'),
    ('Lifehacks'),
    ('Venture Capital');

-- Create blog posts

WITH temp (login, title, content, category, created_at) AS
(VALUES
  ('ethan', 'Harry Potter and the Philosophers Stone Review', 'It was good.', 'Books', '2012-05-20'),
  ('george', 'Watch A Mariachi Band Perform Zelda Music At A Wedding', 'Impressive.', 'Music', '2014-03-01'),
  ('alex', 'Cant wait to hear the megaman 42 soundtrack', 'Ringy Dingy', 'Music', '2013-05-05'),
  ('mike', 'Short Monsanto and Buy Whole Foods', 'Good Investment', 'Venture Capital', '2011-01-01'),
  ('dave', 'Waffles this Friday for Breakfast', 'Yum', 'Lifehacks', '2014-02-01'),
  ('lisa', 'They are the broked up', 'Good.', 'Dating', '2014-02-14'),
  ('mike', 'Im getting out of this class', 'Pissing me off', 'Lifehacks', '2012-02-01'),
  ('amanda', 'They are the broked up', 'Bad', 'Dating', '2011-01-01'),
  ('tom', 'Harry Potter and the Philosophers Stone Review', 'It was good.', 'Books', '2012-05-20'),
  ('dave', 'Watch A Mariachi Band Perform Zelda Music At A Wedding', 'Impressive.', 'Music', '2014-03-01'),
  ('lisa', 'Cant wait to hear the megaman 42 soundtrack', 'Ringy Dingy', 'Music', '2013-05-05'),
  ('kathleen', 'Short Monsanto and Buy Whole Foods', 'Good Investment', 'Venture Capital', '2011-01-01'),
  ('katie', 'Waffles this Friday for Breakfast', 'Yum', 'Lifehacks', '2014-02-01'),
  ('alex', 'They are the broked up', 'Good.', 'Dating', '2014-02-14'),
  ('mike', 'Im getting out of this class', 'Pissing me off', 'Lifehacks', '2012-02-01'),
  ('lisa', 'They are the broked up', 'Bad', 'Dating', '2011-01-01')
)
INSERT INTO posts
  (author_id, title, content, category_id, created_at)
SELECT
  users.id, temp.title, temp.content, categories.id, temp.created_at::DATE
FROM
  users JOIN temp
    ON temp.login = users.login
    JOIN categories
      ON temp.category = categories.name;

-- Create comments

WITH temp (login, title, content, created_at) AS
(VALUES
  ('george', 'Harry Potter and the Philosophers Stone Review', 'I read it in latin.', '2013-04-17'),
  ('amanda', 'Harry Potter and the Chiuahaha', 'I hope Harry marries Hermonie.', '2011-02-15'),
  ('katie', 'Watch A Mariachi Band Perform Zelda Music At A Wedding', 'Such good. Very music.', '2014-01-01'),
  ('tom', 'This comment made me spit soda everywhere', 'My screen broke', '2010-01-01'),
  ('mike', 'Harry Potter and the Philosophers Stone Review', 'I read it in latin.', '2013-04-17'),
  ('lisa', 'Harry Potter and the Chiuahaha', 'I hope Harry marries Hermonie.', '2011-02-15'),
  ('ethan', 'Watch A Mariachi Band Perform Zelda Music At A Wedding', 'Such good. Very music.', '2014-01-01'),
  ('dave', 'This comment made me spit soda everywhere', 'My screen broke', '2010-01-01'),
  ('tom', 'Harry Potter and the Philosophers Stone Review', 'I read it in latin.', '2013-04-17'),
  ('george', 'Harry Potter and the Chiuahaha', 'I hope Harry marries Hermonie.', '2011-02-15'),
  ('katie', 'Watch A Mariachi Band Perform Zelda Music At A Wedding', 'Such good. Very music.', '2014-01-01'),
  ('kathleen', 'This comment made me spit soda everywhere', 'My screen broke', '2010-01-01')
)
INSERT INTO comments
  (author_id, post_id, content, created_at)
SELECT
  users.id, posts.id, temp.content, temp.created_at::DATE
FROM
  users JOIN temp
    ON temp.login = users.login
    JOIN posts
      ON temp.title = posts.title;
