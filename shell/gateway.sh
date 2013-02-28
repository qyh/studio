#!/bin/bash

device="eth0"
bootproto="static"
broadcast=""
ipaddr=""
netmask="255.255.255.0"
gateway="$1"
network=""
onboot="yes"
nm_controlled="yes"
#file="/etc/sysconfig/network-scripts/ifcfg-eth0"
file="$2"
#echo "$old_gateway"
#value="${old_gateway#*=}"
#echo "value:$value"

old_gateway=$(cat "$file" | grep 'GATEWAY')
if [ "$old_gateway" != "" ]; then
    gateway=${old_gateway%%=*}
    gateway="$gateway""=$1"
else
    gateway="GATEWAY=$1"
fi

old_device=$(cat "$file" | grep 'DEVICE')
if [ "$old_device" != "" ]; then
    device="$old_device"
fi


old_bootproto=$(cat "$file" | grep 'BOOTPROTO')
if [ "$old_bootproto" != "" ]; then
    bootproto=${old_bootproto%%=*}"=$bootproto"
else
    bootproto="BOOTPROTO=$bootproto"
fi


old_broadcast=$(cat "$file" | grep 'BROADCAST')
if [ "$old_broadcast" != "" ]; then
    broadcast=${old_broadcast%%=*}"="${1%.*}".255"
else
    broadcast="BROADCAST="${1%.*}".255"
  
fi

old_ipaddr=$(cat "$file" | grep 'IPADDR')
if [ "$old_ipaddr" != "" ]; then
    hostnum=${old_ipaddr##*.}
    ipaddr=${old_ipaddr%%=*}"="${1%.*}".$hostnum"
else
    ipaddr="IPADDR=$2"
fi

old_netmask=$(grep 'NETMASK' "$file")
if [ "$old_netmask" != "" ]; then
    netmask="$old_netmask"
else
    netmask="NETMASK=255.255.255.0"
fi

old_network=$(grep 'NETWORK' "$file")
if [ "$old_network" != "" ]; then
    network=${old_network%%=*}"="${1%.*}".0"
else
    network="NETWORK="${1%.*}".0"
fi

old_onboot=$(grep 'ONBOOT' "$file")
if [ "$old_onboot" != "" ]; then
    onboot=${old_onboot%%=*}"="\"$onboot\"
else 
    onboot="ONBOOT="\""$onboot"\"
fi

old_nm_controlled=$(grep 'NM_CONTROLLED' "$file")
if [ "$old_nm_controlled" != "" ]; then
    nm_controlled=\""$old_nm_controlled"\"
else
    nm_controlled="NM_CONTROLLED="\""$nm_controlled"\"
fi

old_hwaddr=$(grep 'HWADDR' "$file")
if [ "$old_hwaddr" != "" ]; then
    hwaddr="$old_hwaddr"
fi

#sed -i 's/'$old_gateway'/GATEWAY='"$gateway"'/g' "$file"
comment=$(grep '#' "$file")
cat << !here! > newfile
$comment
$device
$hwaddr
$nm_controlled
$onboot
$bootproto
$ipaddr
$netmask
$network
$broadcast
$gateway
!here!

