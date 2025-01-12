#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE teams CASCADE; TRUNCATE games CASCADE;")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]
  then
  # ====================================================================
  # If team name discovered not in teams table
  CHECKER_IF_WINNER_EXISTS="$($PSQL "SELECT COUNT(*) FROM teams WHERE name='$WINNER';")"
  CHECKER_IF_OPPONENT_EXISTS="$($PSQL "SELECT COUNT(*) FROM teams WHERE name='$OPPONENT';")"
  if [[ $CHECKER_IF_WINNER_EXISTS -eq 0 ]]
  then
    echo "INSERT WINNER DETAILS TO TEAMS"
    echo $($PSQL "INSERT INTO teams(name) VALUES('$WINNER');")
  fi
  if [[ $CHECKER_IF_OPPONENT_EXISTS -eq 0 ]]
  then
    echo "INSERT OPPONENT DETAILS TO TEAMS"
    echo $($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT');")
  fi
  echo "START INSERTING VALUES TO TABLE"
  # Start inserting values assuming there are no insertion issues due to reference key constraints
  WINNER_ID_FETCHER="$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")"
  OPPONENT_ID_FETCHER="$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")"

  # Insert Values
  echo $($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID_FETCHER, $OPPONENT_ID_FETCHER, $WINNER_GOALS, $OPPONENT_GOALS)")
  # ====================================================================
  fi
done