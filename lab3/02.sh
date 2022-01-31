#!/bin/bash

sudo chmod 755 ./01.sh
(sleep 120 ; ./01.sh ; tail -n 0 -f ~/report) &