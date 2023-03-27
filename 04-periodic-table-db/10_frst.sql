-- vim: set ft=postgresql:
-- modelines: https://vim.fandom.com/wiki/Modeline_magic
-- formatted with: https://github.com/sql-formatter-org/sql-formatter
--
/*  FIX THE DATABASE
 * 1 You should rename the weight column to atomic_mass
 * 2 You should rename the melting_point column to melting_point_celsius
 *   and the boiling_point column to boiling_point_celsius
 */
ALTER TABLE properties
RENAME weight TO atomic_mass;

ALTER TABLE properties
RENAME melting_point TO melting_point_celsius;

ALTER TABLE properties
RENAME boiling_point TO boiling_point_celsius;

/* 3 melting_point_celsius & boiling_point_celsius Not NULL VALUES */
ALTER TABLE properties
ALTER COLUMN melting_point_celsius
SET NOT NULL;

ALTER TABLE properties
ALTER COLUMN boiling_point_celsius
SET NOT NULL;

/* 4 ADD UNIQUE constraint to the symbol & name COLUMNS from the elements TABLE
 * if not named, the constraint name is table_column_number, e.g. "elements_name_key5"
 * This is a bad example => echo "$($PSQL "ALTER TABLE elements ADD UNIQUE(name);")"
 * Always specify the name of the constraint if possible
 */
ALTER TABLE elements
ADD CONSTRAINT symbol_unique UNIQUE (symbol);

ALTER TABLE elements
ADD CONSTRAINT name_unique UNIQUE (name);

-- 5 Your symbol AND name columns should have the NOT NULL CONSTRAINT echo "$($PSQL "
ALTER TABLE elements
ALTER COLUMN symbol
SET NOT NULL;

ALTER TABLE elements
ALTER COLUMN name
SET NOT NULL;
