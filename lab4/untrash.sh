#!/bin/bash

cat /home/.trash.log | while read line
do
  copy=/home/.trash/$(echo $line | awk '{print $NF}')
  if [ ! -f $copy ]
  then
    continue
  fi
  fullFileName=$(echo $line | awk '{$NF=""; print $0}')
  fileName=$(echo $fullFileName | awk -F"/" '{print $NF}')
  if [[ $fileName == $1 ]]
  then
    read -p "Restore file '$fullFileName'? y\n: " and <&1
    if [[ $ans == "y" ]]
    then
      dir=$(echo "fullFileName" | awk -F/ 'OFS="/"{$NF=""; print $0}')
      if [ ! -d "$dir" ]
      then
        echo "Directory '$dir' has been deleted. Requested file restored in /home/"
        dir=/home/
      fi
      while [ -f "${dir}${fileName}"]
      do
        read -p "File with this name already exists. Please, enter new name: " fileName <&1
      done
      ln $copy "${dir}${fileName}"
      rm $copy
    fi
  fi
done
