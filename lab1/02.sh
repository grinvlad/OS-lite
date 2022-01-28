#!/bin/bash

ANS=""
while true
do
  read S
  if [[ $S == q]]; then
    echo $ANS
    exit
  fi
  ANS=$ANS$S
done