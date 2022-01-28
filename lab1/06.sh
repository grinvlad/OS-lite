#!/bin/bash

awk '$3=="(WW)" || $3=="(II)" {print $0}' /var/log/anaconda/X.log | sort -r -k3 > full.log
sed -i -e 's/(WW)/Warning:/; s/(II)/Information:/' full.log
cat full.log