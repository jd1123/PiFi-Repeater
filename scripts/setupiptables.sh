#!/bin/sh
 IPT=/sbin/iptables
 LOCAL_IFACE=eth0
 INET_IFACE=wlan1
 AP_IFACE=wlan0
 VPN_IFACE=tun0
 INET_ADDRESS=$(sudo ifconfig wlan1 | grep "inet addr:" | awk -F":" '{print $2}' | awk -F" " '{print $1}')
# Flush the tables
 $IPT -F INPUT
 $IPT -F OUTPUT
 $IPT -F FORWARD
$IPT -t nat -P PREROUTING ACCEPT
 $IPT -t nat -P POSTROUTING ACCEPT
 $IPT -t nat -P OUTPUT ACCEPT
# Allow forwarding packets:
# $IPT -A FORWARD -p ALL -i $LOCAL_IFACE -o $INET_IFACE -j ACCEPT
 $IPT -A FORWARD -p ALL -i $AP_IFACE -o $INET_IFACE -j ACCEPT
 $IPT -A FORWARD -i $INET_IFACE -o $LOCAL_IFACE -m state --state ESTABLISHED,RELATED -j ACCEPT
 $IPT -A FORWARD -i $INET_IFACE -o $AP_IFACE -m state --state ESTABLISHED,RELATED -j ACCEPT
# Packet masquerading
 #$IPT -t nat -A POSTROUTING -o $LOCAL_IFACE -j MASQUERADE
 # I'm pretty sure this is unneeded but I added it because I'm mirroring the original script
 #$IPT -t nat -A POSTROUTING -o $AP_IFACE -j MASQUERADE
 $IPT -t nat -A POSTROUTING -o $INET_IFACE -j SNAT --to-source $INET_ADDRESS
# For VPN
 $IPT -t nat -A POSTROUTING -o $VPN_IFACE -j MASQUERADE

