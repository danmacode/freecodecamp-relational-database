#!/usr/bin/env bash
#
# this script completes the tasks outlined below the instructions

# variable to log into postgres db
PSQL="psql -U freecodecamp -d postgres --no-align --tuples-only -c"

# create db worldcup
# https://stackoverflow.com/questions/14549270/check-if-database-exists-in-postgresql-using-shell
if [ "$(psql -U freecodecamp -d postgres -XtAc "SELECT 1 FROM pg_database WHERE datname='worldcup'")" = '1' ]; then
  printf "# Database worldcup already exists\n"
else
  echo "$($PSQL "CREATE DATABASE worldcup")"
fi

# variable to log into worldcup db
PSQL="psql -U freecodecamp -d worldcup --no-align --tuples-only -c"

# All of your columns should have the NOT NULL constraint
# Your teams table should have a team_id column that is a type of SERIAL and is the primary key,
# Your games table should have a game_id column that is a type of SERIAL and is the primary key,
printf "# Creating teams and games tables, w/ team_id & game_id columns as their primary keys\n"
psql -U freecodecamp -d worldcup <<EOF
CREATE TABLE IF NOT EXISTS teams(team_id SERIAL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS games(game_id SERIAL PRIMARY KEY);
EOF

# the teams TABLE has a name COLUMN that has to be UNIQUE

IFNT="IF NOT EXISTS"
printf "# ADD name COLUMN of type VARCHAR to teams TABLE\n"
echo "$($PSQL "ALTER TABLE teams ADD COLUMN $IFNT name VARCHAR(50) UNIQUE NOT NULL;")"
# games
printf "# ADD round COLUMN of type VARCHAR to games TABLE\n"
echo "$($PSQL "ALTER TABLE games ADD COLUMN $IFNT round VARCHAR(50) NOT NULL;")"
printf "# ADD year COLUMN of type INT to games TABLE\n"
echo "$($PSQL "ALTER TABLE games ADD COLUMN $IFNT year INT NOT NULL;")"

# Now "games" table should have winner_id and opponent_id foreign key columns
# that each reference a team_id from the "teams" table

echo "$($PSQL "ALTER TABLE games ADD COLUMN $IFNT winner_id INT REFERENCES teams(team_id);")"
echo "$($PSQL "ALTER TABLE games ADD COLUMN $IFNT opponent_id INT REFERENCES teams(team_id);")"

# I messed up and didn't set them as NOT NULL, all COLUMNS must be NOT NULL
echo "$($PSQL "ALTER TABLE games ALTER COLUMN winner_id SET NOT NULL;")"
echo "$($PSQL "ALTER TABLE games ALTER COLUMN opponent_id SET NOT NULL;")"
# to add some constraint like unique https://stackoverflow.com/a/7327598

# Your games table should have winner_goals and opponent_goals columns that are type INT
printf "# Creating winner_goals & opponent_goals COLUMNS in games TABLE \n"
echo "$($PSQL "ALTER TABLE games ADD COLUMN $IFNT winner_goals INT NOT NULL;")"
echo "$($PSQL "ALTER TABLE games ADD COLUMN $IFNT opponent_goals INT NOT NULL;")"

# Add exectable permissions to all sh files
chmod a+x *.sh

# Now we need to write & run insert_data.sh
