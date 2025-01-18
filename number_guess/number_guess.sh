#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=numberguess -t --no-align -c"

# Prompt for username
echo "Enter your username: "
read USERNAME

# Check if username is blank or exceeds 22 characters
while [[ -z $USERNAME || ${#USERNAME} -gt 22 ]]; do
  if [[ -z $USERNAME ]]; then
    echo "ERROR: Blank inputs are not allowed. Please enter a valid username:"
  else
    echo "ERROR: Username must be 22 characters or fewer. Please try again:"
  fi
  read USERNAME
done

# Check if user exists in the database
CHECKER_IF_USER_EXISTS=$($PSQL "SELECT COUNT(*) FROM users WHERE name = '$USERNAME'")
if [[ $CHECKER_IF_USER_EXISTS -gt 0 ]]; then
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE name = '$USERNAME'")
  GAMES_PLAYED=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id = $USER_ID")
  BEST_GAME=$($PSQL "SELECT MIN(attempts) FROM games WHERE user_id = $USER_ID")
  if [[ -z $BEST_GAME ]]; then
    BEST_GAME=0
  fi
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
else
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  INSERT_NEW_USER=$($PSQL "INSERT INTO users(name) VALUES('$USERNAME')")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE name = '$USERNAME'")
fi

# Generate random number
NUMBER=$((RANDOM % 1000 + 1))
ATTEMPT_COUNT=0

RUN_GAME() {
  ATTEMPT_COUNT=$((ATTEMPT_COUNT + 1))
  if [[ -z $1 ]]; then
    echo "Guess the secret number between 1 and 1000:"
  else
    echo "$1"
  fi
  read USER_GUESS

  # Validate if input is an integer
  if ! [[ $USER_GUESS =~ ^[0-9]+$ ]]; then
    RUN_GAME "That is not an integer, guess again:"
  elif [[ $USER_GUESS -lt $NUMBER ]]; then
    RUN_GAME "It's higher than that, guess again:"
  elif [[ $USER_GUESS -gt $NUMBER ]]; then
    RUN_GAME "It's lower than that, guess again:"
  elif [[ $USER_GUESS -eq $NUMBER ]]; then
    echo "You guessed it in $ATTEMPT_COUNT tries. The secret number was $NUMBER. Nice job!"
    INSERT_GAME=$($PSQL "INSERT INTO games(user_id, attempts) VALUES($USER_ID, $ATTEMPT_COUNT)")
    exit
  fi
}

RUN_GAME