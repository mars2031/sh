#!/bin/bash
##################
## 防火墙初始化配置
##
###################
/sbin/iptables -P INPUT ACCEPT
/sbin/iptables -F
/sbin/iptables -X
/sbin/iptables -Z

/sbin/iptables -A INPUT -i lo -j ACCEPT
/sbin/iptables -A OUTPUT -o lo -j ACCEPT

#iptables -A INPUT -p tcp -m multiport --dport 2222,80,443,3306 -j ACCEPT
/sbin/iptables -A INPUT -p tcp --dport 2222 -j ACCEPT
#/sbin/iptables -A INPUT -p tcp --dport 6800 -j ACCEPT
/sbin/iptables -A INPUT -p tcp -s 10.xx.xx.xx/24 --dport 6800 -j ACCEPT
#/sbin/iptables -A INPUT -p tcp --dport 443 -j ACCEPT
/sbin/iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
/sbin/iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 1/s --limit-burst 10 -j ACCEPT
#/sbin/iptables -A INPUT -p tcp -m tcp --tcp-flags SYN,RST,ACK SYN -m limit --limit 20/sec --limit-burst 200 -j ACCEPT

/sbin/iptables -P INPUT DROP
/sbin/iptables -P FORWARD ACCEPT
/sbin/iptables -P OUTPUT ACCEPT
