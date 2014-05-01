\c blog

INSERT INTO users (user_name, password)
  VALUES ('lplesko', 'pw123'),
  ('clafontant', 'pw456'),
  ('dfisher', 'pw789'),
  ('agrant', 'pw023');

INSERT INTO categories (name)
  VALUES ('Web Design'),
  ('Programming'),
  ('UX Development'),
  ('Javascript'),
  ('Class Happenings');

-- CREATE BLOG POSTS

WITH first_insert (author, title, created_at, content, category) AS   --if created at defaults, do not need to include here
  (VALUES
    ('lplesko', 'Twitter Bootstrap', '2014-04-21', 'This is a great layout template.', 'Web Design'),
    ('lplesko','Database Tips and Tricks', '2014-04-24', 'Content for this blog post.', 'Programming'),
    ('dfisher','Hackathon this weekend!', '2014-04-27', 'Everyone head to the Internet of Things.', 'Class Happenings')
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
    ('clafontant', 'Twitter Bootstrap', '2014-04-22', 'I look forward to using this for my next layout.'),
    ('agrant','Database Tips and Tricks', '2014-04-26', 'Nobody actually ever does this.'),
    ('lplesko','Hackathon this weekend!', '2014-04-27', 'Sounds fun, I plan on attending!')
    )
INSERT INTO comments
  (user_id, post_id, created_at, content)
SELECT
  users.id, posts.id, second_insert.created_at::date, second_insert.content
FROM
  users JOIN second_insert ON second_insert.author = users.user_name
                JOIN posts ON second_insert.title = posts.title;
          -- JOIN categories ON second_insert.category = categories.name;








