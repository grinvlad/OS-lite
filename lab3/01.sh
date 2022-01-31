#!/bin/bash

Time=$(date +'%T-%d-%m-%y')
mkdir ~/text 2>/dev/null && {
  echo "catalog test was created successfully" > ~/report ;
  touch ~/test/$Time
}
ping -c 1 www.net_nikogo.ru 2>/dev/null || echo $Time " the requested host is unavailable" >> ~/report