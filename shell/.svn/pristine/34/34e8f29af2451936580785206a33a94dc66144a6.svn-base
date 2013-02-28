#! /bin/sh

chkconfig --list | grep '3:on' | awk '{print $1}' | 
while read line ; do
    # Do something here
    if [ "$line" = "sshd" ] \
      || [ "$line" = "syslog" ] || [ "$line" = "NetworkManager" ]\
      || [ "$line" = "yum-updatesd" ] || [ "$line" = "messagebus" ]\
      || [ "$line" = "rpcgssd" ] || [ "$line" = "svnserve" ] ; then
	echo "$line on"
    else
    	chkconfig --level 2345 "$line" off
    fi
done


exit 0
