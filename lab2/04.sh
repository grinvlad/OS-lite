#!/bin/bash

for pid in $(ps -eo pid --no-header)
do
  ppid_file="/proc/$pid/status"
  art_file="/proc/$pid/sched"
  if [ -f $ppid_file ] && [ -f $art_file ];
  then
    ppid=$(awk '$1=="PPid:" {print $2}' $ppid_file)
    divisible=$(awk '$1=="se.sum_exec_runtime" {print $3}' $art_file)
    divisor=$(awk '$1=="nr_switches" {print $3}' $art_file)
    art=$(echo $divisible $divisor | awk '{print $1/$2}')
    echo "ProcessID=$pid : Parent_ProcessID=$ppid : Average_Running_Time=$art"
  fi
done | sort -n -t '=' -k3 > text_n4
