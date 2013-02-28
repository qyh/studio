#!/bin/sh

val=`echo "Hello"`;
echo "$val"

if [ "$val" == "Hello" ]; then
    echo "== works"
fi

if [ "$val" = "Hello" ]; then
    echo "= works too"
fi

echo "$BASH"

for n in 0 1 2 3 4 5; do
    echo "BASH_VERSINFO[$n] = ${BASH_VERSINFO[$n]}"
done



exit 0;

