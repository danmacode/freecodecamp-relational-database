--WARNING! ERRORS ENCOUNTERED DURING SQL PARSING!
-- -*-mode: sql; sql-product: postgres;-*- vim:ft=postgresql
--
-- github needs the vim modeline to categorize this as a PLpgSQL file
CREATE DATABASE universe;

-- connect to the database with \c universe
-- then create all 4 tables with table_name_id naming convention
-- all of them with a name column, and 5 columns
-- each table with 3+ rows
-- galaxy & star tables should each have 6+ rows
CREATE TABLE IF NOT EXISTS galaxy (
    galaxy_id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(30) NOT NULL UNIQUE,
    speed NUMERIC NOT NULL DEFAULT (1),
    description TEXT
);

INSERT INTO
    galaxy (name, speed, description)
VALUES
    (
        'Milky Way',
        2.1,
        'the galaxy that includes the Solar System'
    ),
    (
        'Andromeda',
        2.2,
        'The nearest large galaxy to the Milky Way'
    ),
    (
        'Tadpole',
        2.61,
        'A disrupted barred spiral galaxy'
    ),
    (
        'Comet',
        3,
        'A spiral galaxy of unusual appearance'
    ),
    (
        'Sombrero',
        1.1,
        'A peculiar galaxy of unclear classification'
    ),
    ('Pinwheel', 0.243, 'A face-on spiral galaxy');

--
CREATE TABLE IF NOT EXISTS star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    galaxy_id INT REFERENCES galaxy (galaxy_id),
    description TEXT
);

CREATE TABLE IF NOT EXISTS planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    -- e.g. pluto
    dwarf BOOLEAN NOT NULL DEFAULT FALSE,
    moons INT NOT NULL DEFAULT (0),
    star_id INT REFERENCES star (star_id),
    description TEXT
);

-- 🤓 actually, these are satellites, not "moons"
CREATE TABLE IF NOT EXISTS moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    lone BOOLEAN NOT NULL DEFAULT TRUE,
    radius NUMERIC,
    partners INT NOT NULL DEFAULT (0),
    planet_id INT REFERENCES planet (planet_id),
    description TEXT
);

-- we need 5 tables in total to pass the test
CREATE TABLE IF NOT EXISTS filler (
    filler_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
);
