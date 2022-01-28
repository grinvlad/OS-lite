#!/bin/bash

man bash | grep -i -o -E "[a-z]{4,}" | sort | uniq -c | sort -n -k1 -r | head -3