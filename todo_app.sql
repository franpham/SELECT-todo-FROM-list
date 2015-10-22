-- must be connected to another database
\c franpham;

DROP USER IF EXISTS michael;

CREATE USER michael WITH ENCRYPTED PASSWORD 'stonebreaker';

DROP DATABASE IF EXISTS todo_app;

CREATE DATABASE todo_app;

\c todo_app;

DROP TABLE IF EXISTS tasks;

CREATE TABLE tasks (
  id serial UNIQUE PRIMARY KEY,
  title varchar(255) NOT NULL,
  description text NOT NULL,
  created_at timestamp DEFAULT now(),  --added: NOT NULL;
  updated_at timestamp NOT NULL,       --added: DEFAULT now();
  completed boolean DEFAULT false      --replaced with: completed_at;
);

ALTER TABLE tasks DROP COLUMN completed;
ALTER TABLE tasks ADD COLUMN completed_at timestamp;

ALTER TABLE tasks ALTER COLUMN created_at SET NOT NULL;
ALTER TABLE tasks ALTER COLUMN updated_at SET DEFAULT now();

INSERT INTO tasks VALUES (
  DEFAULT, 'Study SQL', 'Complete this exercise'
);

INSERT INTO tasks VALUES (
  DEFAULT, 'Study PostgreSql', 'Read all docs'
);

SELECT title FROM tasks WHERE completed_at IS NULL;

UPDATE tasks SET completed_at = now() WHERE title = 'Study SQL';

SELECT title, description FROM tasks WHERE completed_at IS NULL;

SELECT * FROM tasks ORDER BY created_at DESC;

INSERT INTO tasks VALUES (
  DEFAULT, 'mistake 1', 'test entry 1'
);

INSERT INTO tasks VALUES (
  DEFAULT, 'mistake 2', 'test entry 2'
);

INSERT INTO tasks VALUES (
  DEFAULT, 'mistake 3', 'test entry 3'
);

SELECT title FROM tasks WHERE  title LIKE 'mistake%';

DELETE FROM tasks WHERE title = 'mistake 1';

SELECT description FROM tasks WHERE description LIKE '%entry%';

SELECT * FROM tasks ORDER BY title;
