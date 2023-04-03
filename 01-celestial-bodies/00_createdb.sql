-- vim: set ft=postgresql:
CREATE DATABASE universe;

-- connect to the database with \c universe
-- then create al 4 tables
CREATE TABLE
    IF NOT EXISTS galaxy (galaxy_id SERIAL PRIMARY KEY);

CREATE TABLE
    IF NOT EXISTS star (star_id SERIAL PRIMARY KEY);

CREATE TABLE
    IF NOT EXISTS planet (planet_id SERIAL PRIMARY KEY);

CREATE TABLE
    IF NOT EXISTS moon (moon_id SERIAL PRIMARY KEY);

-- each table should have a name column

ALTER TABLE Users
ADD COLUMN games_played INT NOT NULL DEFAULT (0);
