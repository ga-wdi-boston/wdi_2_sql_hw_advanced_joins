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

WITH temp (login, content, title, category) AS
(VALUES
  ('Jill', 'Harry Potter and the Philosophers Stone Review', 'It was good.', 'Books'),
  ('Kelly', 'Watch A Mariachi Band Perform Zelda Music At A Wedding', 'Impressive.', 'Music'),
  ('Jack', 'Just went skiiing with some homies', 'Had a great time in the powder', 'Activities'),
  ('Kim', 'Holy cow, just saw a helicopter land', 'AWESOME!', 'Cool stuff'),
  ('Samantha','Just broke up with Tommy', 'He is a jerk', 'Dating'),
  ('Trevon', 'Yo, who wants to play basketball', 'Basketball anyone?', 'Activities'),
  ('Chris', 'Totally spilled a bunch of milk on my laptop', 'FML', 'Technology'),
  ('Ethan', 'Reading up on the HTML5 for class next week', 'General Assembly prep', 'Books'),
  ('Jill', 'Just finished sewing my holiday sweater', 'Handmade clothes', 'Cool stuff'),
  ('Jack', 'Watching the NHL playoffs on ESPN!', 'NHL playoffs', 'Activities'),
  ('Trevon', 'Bout to hit the club tonight!', 'Saturday night', 'Activities'),
  ('Samantha', 'Dropped my iPhone in the lake the other day', 'I need a new phone', 'Technology')
)
INSERT INTO posts
  (author_id, title, content, category_id)
SELECT
  users.id, temp.title, temp.content, categories.id
FROM
  users JOIN temp
    ON temp.login = users.login
    JOIN categories
      ON temp.category = categories.name;

-- Create comments

WITH temp (login, title, content) AS
(VALUES
  ('Trevon', 'It was good.','Yo I read it in latin!'),
  ('Jack', 'It was good.', 'I hope Harry marries Hermonie.'),
  ('Samantha', 'Impressive.', 'Such good. Very music.'),
  ('Jill', 'I need a new phone', 'Typical Samantha...'),
  ('Ethan', 'NHL playoffs' , 'Nice man, I hope the Bruins win again.'),
  ('Samantha', 'Basketball anyone?' , 'Everyone know you are not a baller.'),
  ('Kim', 'Had a great time in the powder', 'I heard the conditions were perfect.'),
  ('Jack', 'Saturday night', 'Pick me up man!'),
  ('Samantha', 'Impressive.', 'Why would they play that?'),
  ('Chris', 'He is a jerk', 'Did not see that coming.'),
  ('Jill', 'It was good.', 'I hope Harry marries Hermonie.'),
  ('Samantha', 'General Assembly prep', 'Way to go!'),
  ('Trevon', 'General Assembly prep', 'Those are good study habits'),
  ('Chris', 'Had a great time in the powder', 'My sister went skiiing once...'),
  ('Kelly', 'He is a jerk', 'He is not even cool'),
  ('Samantha', 'It was good.', 'I read that too, it was great!'),
  ('Ethan', 'FML', 'Time for an upgrade'),
  ('Trevon', 'I need a new phone', 'I hate when that happens!')
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






