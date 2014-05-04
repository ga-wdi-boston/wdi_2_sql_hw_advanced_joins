\c blog

INSERT INTO users (login)
  VALUES
    ('Kelly'),
    ('Chris'),
    ('Kim'),
    ('Jack'),
    ('Jill'),
    ('Samantha'),
    ('Trevon'),
    ('Ethan');

INSERT INTO categories (name)
  VALUES
    ('Music'),
    ('Books'),
    ('Technology'),
    ('Dating'),
    ('Cool stuff'),
    ('Activities');

-- Create blog posts

WITH temp (login, content, title, category, created_at) AS
(VALUES
  ('Jill', 'Harry Potter and the Philosophers Stone Review', 'It was good.', 'Books', '2014-02-09'),
  ('Kelly', 'Watch A Mariachi Band Perform Zelda Music At A Wedding', 'Impressive.', 'Music', '2013-10-05'),
  ('Jack', 'Just went skiiing with some homies', 'Had a great time in the powder', 'Activities', '2014-02-22'),
  ('Kim', 'Holy cow, just saw a helicopter land', 'AWESOME!', 'Cool stuff', '2014-05-01'),
  ('Samantha','Just broke up with Tommy', 'He is a jerk', 'Dating', '2013-11-12'),
  ('Trevon', 'Yo, who wants to play basketball', 'Basketball anyone?', 'Activities', '2014-01-05'),
  ('Chris', 'Totally spilled a bunch of milk on my laptop', 'FML', 'Technology', '2014-04-02'),
  ('Ethan', 'Reading up on the HTML5 for class next week', 'General Assembly prep', 'Books', '2013-11-26'),
  ('Jill', 'Just finished sewing my holiday sweater', 'Handmade clothes', 'Cool stuff', '2013-09-23'),
  ('Jack', 'Watching the NHL playoffs on ESPN!', 'NHL playoffs', 'Activities', '2014-04-20'),
  ('Trevon', 'Bout to hit the club tonight!', 'Saturday night', 'Activities', '2014-03-29'),
  ('Samantha', 'Dropped my iPhone in the lake the other day', 'I need a new phone', 'Technology', '2014-03-17')
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
  ('Trevon', 'It was good.','Yo I read it in latin!', '2014-02-09'),
  ('Jack', 'It was good.', 'I hope Harry marries Hermonie.', '2013-10-05'),
  ('Samantha', 'Impressive.', 'Such good. Very music.', '2014-02-22'),
  ('Jill', 'I need a new phone', 'Typical Samantha...', '2014-05-01'),
  ('Ethan', 'NHL playoffs' , 'Nice man, I hope the Bruins win again.', '2013-11-12'),
  ('Samantha', 'Basketball anyone?' , 'Everyone know you are not a baller.', '2014-01-05'),
  ('Kim', 'Had a great time in the powder', 'I heard the conditions were perfect.', '2014-04-02'),
  ('Jack', 'Saturday night', 'Pick me up man!', '2013-11-26'),
  ('Samantha', 'Impressive.', 'Why would they play that?', '2013-09-23'),
  ('Chris', 'He is a jerk', 'Did not see that coming.', '2014-03-29'),
  ('Jill', 'It was good.', 'I hope Harry marries Hermonie.', '2014-03-17'),
  ('Samantha', 'General Assembly prep', 'Way to go!', '2014-04-02'),
  ('Trevon', 'General Assembly prep', 'Those are good study habits', '2014-05-01'),
  ('Chris', 'Had a great time in the powder', 'My sister went skiiing once...', '2014-04-02'),
  ('Kelly', 'He is a jerk', 'He is not even cool', '2014-05-01'),
  ('Samantha', 'It was good.', 'I read that too, it was great!', '2013-11-12'),
  ('Ethan', 'FML', 'Time for an upgrade', '2014-04-02'),
  ('Trevon', 'I need a new phone', 'I hate when that happens!', '2014-02-22')
)
INSERT INTO comments
  (author_id, post_id, content)
SELECT
  users.id, posts.id, temp.content
FROM
  users JOIN temp
    ON temp.login = users.login
    JOIN posts
      ON temp.title = posts.title;






