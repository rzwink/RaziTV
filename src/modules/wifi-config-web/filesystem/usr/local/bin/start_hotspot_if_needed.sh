#!/bin/bash

SSID=$(iwgetid -r)

if [ -z "$SSID" ]; then
    echo "No WiFi detected. Starting hotspot..."

    # Start AP services
    systemctl start hostapd
    systemctl start dnsmasq
    systemctl start lighttpd

    # Optional: open local help page in kiosk mode if HDMI is attached
    if [ -n "$(tvservice -s | grep '0x')" ]; then
        /usr/bin/kweb -K http://192.168.4.1/help.html
    fi
else
    echo "WiFi detected ($SSID). Stopping hotspot and launching kiosk..."

    systemctl stop hostapd
    systemctl stop dnsmasq
    systemctl stop lighttpd

    /usr/local/bin/launch_browser.sh
fi
