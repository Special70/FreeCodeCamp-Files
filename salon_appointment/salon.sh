#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

FRONT_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  echo "
~~~~~ MY SALON ~~~~~

Welcome to My Salon, how can I help you?

1) cut
2) color
3) perm
4) style
5) trim"
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
  1) ;;
  2) ;;
  3) ;;
  4) ;;
  5) ;;
  *) FRONT_MENU "I could not find that service. What would you like today?" ;;
  esac 

  GET_INFO
}

GET_INFO() {
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  # Check if such record exists
  CHECKER_IF_NUMBER_EXISTS=$($PSQL "select count(*) from customers where phone='$CUSTOMER_PHONE'")

  if [[ $CHECKER_IF_NUMBER_EXISTS -eq 0 ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME

    # INSERT VALUE ==================================================================================================
    CUSTOMER_INSERT=$($PSQL "insert into customers (phone, name) values ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    # Then gets the customer id of the customer
    CUSTOMER_ID=$($PSQL "select customer_id from customers where name='$CUSTOMER_NAME'")
  else
    CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")
    CUSTOMER_NAME=$($PSQL "select name from customers where phone='$CUSTOMER_PHONE'")
  fi
  # Gathers time appointment
  SERVICE=$($PSQL "select name from services where service_id='$SERVICE_ID_SELECTED'") # For printing purposes

  echo -e "\nWhat time would you like your$SERVICE, $CUSTOMER_NAME?"
  read SERVICE_TIME

  # For printing the service name
  # Prints the success message
  echo -e "\nI have put you down for a$SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."

  # Performs the insert query
  APPOINTMENT_INSERT=$($PSQL "insert into appointments(customer_id, service_id, time) values('$CUSTOMER_ID', '$SERVICE_ID_SELECTED', '$SERVICE_TIME')")

  exit
}

FRONT_MENU

