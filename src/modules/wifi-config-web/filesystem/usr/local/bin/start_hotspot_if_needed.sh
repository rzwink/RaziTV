#!/bin/bash
set -e

# Check if wlan0 is connected
if ! iwgetid -r; then
    echo "[wifi-config-web] No WiFi connected. Enabling AP..."

    rfkill unblock wlan

    systemctl stop dhcpcd || true
    ip link set wlan0 down || true
    ip a flush dev wlan0
    ip link set wlan0 up

    # Static IP for AP
    ip addr add 192.168.50.1/24 dev wlan0

    systemctl start hostapd
    systemctl start dnsmasq
    systemctl start wifi-config-web.service
else
    echo "[wifi-config-web] WiFi is already connected."
fi
