#!/bin/bash

read A
if [[ $A -eq 1 ]]; then
  nano
elif [[ $A -eq 2 ]]; then
  vi
elif [[ $A -eq 3 ]]; then
  links
else
  exit
fi