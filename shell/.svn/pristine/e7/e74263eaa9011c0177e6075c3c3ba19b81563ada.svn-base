#!/bin/bash
sql="$1"
if [ "$sql" = "" ]; then
    echo;
    echo "Usage: $0 command"
    echo
fi
mysql -uroot -proot <<EOF 2>/dev/null

$sql;

EOF
