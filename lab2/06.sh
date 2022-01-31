#!/bin/bash

for pid in $(ps -eo pid --no-header)
do
  status_file="/proc/$pid/status"
  if [ -f $status_file ];
  then
    awk '$1=="VmRSS:" {print $2}' $status_file
  fi
done | sort -n | tail -n 1