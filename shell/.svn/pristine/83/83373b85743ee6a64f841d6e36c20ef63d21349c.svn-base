#!/bin/sh 

auto="$1"
address="$2"

if [ "$UID" -ne 0 ]; then
    echo "you must be root to run this script"
    exit 1
fi

if [ "$auto" = "" ] || [ "$address" = "" ]; then
    echo "usage: $0 <device> <ipaddress>"
    exit 1
fi

gateway=${address%.*}.1
netmask=255.255.255.0
broadcast=${address%.*}.255
network=${address%.*}.0

cat << EOF > /etc/network/interfaces 
# Genater by /home/qyh/studio/bin/mintipconf.sh
auto $auto
iface $auto inet static
address $address
gateway $gateway
netmask $netmask
broadcast $broadcast

EOF

/etc/init.d/networking restart

exit 0
