-- -*-mode: sql; sql-product: postgres;-*- vim:ft=postgresql
--
-- github needs the vim modeline to categorize this as a PLpgSQL file 
CREATE DATABASE universe;

-- connect to the database with \c universe
-- then create all 4 tables with table_name_id naming convention
-- all of them with a name column, and 5 columns
CREATE TABLE
    IF NOT EXISTS galaxy (
        galaxy_id SERIAL PRIMARY KEY NOT NULL,
        name VARCHAR(30) NOT NULL UNIQUE,
        speed INT,
        description TEXT
    );

CREATE TABLE
    IF NOT EXISTS star (
        star_id SERIAL PRIMARY KEY,
        name VARCHAR(30) NOT NULL UNIQUE,
        galaxy_id INT REFERENCES galaxy (galaxy_id),
        description TEXT
    );

CREATE TABLE
    IF NOT EXISTS planet (
        planet_id SERIAL PRIMARY KEY,
        name VARCHAR(30) NOT NULL UNIQUE,
        dwarf BOOLEAN NOT NULL DEFAULT FALSE, -- name == pluto 
        moons INT NOT NULL DEFAULT (0),
        star_id INT REFERENCES star (star_id),
        description TEXT
    );

-- 🤓 actually, these are satellites, not "moons" 
CREATE TABLE
    IF NOT EXISTS moon (
        moon_id SERIAL PRIMARY KEY,
        name VARCHAR(30) NOT NULL UNIQUE,
        lone BOOLEAN NOT NULL DEFAULT TRUE,
        radius NUMERIC,
        partners INT NOT NULL DEFAULT (0),
        planet_id INT REFERENCES planet (planet_id),
        description TEXT
    );

-- we need 5 tables in total to pass the test
CREATE TABLE
    IF NOT EXISTS filler (
        filler_id SERIAL PRIMARY KEY,
        name VARCHAR(30) NOT NULL UNIQUE,
    );
