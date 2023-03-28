-- vim: set ft=postgresql:
-- formatted with: https://github.com/sql-formatter-org/sql-formatter
--
-- You should capitalize the first letter of all the symbol values in the elements table.
-- Be careful to only capitalize the letter and not change any others
--
/* This can be done for each lowercase element:
 *UPDATE elements SET symbol='He' WHERE symbol='he';
 *UPDATE elements SET symbol='Li' WHERE symbol='li';
 *UPDATE elements SET symbol='Mt' WHERE symbol='mT';
 */
-- However, it can be solved with CONCAT like this problem - https://leetcode.com/problems/fix-names-in-a-table
UPDATE elements
SET
    symbol = CONCAT(upper(substr(symbol, 1, 1)), substr(symbol, 2));

-- You should remove all the trailing zeros after the decimals from each row of the atomic_mass column.
-- You may need to adjust a data type to DECIMAL for this.
-- The final values they should be are in the atomic_mass.txt file
-- https://learnsql.com/cookbook/how-to-remove-trailing-zeros-from-a-decimal-in-postgresql/
ALTER TABLE properties
ALTER COLUMN atomic_mass
SET DATA TYPE REAL;

ALTER TABLE properties
ALTER COLUMN atomic_mass
SET DATA TYPE DECIMAL;

-- ADD ELEMENT with atomic_number 9 to the database, Fluorine, 9, mass-18.998, mp= -220, bp = -100.1 nonmetal
-- ADD ELEMENT with atomic_number 10...       Neon  nonmetal
INSERT INTO
    elements (atomic_number, symbol, name)
VALUES
    (9, 'F', 'Fluorine'),
    (10, 'Ne', 'Neon');

INSERT INTO
    properties (
        atomic_number,
        type,
        atomic_mass,
        melting_point_celsius,
        boiling_point_celsius,
        type_id
    )
VALUES
    (9, 'nonmetal', 18.998, -220, -188.1, 1),
    (10, 'nonmetal', 20.18, -248.6, -246.1, 1);

-- Your properties table should not have a type column
-- ERROR:  column reference "type" is ambiguous
ALTER TABLE properties
DROP COLUMN
type;
