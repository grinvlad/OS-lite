#!/bin/bash

start_data=()
end_data=()
pids=()
cmdline=()

for pid in $(ps -eo pid)
do
  if [ -r /proc/$pid/io ]
  then
    start_data[$pid]=$(grep "rchar" /proc/$pid/io | awk '{print $2}')
    pids[$pid]=$pid
    cmdline[$pid]=$(cat /proc/$pid/cmdline | tr -d '\0')
  fi
done

sleep 60

for pid in "${pids[@]}"
do
  end_data[$pid]=$(grep "rchar" /proc/$pid/io | awk '{print $2}')
done

for pid in "${pids[@]}"
do
  diff=$(echo ${end_data[$pid]} ${start_data[$pid]} | awk '{print $1-$2}')
  echo $pid $diff ${cmdline[$pid]}
done | sort -nr -k 2 | head -n 3 | awk '{print $1":"$2":"$3}'