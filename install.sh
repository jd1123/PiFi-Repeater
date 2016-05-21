# Install script for PiFi

# NOTE: THIS IS UNTESTED! It will be changed when I have some time to test
# for now it works as documentation

#!/bin/bash

depends(){
	sudo apt-get install -y isc-dhcp-server hostapd iptables openvpn
}

setup_conf(){
	sudo mv /etc/dhcp/dhcp.conf /etc/dhcp/dhcp.conf.bak
	sudo cp conf/dhcpd.conf /etc/dhcp/
	sudo mv /etc/hostapd/hostpd.conf /etc/hostapd/hostapd.conf.bak
	sudo cp conf/hostapd.conf /etc/hostapd/
}

restart_services(){
	sudo service isc-dhcp-server restart
	sudo service hostapd restart
	sudo service openvpn restart
}

setup_iptables(){
	cd scripts
	./resetiptables.sh
	./setupiptables.sh
}

echo -e "This script will setup PiFi"
echo -e "After this runs, you will need to set up your VPN. Please see: http://www.techrepublic.com/blog/linux-and-open-source/how-to-set-up-a-linux-openvpn-client/"

echo -e 
