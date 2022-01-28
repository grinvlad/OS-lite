#!/bin/bash

if [[ $PWD == $HOME ]]; then
  echo $PWD
  echo 0
else
  echo "PWD doesn't match home directory"
  exit 1
fi