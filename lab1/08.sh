#!/bin/bash

input="/etc/passwd"
awk -F: '{print $1 " " $3}' $input | sort -n -k2