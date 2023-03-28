#!/bin/env bash
#
# this POSIX compliant script will seach an element from the periodic_table database
# if the element in't found or none was provided, it'll exit

PSQL="psql -U freecodecamp -d periodic_table -t --no-align -c"
ARG_1=$1
ELEMENT=""

find_element() {
  EXPRESSIONS="atomic_number,atomic_mass,symbol,name,type,melting_point_celsius,boiling_point_celsius"
  # POSIX shell compliant regex that detects a numeric string
  # https://stackoverflow.com/questions/32107041/how-to-check-if-a-string-only-contains-digits-numerical-characters
  if [[ $(expr "$ARG_1" : "^[0-9]*$") -gt 0 ]]; then
    # numeric
    ELEMENT=$($PSQL "SELECT $EXPRESSIONS FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE atomic_number=$ARG_1")
  else
    # non numeric
    ELEMENT=$($PSQL "SELECT $EXPRESSIONS FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE symbol='$ARG_1' OR name='$ARG_1'")
  fi
  # if not ELEMENT or empty (""), exit script
  if [[ -z $ELEMENT ]]; then
    echo "I could not find that element in the database."
    exit
  fi
}

print_element() {
  echo $ELEMENT | while IFS=" |" read A_NUMBER A_MASS SYMBOL NAME TYPE M_POINT B_POINT; do
    printf "The element with atomic number $A_NUMBER is $NAME ($SYMBOL). "
    printf "It's a $TYPE, with a mass of $A_MASS amu. $NAME has a melting "
    printf "point of $M_POINT celsius and a boiling point of $B_POINT celsius.\n"
  done
}

# main entry point
# https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
if [ -z "$ARG_1" ]; then
  echo "Please provide an element as an argument."
else
  find_element
  print_element
fi
