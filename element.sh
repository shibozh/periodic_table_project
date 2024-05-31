#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
echo Please provide an element as an argument.

# 接收一个参数
INPUT=$1

# 如果是个数字
if [[ $INPUT =~ ^[0-9]+$ ]]
then
  SEARCH_RESULT=$($PSQL "SELECT name FROM elements WHERE atomic_number=$INPUT")
  if [[ -z $SEARCH_RESULT ]]
  then
    echo I could not find that element in the database.
  else
    RESULT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$INPUT")
  fi
# 如果不是数字且长度小于等于2
elif [[ ${#INPUT} -le 2 ]]
then
  SEARCH_RESULT=$($PSQL "SELECT name FROM elements WHERE symbol='$INPUT'")
  if [[ -z $SEARCH_RESULT ]]
  then
    echo I could not find that element in the database.
  else
    RESULT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) LEFT JOIN types USING(type_id) WHERE symbol='$INPUT'")
  fi
# 如果不是数字且长度大于2
else
  SEARCH_RESULT=$($PSQL "SELECT name FROM elements WHERE name='$INPUT'")
  if [[ -z $SEARCH_RESULT ]]
  then
    echo I could not find that element in the database.
  else
    RESULT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) LEFT JOIN types USING(type_id) WHERE name='$INPUT'")
  fi
fi

echo $RESULT
# echo $RESULT | while IFS="|" read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING BOILING TYPE
# do
#   echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a "
# done