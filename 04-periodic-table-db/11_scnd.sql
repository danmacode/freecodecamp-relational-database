-- vim: set ft=postgresql:
-- formatted with: https://github.com/sql-formatter-org/sql-formatter
/* 6 set atomic_number from properties table as a foreign key 
 * that references the column of the same name in elements table */
ALTER TABLE properties
ADD FOREIGN KEY (atomic_number) REFERENCES elements (atomic_number);

-- 7 create a types table that will store the types of elements
-- 8 types TABLE should have a type_id column that is an integer and the primary key
CREATE TABLE
    types (type_id SERIAL NOT NULL);

ALTER TABLE types
ADD PRIMARY KEY (type_id);

-- Now we populate VALUES of COLUMN type in TABLE type
-- 8 types TABLE should have a type COLUMN thats a VARCHAR NOT NULL
-- You should add three rows to your types TYPES whose values
-- are the three different types from the properties table
ALTER TABLE types
ADD COLUMN
type VARCHAR(30) NOT NULL;

INSERT INTO
    types (
        type
    )
VALUES
    ('nonmetal'),
    ('metal'),
    ('metalloid');

SELECT
    *
FROM
    types
LIMIT
    3;

-- Setting properties_type_id to 1,2,3 for nonmetal, metal, metalloid
ALTER TABLE properties
ADD COLUMN IF NOT EXISTS type_id INT REFERENCES types (type_id);

UPDATE properties
SET
    type_id = 1
WHERE
type = 'nonmetal';

UPDATE properties
SET
    type_id = 2
WHERE
type = 'metal';

UPDATE properties
SET
    type_id = 3
WHERE
type = 'metalloid';

-- properties need a type_id value that links to the correct type in the types TABLE
-- since we filled properties with type_id not null we can set NOT NULL
-- NOT NULL property could be set later on: ALTER COLUMN type_id SET NOT NULL
-- Setting properties_type_id NOT NULL
ALTER TABLE properties
ALTER COLUMN type_id
SET NOT NULL;

/* Also DELETE non existent element with atomic_number 1000
 * We DELETE from both tables in one transaction to keep data consistent
 * https://www.postgresql.org/docs/current/tutorial-transactions.html
 * https://stackoverflow.com/questions/10145221/how-to-delete-data-from-multiple-tables
 */
BEGIN;

-- delete item with atomic_number = 1000 in BOTH TABLES
DELETE FROM properties
WHERE
    atomic_number = 1000;

DELETE FROM elements
WHERE
    atomic_number = 1000;

COMMIT;
