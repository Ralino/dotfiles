#!/bin/sh
#Makes this computer an access point with NAT when connected with enp4s0f2
#
#Must be run with root.
#To use this, configure iptables and dnsmasq according to the arch wiki.

if [ "$(whoami)" != "root" ]; then
	echo "Must be run with root!"
	exit 1
fi

systemctl stop  hostapd.service
systemctl stop iptables.service
sleep 5

if [ -z "$(ip link show dev enp4s0f2 | grep "state UP")" ]; then
	nmcli r all on
	exit 0
fi

nmcli r all off
rfkill unblock wlan
sleep 1

ip link set up dev wlp3s0
ip addr add 192.168.96.1/24 dev wlp3s0
sleep 1

systemctl start  dnsmasq.service
systemctl start  hostapd.service
systemctl start iptables.service
