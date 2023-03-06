#! /bin/bash
#
# this scrpts inserts data, can be used w/ test param ./insert_data.sh test

if [[ $1 == "test" ]]; then
  PSQL="psql -U postgres -d worldcuptest -t --no-align -c"
else
  PSQL="psql -U freecodecamp -d worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database
