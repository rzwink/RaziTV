#!/bin/bash

UNIQUE_ID=$(cat /proc/cpuinfo | grep Serial | cut -d ' ' -f 2)
URL="https://razititle.com/activate/$UNIQUE_ID"

/usr/bin/chromium-browser --kiosk --noerrdialogs --disable-infobars "$URL"
