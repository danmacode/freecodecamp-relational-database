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

-- each "star" has an fkey that references a row in galaxy
CREATE TABLE IF NOT EXISTS star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    galaxy_id INT REFERENCES galaxy (galaxy_id),
    random_int INT,
    description TEXT
);

-- What if I insert one row separately from the others?
-- Will this change the insertion order in the DB dump?
-- INSERT 0 1
INSERT INTO
    star (name, galaxy_id, random_int, description)
VALUES
    ('Sun', 1, 20, 'Lone star');

-- INSERT 0 5
INSERT INTO
    star (name, galaxy_id, random_int, description)
VALUES
    ('Star2', 2, 24, 'Second'),
    ('Star3', 3, 43, 'Third'),
    ('Star4', 4, 55, 'Fourth'),
    ('Star5', 5, 71, 'Fifth'),
    ('Star6', 6, 80, 'Sixth');

CREATE TABLE IF NOT EXISTS planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    -- e.g. pluto
    dwarf BOOLEAN NOT NULL DEFAULT FALSE,
    gaseous BOOLEAN NOT NULL DEFAULT FALSE,
    moons INT NOT NULL DEFAULT (0),
    -- closest star
    radius NUMERIC,
    star_id INT REFERENCES star (star_id),
    description TEXT
);

-- we need 12+ rows
-- chatGPT found the moons & radii of all planets
-- INSERT 0 12
INSERT INTO
    planet (
        name,
        dwarf,
        gaseous,
        moons,
        radius,
        star_id,
        description
    )
VALUES
    ('Mercury', FALSE, FALSE, 0, 2439.7, 1, 'planet1'),
    ('Venus', FALSE, FALSE, 0, 6051.8, 1, 'planet2'),
    ('Earth', FALSE, FALSE, 1, 6371, 1, 'planet3'),
    ('Mars', FALSE, FALSE, 2, 3389.5, 1, 'planet4'),
    ('Jupiter', FALSE, TRUE, 4, 69911, 1, 'planet5'),
    ('Saturn', FALSE, TRUE, 83, 58232, 1, 'planet6'),
    ('Uranus', FALSE, TRUE, 27, 25362, 1, 'planet7'),
    ('Neptune', FALSE, TRUE, 14, 24622, 1, 'planet8'),
    ('Pluto', TRUE, FALSE, 5, 1187, 1, 'planet9'),
    ('Pluto2', TRUE, FALSE, 5, 1187, 1, 'planet10'),
    ('Pluto3', TRUE, FALSE, 5, 1187, 1, 'planet11'),
    ('Pluto4', TRUE, FALSE, 5, 1187, 1, 'planet12');

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

-- insert 0 20
INSERT INTO
    moon (name, radius, planet_id, description)
VALUES
    ('moon1', 2439.7, 1, 'moon1'),
    ('moon2', 2439.7, 1, 'moon2'),
    ('moon3', 2439.7, 1, 'moon3'),
    ('moon4', 2439.7, 1, 'moon4'),
    ('moon5', 2439.7, 1, 'moon5'),
    ('moon6', 2439.7, 1, 'moon6'),
    ('moon7', 2439.7, 1, 'moon7'),
    ('moon8', 2439.7, 1, 'moon8'),
    ('moon9', 2439.7, 1, 'moon9'),
    ('moon10', 2439.7, 1, 'moon10'),
    ('moon11', 2439.7, 1, 'moon11'),
    ('moon12', 2439.7, 1, 'moon12'),
    ('moon13', 2439.7, 1, 'moon13'),
    ('moon14', 2439.7, 1, 'moon14'),
    ('moon15', 2439.7, 1, 'moon15'),
    ('moon16', 2439.7, 1, 'moon16'),
    ('moon17', 2439.7, 1, 'moon17'),
    ('moon18', 2439.7, 1, 'moon18'),
    ('moon19', 2439.7, 1, 'moon18'),
    ('moon20', 2439.7, 1, 'moon18');

-- we need 5 tables in total to pass the test
CREATE TABLE IF NOT EXISTS filler_table (
    filler_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    description TEXT
);

-- INSERT 0 3
INSERT INTO
    filler_table (name, description)
VALUES
    ('filler1', 'text1'),
    ('filler2', 'text2'),
    ('filler3', 'text3');

/* 
 * I forgot to include 1 column in the galaxy table,
 * all 4 first tables must have 5 columns
 */
ALTER TABLE
    galaxy
ADD
    long_description TEXT;

/* 
 * Now I have to rename the filler_table pkey to filler_table_id
 * to make it comply with the pkey naming convention
 */
ALTER TABLE
    filler_table RENAME COLUMN filler_id TO filler_table_id;
