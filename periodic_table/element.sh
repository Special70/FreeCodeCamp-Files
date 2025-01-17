
SELECTED_ELEMENT_ATOMIC_NUMBER='null'

PRINT_OUTPUT() {
  
  ELEMENT_SYMBOL=$($PSQL "select symbol from elements where atomic_number=$SELECTED_ELEMENT_ATOMIC_NUMBER;")
  ELEMENT_NAME=$($PSQL "select name from elements where atomic_number=$SELECTED_ELEMENT_ATOMIC_NUMBER;")
  ELEMENT_TYPE_ID=$($PSQL "select type_id from properties where atomic_number=$SELECTED_ELEMENT_ATOMIC_NUMBER;")
  ELEMENT_TYPE=$($PSQL "select type from types where type_id=$ELEMENT_TYPE_ID;")
  ELEMENT_ATOMIC_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$SELECTED_ELEMENT_ATOMIC_NUMBER;")
  ELEMENT_MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number=$SELECTED_ELEMENT_ATOMIC_NUMBER;")
  ELEMENT_BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number=$SELECTED_ELEMENT_ATOMIC_NUMBER;")

  echo "The element with atomic number $SELECTED_ELEMENT_ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
  exit
}

if [[ -z $1 ]] 
then
  echo "Please provide an element as an argument."
else
  PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

  # check if input is a number
  re='^[0-9]+$'
  if [[ $1 =~ $re ]]
  then
    IF_VALID_ATOMIC_NUMBER=$($PSQL "select count(*) from elements where atomic_number=$1;")
    if [[ $IF_VALID_ATOMIC_NUMBER > 0 ]]
    then
      SELECTED_ELEMENT_ATOMIC_NUMBER=$IF_VALID_ATOMIC_NUMBER
    fi
  else
    # Check for symbol inputs
    IF_VALID_SYMBOL=$($PSQL "select count(*) from elements where symbol='$1';")
    if [[ $IF_VALID_SYMBOL > 0 ]]
    then
      SELECTED_ELEMENT_ATOMIC_NUMBER=$($PSQL "select atomic_number from elements where symbol='$1'")
    else
      # Check for valid name inputs
      IF_VALID_NAME=$($PSQL "select count(*) from elements where name='$1';")
      if [[ $IF_VALID_NAME > 0 ]]
      then
        SELECTED_ELEMENT_ATOMIC_NUMBER=$($PSQL "select atomic_number from elements where name='$1'")
      fi
    fi
    
  fi

  # Start setting up the details
  if [[ $SELECTED_ELEMENT_ATOMIC_NUMBER -eq "null" ]]
  then
    echo "I could not find that element in the database."
  else
    PRINT_OUTPUT
  fi

fi