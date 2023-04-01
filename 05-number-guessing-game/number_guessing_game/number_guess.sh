#!/bin/bash
#
# this script generates a random number that users must guess
# it's also full of bashisms

PSQL="psql -U freecodecamp -d number_guess --no-align --tuples-only -c"
echo -n "Enter your username:"
read USERNAME

##
#  check if username exist, then retrieve best games & games played
##

USER_ID=$($PSQL "SELECT user_id FROM Users WHERE username='$USERNAME'")

if [[ -n $USER_ID ]]; then # -n "$STR" - True if the length of string is non-zero
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM Users WHERE user_id = '$USER_ID'")
  GAMES_BEST=$($PSQL "SELECT MIN(NULLIF(guesses_num, 0)) FROM Games WHERE user_id ='$USER_ID'")
  echo -e "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $GAMES_BEST guesses."
else # not found; new gamer
  RET=$($PSQL "INSERT INTO Users(username) VALUES('$USERNAME')")
  USER_ID=$($PSQL "SELECT user_id FROM Users WHERE username='$USERNAME'")
  printf "Welcome, $USERNAME! It looks like this is your first time here."
fi

##
#  loop while guessing
##

echo -n "Guess the secret number between 1 and 1000:"

P=1 # counter
RAND=$(($RANDOM % 1000 + 1))

while read NTH_GUESS; do
  # if it's a number
  if [[ $(expr "$NTH_GUESS" : "^[0-9]*$") -gt 0 ]]; then
    # if it's our target, then break from while
    if [[ $NTH_GUESS -eq $RAND ]]; then
      break
    # else print a hint
    else
      if [[ $NTH_GUESS -gt $RAND ]]; then
        echo -n "It's lower than that, guess again:"
      else
        echo -n "It's higher than that, guess again:"
      fi
    fi
  # if it's not a number
  else
    echo -n "That is not an integer, guess again:"
  fi
  P=$(($P + 1)) # increment counter each loop
done
# posix
if [ "$P" -eq "1" ]; then
  echo -e "You guessed it in $P tries. The secret number was $RAND. Nice job!"
else
  echo -e "You guessed it in $P tries. The secret number was $RAND. Nice job!"
fi

##
#  register the game
##

# we insert the new score in Games table
RET=$($PSQL "INSERT INTO Games(user_id, guesses_num) VALUES($USER_ID, $P)")
GAMES_PLAYED_2=$(($GAMES_PLAYED + 1))
RET=$($PSQL "UPDATE Users SET games_played='$GAMES_PLAYED_2' WHERE user_id = '$USER_ID'")
