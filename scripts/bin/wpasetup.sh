#!/bin/sh

ssid=$1
pass=$2

if [ -z $ssid ] || [ -z $pass ]; then
	echo "./wpasetup.sh <ssid> <pass>"
	exit 1
fi

sudo echo "
ctrl_interface=/run/wpa_supplicant
ctrl_interface_group=wheel
eapol_version=1
ap_scan=1
fast_reauth=1
update_config=1

# Add here your networks.
network={
	ssid=\"$ssid\"
	psk=\"$pass\"
}
" > /etc/wpa_supplicant/wpa_supplicant.conf
sudo sv restart wpa_supplicant
