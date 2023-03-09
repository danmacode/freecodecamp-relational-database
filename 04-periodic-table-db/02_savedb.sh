#!/usr/bin/env bash
#
# this script saves the SQL commands to rebuild your database in the .sql file

pg_dump -cC --inserts -U freecodecamp periodic_table >periodic_table.sql
