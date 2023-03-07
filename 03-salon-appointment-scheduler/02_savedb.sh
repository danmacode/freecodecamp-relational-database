#!/usr/bin/env bash
#
# this script saves the SQL commands to rebuild your database in SQL_FILE

SQL_FILE="salon.sql"

pg_dump -cC --inserts -U freecodecamp salon >$SQL_FILE
