#/bin/bash

action="txt"

while getopts "u" opt;
do
    case $opt in
	    u) action="untxt"
	esac
    
done

shift $(($OPTIND - 1))
dir="$1"
if [ "$dir" = "" ]; then
    dir="$PWD"
fi

program="$PWD/"${0#./}
function path2name(){
    filename=${1#${1%/*}}
	filename=${filename#/}
	return "$filename"
}

function txt(){
    # $1: program name
	# $2: the first parameter which pass to the program
	file_name="$2"

	suffix=${file_name##*.}

    self="$1"
	if [ "$suffix" != "txt" ]\
    && [ "$file_name" != "$self" ]; then
	    echo "changing file: $file"
	    mv "$file_name" "$file_name"".txt"
	fi  
}
function untxt(){
	file_name="$2"
	suffix=${file_name##*.}
	prefix=${file_name%.txt}
	self=$1
	if [ "$suffix" = "txt" ] && [ "$file_name" != "$self" ]; then
	    echo "changing file: $file"
	    mv "$file_name" "$prefix"
	fi  
}

for file in $(find "$dir" -name '*')
do
    file=${file#./}

	if [ -f "$file" ]; then
        "$action" "$program" "$file"
	fi
	
done




