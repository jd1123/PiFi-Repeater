# Install script for PiFi

# NOTE: THIS IS UNTESTED! It will be changed when I have some time to test
# for now it works as documentation

#!/bin/bash

depends(){
	echo "Installing dependencies..."
	sudo apt-get install -y isc-dhcp-server hostapd iptables iptables-persistent openvpn
}

setup_conf(){
	echo "Setting up your configuration files. You will need to manually look at these..."
	sudo mv /etc/network/interfaces /etc/network/interfaces.bak
	sudo cp conf/interfaces /etc/network/interfaces
	sudo mv /etc/dhcp/dhcp.conf /etc/dhcp/dhcp.conf.bak
	sudo cp conf/dhcpd.conf /etc/dhcp/
	sudo mv /etc/hostapd/hostpd.conf /etc/hostapd/hostapd.conf.bak
	sudo cp conf/hostapd.conf /etc/hostapd/
}

restart_services(){
	echo "Restarting services..."
	sudo service isc-dhcp-server restart
	sudo service hostapd restart
	sudo service openvpn restart
}

setup_iptables(){
	echo "Setting up your iptables rules..."
	cd scripts
	./resetiptables.sh
	./setupiptables.sh
	sudo mv /etc/iptables/rules.v4 /etc/iptables/rules.v4.bak
	sudo iptables-save > /etc/iptables/rules.v4
}

echo "This script will setup PiFi"
echo "After this runs, you will need to set up your VPN." 
echo "Please see: http://www.techrepublic.com/blog/linux-and-open-source/how-to-set-up-a-linux-openvpn-client/"
echo 
read -r -p "Are you sure you want to continue? [y/N] " check
case $check in
    [yY][eE][sS]|[yY]) 
		depends
		setup_conf
		restart_services
		setup_iptables
        ;;
    *)
        exit 0
		;;
esac

