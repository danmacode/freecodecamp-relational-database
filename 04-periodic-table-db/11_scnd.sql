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
