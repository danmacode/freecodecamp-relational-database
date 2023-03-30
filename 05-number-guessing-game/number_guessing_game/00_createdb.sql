-- vim: set ft=postgresql:
--
-- this script creates & populates the db; should be run only once
/* 
 * Creates database and deletes the last one
 */
--DROP DATABASE IF EXISTS number_guess;
-- access with psql ... \c number_guess
CREATE DATABASE number_guess;

/* 
 * The table names are your choice: Users & Games
 */
CREATE TABLE IF NOT EXISTS
    Users (user_id SERIAL PRIMARY KEY);

-- Your database should allow usernames that are 22 characters
ALTER TABLE Users
ADD COLUMN username VARCHAR(22) NOT NULL UNIQUE;

CREATE TABLE IF NOT EXISTS
    Games ();

ALTER TABLE Games
ADD COLUMN game_id SERIAL PRIMARY KEY;

/* ALTER TABLE Games
 * ADD COLUMN user_id INT REFERENCES Users (user_id); 
 * Although I used: https://www.cockroachlabs.com/blog/sql-add-constraint/
 */
-- We used ADD COLUMN user_id INT NOT NULL, but any REFERENCE to a FOREIGN KEY that's
-- also a SERIAL PRIMARY KEY will be NOT NULL by Transitive Property of Equality...
ALTER TABLE Games
ADD COLUMN user_id INT NOT NULL;

ALTER TABLE Games
ADD CONSTRAINT users_fk FOREIGN KEY (user_id) REFERENCES Users (user_id);

ALTER TABLE Games
ADD COLUMN guesses_num INT NOT NULL DEFAULT (0);

-- Users (user_id, username)
-- Games (game_id, user_id, guesses_num)
/* 
 * I might change this and directly add games_total in Users TABLE
 *
 * PSQL commands: 
 *
 * SELECT * FROM Users;
 *  user_id |      username      
 * ---------+--------------------
 *        1 | user_1680128321083
 *        2 | user_1680128321082
 *
 * SELECT * FROM Games;
 *  game_id | user_id | guesses_num 
 * ---------+---------+-------------
 *        1 |       4 |         660
 *        2 |       4 |         549
 */
