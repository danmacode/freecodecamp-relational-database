-- vim: set ft=postgresql:
--
-- usage: psql -v username="your user" -f
-- usage: psql -U freecodecamp -d periodic_table -v username="'USER'" -a -f 01_finduser.sql
SELECT
    @ username -- command line provided argument
FROM
    users
WHERE
    username=username
