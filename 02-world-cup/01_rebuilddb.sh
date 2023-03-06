#!/usr/bin/env bash
#
# this script rebuilds the database by entering the SQL commands in SQL_FILE

SQL_FILE="worldcup.sql"

psql -U postgres <$SQL_FILE
