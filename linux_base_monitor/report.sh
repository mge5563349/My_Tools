#!/bin/bash
if [[ -s /home/monitor/monitor.txt ]] ; then
	mail -s "$(cat /etc/sysconfig/network | grep 'HOSTNAME' | awk -F '=' '{print $2}') status" lsg@xdns.cn < /home/monitor/monitor.txt
	mail -s "$(cat /etc/sysconfig/network | grep 'HOSTNAME' | awk -F '=' '{print $2}') status" gang@xdns.cn < /home/monitor/monitor.txt
else
	echo "No status" | mail -s "No Status" lsg@xdns.cn
fi

