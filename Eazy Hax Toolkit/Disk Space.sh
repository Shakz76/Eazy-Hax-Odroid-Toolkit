#!/usr/bin/env bash

DISKSPACE=`df -kh /home/pigaming/RetroPie/roms | tail -1 | tr -s ' ' | cut -d' ' -f4`
echo -e "\n\n\n				You have $DISKSPACE available on your RetroPie SD Card.\n\n\n"
if [ -d "/home/pi/addonusb/roms" ]; then
EXP_DISKSPACE=`df -kh /home/pigaming/addonusb| tail -1 | tr -s ' ' | cut -d' ' -f4`
echo "\n\n\n				You have $EXP_DISKSPACE available on your RetroPie Expanded External Drive.\n\n\n"
sleep 10
fi
sleep 10
exit