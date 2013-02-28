
file="$1"

file=${file%/*}
# generate reable date time
datetime=`date +%Y%m%d%H%M%S`
cd $PWD;tar cjf "$file"_"$datetime".tar.bz2 "$file" >/dev/null 2>&1

exit 0

