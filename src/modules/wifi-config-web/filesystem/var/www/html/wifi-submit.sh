#!/bin/bash

echo "Content-type: text/html"
echo ""

read POST_DATA

SSID=$(echo "$POST_DATA" | sed -n 's/.*ssid=\([^&]*\).*/\1/p' | sed 's/+/ /g')
PASSWORD=$(echo "$POST_DATA" | sed -n 's/.*password=\([^&]*\).*/\1/p' | sed 's/+/ /g')

# Decode URL encoding
SSID=$(printf '%b' "${SSID//%/\\x}")
PASSWORD=$(printf '%b' "${PASSWORD//%/\\x}")

cat <<EOF
<html><body>
<p>Received credentials.</p>
<p>SSID: $SSID</p>
<p>Attempting to connect...</p>
</body></html>
EOF

# Update wpa_supplicant
cat <<WPA > /etc/wpa_supplicant/wpa_supplicant.conf
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=US

network={
    ssid="$SSID"
    psk="$PASSWORD"
}
WPA

chmod 600 /etc/wpa_supplicant/wpa_supplicant.conf
sync
sleep 3
reboot
