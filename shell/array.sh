#!/bin/bash

array={1,2,3,4,5,6}

echo "$array"
for i in $array do;
    echo ${array[$i]}
done
