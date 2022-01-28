#!/bin/bash

if [[ $1 -lt $2 ]]; then
  if [[ $1 -lt $3 ]]; then
    echo $1
  else
    echo $3
  fi
else
  if [[ $2 -lt $3 ]]; then
      echo $2
    else
      echo $3
  fi
fi