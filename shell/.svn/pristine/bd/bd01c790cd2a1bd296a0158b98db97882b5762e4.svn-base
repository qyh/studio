#!/bin/sh

file="$1"

if [ "$file" = "" ] || [ -d "$file" ]; then
    echo; 
    echo "Usage: $0 filename"
    echo;
    exit 1;
fi

sed -i 's/\r\n/\n/g' $file

exit 0
