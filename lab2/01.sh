#!/bin/bash

ps -eo user | grep -c root > text_n1
ps -eo user,pid,cmd | grep root | awk '{printf("%s:", $2); $1=$2=""; print substr($0, 3)}' >> text_n1