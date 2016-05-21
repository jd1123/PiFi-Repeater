#!/bin/sh
#/etc/init.d/setuproutes
#
### BEGIN INIT INFO
# Provides: default routes for wlan0
# Required-Start: $syslog $network
# Required-Stop: $syslog
# Should-Start:
# Should-Stop:
# X-Start-Before:
# X-Stop-After:
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# X-Interactive: false
# Short-Description: adjust default routes
# Description: removes default route 192.168.2.1 adds default route 192.168.1.1
### END INIT INFO
sudo route del default gw 192.168.2.1 eth0
sudo route del default gw 192.168.3.1 wlan1
sudo route add default gw 192.168.1.1 wlan0
exit 0
