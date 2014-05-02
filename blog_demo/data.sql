\c blog

-------------- DATA --------------

INSERT INTO users (username, created_at)
  VALUES ('Amanda', '2010-04-29'),
  ('Terri', '2003-08-07'),
  ('Ross', '2012-07-12');

INSERT INTO categories (name)
  VALUES ('raves'),
  ('rants'),
  ('nonsensical button-mashing');


------ CREATE POSTS

WITH temp (author, created_at, category, title, body) AS
(VALUES
  ('Terri', '2004-03-05', 'raves', 'Table Flipping', 'Mauris viverra scelerisque mauris. Nulla facilisis, elit malesuada pretium egestas, dolor arcu commodo est, at egestas massa tortor ut ante'),
  ('Amanda', '2004-12-01', 'rants', 'THINGS/STUFF', 'Lorem ipsum porro, voluptas, maiores impedit ad natus aliquid placeat tempora reiciendis minus magni possimus dolorem provident modi rerum odio cumque dolore aspernatur?'),
  ('Ross', '2013-09-17', 'rants', 'Title Pending', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.'),
  ('Amanda', '2014-02-19', 'nonsensical button-mashing', 'Herpderp Redux', 'Aperiam, dolores, tempora, ratione facere quam facilis amet animi odio obcaecati error quo labore eos qui!'),
  ('Terri', '2010-04-29', 'nonsensical button-mashing', 'Ermahgerd Hi', 'Eveniet, ratione, placeat nobis obcaecati culpa voluptates alias deleniti deserunt rem atque totam ipsa animi dolore reprehenderit laboriosam excepturi quidem praesentium laudantium.'),
  ('Amanda', '2009-12-01', 'rants', 'Herpderp', 'Amet, ea, nihil, quasi quis officiis commodi molestias excepturi iusto sunt deserunt debitis ratione ad tempore ullam unde dolor dignissimos a assumenda.')
)
INSERT INTO posts
  (author_id, created_at, category_id, title, body)
SELECT
  users.id, temp.created_at::DATE, categories.id, temp.title, temp.body
FROM
  temp JOIN users
    ON temp.author = users.username
    JOIN categories
      ON temp.category = categories.name;

SELECT * FROM posts;


------- CREATE COMMENTS

WITH temp (author, title, body, created_at) AS
(VALUES
  ('Amanda', 'Table Flipping', 'This is the dumbest post evar.', '2004-05-04'),
  ('Terri', 'Table Flipping', 'No, you are just stupid.', '2004-05-06'),
  ('Amanda', 'Table Flipping', 'No u.', '2004-05-07'),
  ('Terri', 'Table Flipping', 'No, uuuuuuuu.', '2004-05-08'),
  ('Ross', 'Title Pending', 'I apologize in advance for this post.', '2014-01-07'),
  ('Ross', 'Herpderp', 'This is the best thing in the whoel world liekomg', '2009-12-07'),
  ('Terri', 'Herpderp', 'Wat is rong wit u no it isnt', '2009-12-09'),
  ('Amanda', 'Herpderp', 'cmon guise lets just b frendz', '2009-12-16'),
  ('Terri', 'Herpderp', 'im friends w ur mom', '2009-12-17'),
  ('Terri', 'Herpderp', 'REZZING DEAD THREAD LOL', '2014-04-29')
)
INSERT INTO comments
  (author_id, post_id, body, created_at)
SELECT
  users.id, posts.id, temp.body, temp.created_at::DATE
FROM
  temp JOIN users
    ON temp.author = users.username
    JOIN posts
      ON temp.title = posts.title;

SELECT * FROM comments ORDER BY created_at;
