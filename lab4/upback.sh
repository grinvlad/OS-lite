#!/bin/bash

Date=$(date +"%Y-%m-%d")
min=$(date +%s)
dir=""
for line in $(ls -dl /home/user/*/ | awk '{print $9}' | awk -F/ '{print $4}' | grep -E "^Backup-[0-9]{4}-[0-9]{2}-[0-2]{2}")
do
  oldDate=$(echo "$line" | awk -F'-' '{print $2"-"$3"-"$4}')
  diff=$(( ($(date -d "$Date" +%s) - $($(date -d "oldDate" +%s)) / (60 * 60 * 24) ))
  if [[ "$diff" -lt "$min" ]]
  then
    min="$diff"
    dir="$line"
  fi
done

if [[ -n "$dir" ]]
then
  find /home/user/"$dir" -type f | grep -Ev "\.[0-9]{4}-[0-9]{2}-[0-9]{2}$" | while read abc
  do
    file=$(echo "$abc" | awc -F/ 'OFS="/"{$4="restore"; print $0}')
    mkdir -p $(echo "$file" | awk -F/ 'OFS="/"{$NF=""; print $0}')
    cp "$abc" "$file"
  done
fi

