#!/bin/bash

n=1900000
k=30
sudo chmod 755 ./newmem.sh
for ((i = 0; i < k; i++))
do
  sleep 1
  ./newmem.sh $n $i &
done