#!/bin/bash
#
# this script generates a random number that users must guess
# it's also full of bashisms

# https://stackoverflow.com/questions/8988824/generating-random-number-between-1-and-10-in-bash-shell-script
# not really random, depends on your PID & uptime
# range {0..999}
RAND=$(($RANDOM % 1000 + 1))
PSQL="psql -U freecodecamp -d number_guess --no-align --tuples-only -c"
USERNAME=""
P=1

# username: string up to 22 chars
echo -n "Enter your username:"
read USERNAME
#LEN=${#USERNAME} # POSIX way
if [[ $(expr length "$USERNAME") -gt 22 ]]; then
  USERNAME=$(echo $USERNAME | cut -d'_' -f 22) # trim
fi

##
#  check if username exist
##
check_user() {
  EXIST=$($PSQL "SELECT user_id FROM Users WHERE username='$USERNAME'")
  #  if username in database, print game history
  if [[ -z $EXIST ]]; then
    echo "Welcome, $USERNAME! It looks like this is your first time here."
  else
    GAMES_PLAYD=$($PSQL "SELECT COUNT(*) FROM Users WHERE username='$USERNAME'")
    GAMES_BEST=$($PSQL "SELECT MIN(guesses_num) FROM Users INNER JOIN Games USING(user_id) WHERE username='$USERNAME'")
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYD games, and your best game took $GAMES_BEST guesses."
  fi
}
check_user

##
#  loop while guessing
##
looper() {
  echo -n "Guess the secret number between 1 and 1000:"
  while read NTH_GUESS; do
    # if it's a number
    if [[ $(expr "$NTH_GUESS" : "^[0-9]*$") -gt 0 ]]; then
      # if it's our target, then break from while
      if [[ $NTH_GUESS -eq $RAND ]]; then
        break
      # else print a hint
      else
        if [[ $NTH_GUESS -gt $RAND ]]; then
          printf "It's lower than that, guess again:"
        else
          printf "It's higher than that, guess again:"
        fi
      fi
    # if it's not a number
    else
      printf "That is not an integer, guess again:"
    fi
    P=$(($P + 1)) # increment counter each loop
  done
  printf "You guessed it in $P tries. The secret number was $RAND. Nice job!\n"
}
looper

##
#  register the game
##
register_game() {
  EXIST=$($PSQL "SELECT username FROM Users WHERE username='$USERNAME'")
  # we register a new player (only if they won the game)
  if [[ -z $EXIST ]]; then
    RET=$($PSQL "INSERT INTO Users(username) VALUES ('$USERNAME')")
  fi
  # then we insert the new score in Games table
  USER_ID=$($PSQL "SELECT user_id FROM Users WHERE username='$USERNAME'")
  RET=$($PSQL "INSERT INTO Games(user_id, guesses_num) VALUES($USER_ID, $P)")
}

register_game
