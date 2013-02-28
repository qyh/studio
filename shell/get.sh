#!/bin/sh
  
echo "$#"
if [ "$#" -ne 2 ]; then
    echo ; echo "usage: $0 <val> <dir|file>"; echo;
    exit 1
fi

contents="$1"
param="$2"

if [ "$param" = "" ]; then
    param=.
fi

if [ -f "$param" ]; then
    grep "$contens" "$param"
fi

for file in `$(find "$param" -name '*')`; do
    grep "$contents" "$file"
done

exit 0
