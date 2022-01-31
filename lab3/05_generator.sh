#!/bin/bash

mkfifo pipe
regex='^[0-9]+$'
while true
do
  read LINE
  echo "$LINE" > pipe
  if [[ $LINE == "QUIT" ]]
  then
    break
  fi
  if ! [[ $LINE =~ $regex || $LINE == "+" || "$LINE" == "*" ]]
  then
    rm pipe
    echo "error: NaN (from generator)"
    exit 1
  fi
done