#! /bin/bash
#
# this scrpts inserts data, can be used w/ test param ./insert_data.sh test

if [[ $1 == "test" ]]; then
  PSQL="psql -U postgres -d worldcuptest -t --no-align -c"
else
  PSQL="psql -U freecodecamp -d worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database

# remove all rows from set of tables
echo "$($PSQL "TRUNCATE TABLE games, teams")"

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS; do
  # for all except the header "year"
  if [[ $YEAR != "year" ]]; then
    ##
    # inserting team_id of winner/opponent into teams TABLE
    ##

    # team_id of winner = SELECT team_id FROM teams WHERE name = WINNER(aka )
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    # if team_id not found
    if [[ -z $WINNER_ID ]]; then
      # insert the name of the winner
      INSERT_WIN_NAME_RET=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      # succesful insert
      if [[ $INSERT_WIN_NAME_RET = "INSERT 0 1" ]]; then
        printf "teams - insert winner: $WINNER\n"
      fi
      # team_id of winner = SELECT team_id FROM teams WHERE name=WINNER
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi

    # get opponent's team_id
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    # if team_id not found
    if [[ -z $OPPONENT_ID ]]; then
      # insert the name of the opponent
      INSERT_OP_NAME_RET=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      # succesful insert
      if [[ $INSERT_OP_NAME_RET = "INSERT 0 1" ]]; then
        echo "teams - insert opponent: $OPPONENT\n"
      fi
      # get the new opponent team_id
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    fi

    ##
    # inserting data into games TABLE
    ##
    INSERT_RET=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals)
    VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
    # if successful insert then print all row
    if [[ $INSERT_RET = "INSERT 0 1" ]]; then
      printf "games - insert $YEAR, '$ROUND', [$WINNER_ID vs $OPPONENT_ID]: $WINNER_GOALS - $OPPONENT_GOALS\n"
    fi

  fi
done
