#!/bin/bash

sudo chmod 755 ./dir_04/process1.sh
sudo chmod 755 ./dir_04/process2.sh
sudo chmod 755 ./dir_04/process3.sh

./dir_04/process1.sh &
./dir_04/process2.sh &
./dir_04/process3.sh &

kill $(cat ./dir_04/pid_of_process3.sh)
cpulimit -p $(cat ./dir_04/pid_of_process1.sh) -l 10