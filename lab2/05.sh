#!/bin/bash

source text_n4
rm text_n5
touch text_n5
N=0
M=0
c=0

while read line
do
  curPPid=$(echo $line | awk -F "=" '{print $3}' | awk -F ":" '{print $1}')
  curART=$(echo $line | awk -F "=" '{print $4}')
  if [ $N -eq $curPPid ];
  then
    c=$((c + 1))
    M=$(echo $M $curART | awk '{print $1 + $2}')
  else
    M=$(echo $M $c | awk '{print $1/$2}')
    echo "    Average_Running_Children_of_ParentID=$N is $M" >> text_n5
    N=$curPPid
    M=$curART
    c=1
  fi
  echo $line >> text_n5
done < text_n4

M=$(echo $M $c | awk '{print $1/$2}')
echo "    Average_Running_Children_of_ParentID=$N is $M" >> text_n5