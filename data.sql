\c blog

INSERT INTO users (user_name, password)
  VALUES ('lplesko', 'pw123'),
  ('clafontant', 'pw456'),
  ('dfisher', 'pw789'),
  ('agrant', 'pw023'),
  ('kvotolato', 'pw934'),
  ('egould', 'pw766'),
  ('mtalley', 'pw332'),
  ('amcdermott', 'pw245'),
  ('gstraehle', 'pw114'),
  ('kmccarthy', 'pw119'),
  ('tdyer', 'pw228');

INSERT INTO categories (name)
  VALUES ('Web Design'),
  ('Programming'),
  ('UX Development'),
  ('Javascript'),
  ('Class Happenings'),
  ('Miscellaneous');

-- CREATE BLOG POSTS

WITH first_insert (author, title, created_at, content, category) AS   --if created at defaults, do not need to include here
  (VALUES
    ('lplesko', 'Web Dev Programs', '2013-06-01', 'Testing 1-2-3.', 'Programming'),
    ('lplesko', 'Web Dev Programs', '2013-06-10', 'Evaluating the pros and cons of dev bootcamps.', 'Programming'),
    ('kmccarthy', 'Boston-bound', '2013-07-01', 'I am moving to Boston from San Francisco in the spring; any advice?','Miscellaneous'),
    ('clafontant', 'General Assembly Open House', '2013-07-10', 'On Friday, I attended the WDI open house at General Assembly to learn about their upcoming program.', 'Programming'),
    ('lplesko', 'Web Dev Programs, continued', '2013-07-23', 'Excited to announce that I will be joining General Assembly in the April 2014 section - time to start my prework.', 'Programming'),
    ('lplesko', 'Twitter Bootstrap', '2014-04-21', 'This is a great layout template.', 'Web Design'),
    ('lplesko','Database Tips and Tricks', '2014-04-24', 'Here is a list of helpful tips I found when working with databases.', 'Programming'),
    ('dfisher','Hackathon this weekend!', '2014-04-27', 'Everyone head to the Internet of Things.', 'Class Happenings'),
    ('egould','Great time at the Hackathon', '2014-04-28', 'My project won!', 'Class Happenings'),
    ('kvotolato','Weekend', '2014-04-28', 'I attended the cardboard game jam, I highly recommend it!', 'Class Happenings'),
    ('tdyer','Working with parent and child classes', '2014-04-30', 'Below is an exercise with car lots to better demonstrate how to work with classes in Ruby.', 'Programming'),
    ('dfisher','Waffle recipes', '2014-05-01', 'Anyone have a good recipe for two gallons of waffles?', 'Class Happenings')
    )
INSERT INTO posts
  (user_id, title, created_at, content, category_id)
SELECT
  users.id, first_insert.title, first_insert.created_at::date, first_insert.content, categories.id   --grabbing these things for the end
FROM
  users JOIN first_insert ON first_insert.author = users.user_name
          JOIN categories ON first_insert.category = categories.name;


-- CREATE COMMENTS

WITH second_insert (author, title, created_at, content) AS
  (VALUES
    ('dfisher', 'Web Dev Programs', '2013-06-14', 'Join General Assemblys 12-week WDI program'),
    ('agrant', 'Web Dev Programs', '2013-06-15', 'I am amazed what students can learn in three months what I learned in three years.'),
    ('dfisher', 'Boston-bound', '2013-07-02', 'Yes - join General Assembly.'),
    ('kvotolato', 'Web Dev Programs', '2013-09-20', 'Hi Lisa, I will be joining, too!'),
    ('clafontant', 'Twitter Bootstrap', '2014-04-22', 'I look forward to using this for my next layout.'),
    ('agrant','Database Tips and Tricks', '2014-04-26', 'Nobody actually ever does this.'),
    ('gstraehle','Database Tips and Tricks', '2014-04-27', 'I have a helpful tip: do not set a date to February 30!'),
    ('lplesko','Hackathon this weekend!', '2014-04-27', 'Sounds fun, I plan on attending!'),
    ('egould','Hackathon this weekend!', '2014-04-29', 'I just picked up my ticket, I can not wait to attend.'),
    ('amcdermott','Waffle recipes', '2014-05-01', 'I will bring strawberries!!'),
    ('tdyer','Waffle recipes', '2014-05-02', 'Gluten, all you need is gluten!')
    )
INSERT INTO comments
  (user_id, post_id, created_at, content)
SELECT
  users.id, posts.id, second_insert.created_at::date, second_insert.content
FROM
  users JOIN second_insert ON second_insert.author = users.user_name
                JOIN posts ON second_insert.title = posts.title;
          -- JOIN categories ON second_insert.category = categories.name;








