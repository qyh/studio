#!/bin/bash

file="/etc/resolv.conf"

chattr -i "$file"

cat << EOF > "$file"

nameserver 202.101.224.69
nameserver 202.101.226.68
#nameserver 192.168.30.1

EOF

chattr +i "$file"
