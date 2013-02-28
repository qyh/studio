#!/bin/sh 

# project directory
dir="$1"

if [ !-d "$dir" ]; then
    echo;
    echo "$dir not a directory !"
    exit 1
fi

find $dir -type f -name '*' -exec wc -l {} \;|\
    awk '{sum = sum + $1;\
    printf "%-30s: %d: %d\n", $2, $1,sum}\
    END{ print "total line: " sum}';

exit 0  
