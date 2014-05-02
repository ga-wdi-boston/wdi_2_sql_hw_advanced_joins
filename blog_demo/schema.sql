-- Blog Database Structure

-- USER
--   login
--   password
--   created_at

-- POST
--   title
--   created_at
--   content
--   author_id
--   category_id

-- COMMENT
--   author_id
--   post_id
--   content
--   created_at

-- CATEGORIES
--   name

-- USER --has_many-> POSTS
-- USER --has_many-> COMMENTS
-- CATEGORY --has_many-> POSTS
-- POSTS --has_many-> COMMENTS

DROP DATABASE IF EXISTS blog;
CREATE DATABASE blog;
\c blog

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username TEXT,
  password TEXT,
  created_at DATE DEFAULT current_timestamp
);

CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  name TEXT
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title TEXT,
  body TEXT,
  created_at DATE,
  author_id INTEGER REFERENCES users,
  category_id INTEGER REFERENCES categories
);

CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  author_id INTEGER REFERENCES users,
  post_id INTEGER REFERENCES posts,
  body TEXT,
  created_at DATE DEFAULT current_timestamp
);
