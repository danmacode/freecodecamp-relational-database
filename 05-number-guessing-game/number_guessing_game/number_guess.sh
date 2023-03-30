#!/bin/bash
#
# this script generates a random number that users must guess
# it's also full of bashisms
PSQL="psql -U freecodecamp -d number_guess --no-align --tuples-only -c"

# username: string up to 22 chars
echo "Enter your username:"
read USERNAME
########################################
# No need to trim username since varchar is limited to 22 chars
#LEN=${#USERNAME} # POSIX way
#if [[ $(expr length "$USERNAME") -gt 22 ]]; then
#  USERNAME=$(echo $USERNAME | cut -d'_' -f 22) # trim
#fi
############################################

##
#  check if username exist, then retrieve best games & games played
##

USER_ID=$($PSQL "SELECT user_id FROM Users WHERE username='$USERNAME'")
# -n "$STR" - True if the length of string is non-zero
if [[ -n $USER_ID ]]; then # user id foun
  GAMES_PLAYD=$($PSQL "SELECT COUNT(user_id) FROM Games WHERE user_id = '$EXIST'")
  GAMES_BEST=$($PSQL "SELECT MIN(NULLIF(guesses_num, 0)) FROM Games WHERE user_id ='$EXIST'")
  echo -e "Welcome back, $USERNAME! You have played $GAMES_PLAYD games, and your best game took $GAMES_BEST guesses."
else # not found; new gamer
  echo -e "Welcome, $USERNAME! It looks like this is your first time here."
  RET=$($PSQL "INSERT INTO Users(username) VALUES('$USERNAME')")
fi

##
#  loop while guessing
##

# pseudorandom integer that depends on your PID & uptime
# https://stackoverflow.com/questions/8988824/generating-random-number-between-1-and-10-in-bash-shell-script
# range {0..999}
RAND=$(($RANDOM % 1000 + 1))
P=1 # counter
echo -e "Guess the secret number between 1 and 1000:"
while read NTH_GUESS; do
  # if it's a number
  if [[ $(expr "$NTH_GUESS" : "^[0-9]*$") -gt 0 ]]; then
    # if it's our target, then break from while
    if [[ $NTH_GUESS -eq $RAND ]]; then
      break
    # else print a hint
    else
      if [[ $NTH_GUESS -gt $RAND ]]; then
        echo -e "It's lower than that, guess again:"
      else
        echo -e "It's higher than that, guess again:"
      fi
    fi
  # if it's not a number
  else
    echo -e "That is not an integer, guess again:"
  fi
  P=$(($P + 1)) # increment counter each loop
done
# posix
if [ "$P" -eq "1" ]; then
  echo -e "You guessed it in $P try. The secret number was $RAND. Nice job!"
else
  echo -e "You guessed it in $P tries. The secret number was $RAND. Nice job!"
fi

##
#  register the game
##
register_game() {
  EXIST=$($PSQL "SELECT username FROM Users WHERE username='$USERNAME'")

  # then we insert the new score in Games table
  USER_ID=$($PSQL "SELECT user_id FROM Users WHERE username='$USERNAME'")
  RET=$($PSQL "INSERT INTO Games(user_id, guesses_num) VALUES($USER_ID, $P)")
}

register_game
