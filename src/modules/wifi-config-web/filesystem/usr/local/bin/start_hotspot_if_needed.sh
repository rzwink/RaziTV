#!/bin/bash
exec > /tmp/wifi-launch.log 2>&1
set -x

# Unblock and prepare WiFi interface
rfkill unblock wifi
ip link set wlan0 up

SSID=$(iwgetid -r)

if [ -z "$SSID" ]; then
    echo "No WiFi detected. Starting hotspot..."

    systemctl start hostapd
    systemctl start dnsmasq
    systemctl start lighttpd

    # Show help page on screen if display is attached
    if tvservice -s | grep -q 'HDMI'; then
        sleep 2  # give lighttpd time to start
        /usr/bin/chromium-browser --kiosk --noerrdialogs --disable-infobars "http://192.168.4.1/help.html" &
    fi
else
    echo "WiFi detected ($SSID). Stopping hotspot and launching kiosk..."

    systemctl stop hostapd
    systemctl stop dnsmasq
    systemctl stop lighttpd

    UNIQUE_ID=$(awk '/Serial/ {print $3}' /proc/cpuinfo)
    URL="https://razititle.com/activate/$UNIQUE_ID"

    sleep 2  # give time for system to stabilize after network switch
    /usr/bin/chromium-browser --kiosk --noerrdialogs --disable-infobars "$URL" &
fi
