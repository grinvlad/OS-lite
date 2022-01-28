#!/bin/bash

grep -o -h -r -a -E "[[:alnum:]._-]+@[[:alnum:]]+.[[:lower:]]+" /etc | awk '{printf("%s, ", $0)}' > emails.lst
truncate -s-2 emails.lst