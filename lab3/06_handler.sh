#!/bin/bash

echo $$ > pid6
a=1
operator="none"
usr1() {
  operator="+"
}
usr2() {
  operator="*"
}
trap 'usr1' USR1
trap 'usr2' USR2

while true
do
  case $operator in
    "+")
      a=$(echo "2" $a | awk '{print $1 + $2}')
      echo $a
      ;;
    "*")
      a=$(echo "2" $a | awk '{print $1 * $2}')
      echo $a
      ;;
    "none")
      ;;
  esac
  sleep 1
done