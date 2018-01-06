#!/bin/bash
##################
## 根据来源IP自动屏蔽恶意ssh破解登陆
##  
##################
if [ -e /var/log/auth.log ] && [ -e /root/scripts/black.txt ];then
cat /var/log/auth.log |awk '/Failed/{print $(NF-3)}' |sort |uniq -c |awk '{print $2"="$1}' |grep -v '116.77.135' > /root/scripts/black.txt
DEFINE="20"
for i in `cat /root/scripts/black.txt`
do
	IP=`echo $i |awk -F = '{print $1}'`
	NUM=`echo $i |awk -F = '{print $2}'`
	if [ $NUM -gt $DEFINE ];then
	grep $IP /etc/hosts.deny > /dev/null
		if [ $? -gt 0 ];then
		echo "sshd:$IP" >> /etc/hosts.deny
		fi
	fi
done
fi
