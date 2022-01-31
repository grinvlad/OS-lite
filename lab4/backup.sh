#!/bin/bash

Date=$(date + "%Y-%m-%d")
for line in $(ls -dl /home/user/*/ | awk '{print $9}' | awk -F/ '{print $4}' | grep -E "^Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}")
do
  oldDate=$(echo "$line" | awk -F'-' '{print $2"-"$3"-"$4}')
  diff=$(( ($(date -d "$Date" +%s) - $(date -d "$oldDate" +%s)) / (60 * 60 * 24) )) #time in days
  if [[ "$diff" -le 7 ]]
  then
    oldBackup="$line"
    oldFiles=""
    newFiles=""
    for file in $(find /home/user/source -type f | cut -d/ -f 5-)
    do
      if [[ -f /home/user/"$oldBackup"/"$file" ]]
      then
        if [[ $(stat --printf="%s" /home/user/"$oldBackup"/"$file") -ne $(stat --printf="%s" /home/user/source/"$file") ]]
        then
          mv /home/user/"$oldBackup"/"$file" /home/user/"$oldBackup"/"${file}.${Date}"
          oldFiles="$oldFiles $file ${file}.${Date}"
          cp /home/user/source/"$file" /home/user/"$oldBackup"/"$file"
        fi
      else
        mkdir -p $(echo /home/user/"$oldBackup"/"$file" | awk -F/ 'OFS="/"{$NF=""; print $0}')
        cp /home/user/source/"$file" /home/user/"$oldBackup"/"$file"
        newFiles="$newFiles $file"
      fi
    done
    echo $'\n'"---- Created new Backup-$Date" >> /home/user/backup_report
    echo "New files: $newFiles" >> /home/user/backup_report
    echo "Old files: $oldFiles" >> /home/user/backup_report
    exit 0
  fi
done
cp -a /home/user/source /home/user/Backup-"$Date"
echo "---- Created new Backup-$Date" >> /home/user/backup_report
ls -R /home/user/Backup-"$Date" >> /home/user/backup_report












