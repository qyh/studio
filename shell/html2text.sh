#!/bin/bash

dir="$1"
if [  "$dir" = "" ]; then
    dir="$PWD"
fi

covert="/mybin/html2text"

if [ -f "$dir" ]; then
    destfile="$dir"
    ./html2text $file 1> $destfile 
    exit 0
fi

for file in $(ls $dir/*.html); do

    destfile=${file%.html}".c"

    ./html2text $file 1> $destfile

done



exit 0
