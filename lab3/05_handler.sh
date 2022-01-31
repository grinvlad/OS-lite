#!/bin/bash

oper="+"
res=1
regex='^[0-9]+$'
(tail -f pipe & echo $! > pidOfTail) |
while true
do
  cat pidOfTail
  read LINE
  if [[ $LINE == "QUIT" ]]
  then
    rm pipe
    echo "exit"
    kill $(<pidOfTail)
    rm pidOfTail
    exit 0
  fi
  if ! [[ $LINE =~ $regex || $LINE == "+" || "$LINE" == "*" ]]
  then
    echo "error: NaN (from handler)"
    exit 1
  fi
  if [[ $LINE == "+" || "$LINE" == "*" ]]
  then
    oper="$LINE"
  else
    if [[ $oper == "+" ]]
    then
      res=$(echo $res $LINE | awk '{print $1 + $2}')
      echo $res
    else
      res=$(echo $res $LINE | awk '{print $1 * $2}')
      echo $res
    fi
  fi
done