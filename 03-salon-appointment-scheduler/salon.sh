#! /bin/bash
#
# this script completes the tasks outlined below the instructions

PSQL="psql -U freecodecamp -d salon --no-align --tuples-only -c"

print_header() {
  printf "~~~~~ MY SALON ~~~~~\n\n"
  printf "Welcome to My Salon, how can I help you?\n\n"
}

# display a numbered list of the services you offer w/ format "i) serv_i"
print_services() {
  _PSQL="psql -U freecodecamp -d salon --tuples-only -c"
  AVAILABLE_SERVICES=$($_PSQL "SELECT service_id, name FROM services LIMIT 10;")
  echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR NAME; do
    echo "$SERVICE_ID) $NAME"
  done
}

# main fn
main() {
  print_services
  # 1 get service_name by looking at the id
  read SERVICE_ID_SELECTED
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  # 2 if it doesn't find a valid service name, return w/ error code
  if [[ -z $SERVICE_NAME ]]; then
    return 1
  fi

  # Ask for phone number,
  # If a phone number entered doesn’t exist, you should get the customers name and enter it,
  # and the phone number, into the customers table
  printf "\nWhat's your phone number?\n"
  read CUSTOMER_PHONE

  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]; then
    # ask for name
    printf "I don't have a record for that phone number, what's your name?\n"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi

  # ask for the time of the appointment
  printf "What time would you like your $SERVICE_NAME, $CUSTOMER_NAME?\n"
  read SERVICE_TIME

  # get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  INSERT_RET=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  printf "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME.\n"
  return 0
}

##
# main entry point
##

print_header
# loop until valid return
# https://stackoverflow.com/questions/35411972/bash-loop-until-a-certain-command-stops-failing
while true; do
  main
  RETVAL=$?
  if [ $RETVAL -eq 0 ]; then
    break
  else
    printf "\nI could not find that service. What would you like today?\n"
  fi
done
