DROP DATABASE IF EXISTS blog;
CREATE DATABASE blog;
\c blog

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  user_name TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  created_at DATE --DEFAULT current_timestamp
);

CREATE INDEX ON users (user_name);

CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  name TEXT UNIQUE
);

CREATE INDEX ON categories (name);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title TEXT,
  created_at DATE,
  content TEXT,
  user_id INTEGER REFERENCES users,
  category_id INTEGER REFERENCES categories
);

CREATE INDEX ON posts (title);
CREATE INDEX ON posts (created_at);

CREATE TABLE comments(
  id SERIAL PRIMARY KEY,
  --title TEXT REFERENCES posts,
  created_at DATE,
  content TEXT,
  user_id INTEGER REFERENCES users,
  post_id INTEGER REFERENCES posts
);





