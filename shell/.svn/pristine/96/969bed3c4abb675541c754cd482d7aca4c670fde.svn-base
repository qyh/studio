#!/bin/sh
df -h
df -h | grep / | awk '{print $4}' | grep G | awk -F'G' '{sum = $1 + sum;} END{print "total avail size: "sum " G"}'

exit 0
