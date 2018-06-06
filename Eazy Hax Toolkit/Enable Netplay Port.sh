#!/bin/bash
infobox= ""
infobox="${infobox}___________________________________________________________________________________\n\n"
infobox="${infobox}This script Enable the Netplay hosting port on your router.\n"
infobox="${infobox}You only need to do this if you are Hosting the netplay session.\n\n"
infobox="${infobox}After the port is enabled the script will give you your external IP address. Only share this with FRIENDS.\n\n"
infobox="${infobox}THE RULES:\n"
infobox="${infobox}1. Due to the flaky nature of netplay only the older systems work. N64 will not work.\n"
infobox="${infobox}2. For best results get whoever has the fastest internet UPLOAD speed to do the hosting.\n"
infobox="${infobox}3. You and your friend must be using the EXACT same rom.\n4. I already know this script will not work for everyone....just most folks, but I put it out there anyway.\n"
infobox="${infobox}Have Fun gaming with your buddies!\n"
infobox="${infobox}___________________________________________________________________________________\n\n"
infobox="${infobox}Much retro love,\n"
infobox="${infobox}- Eazy Hax\n"

dialog --backtitle "Eazy Hax External Drive Expansion" \
--title "Eazy Hax External Drive Expansion" \
--msgbox "${infobox}" 25 90

function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " MAIN MENU " \
            --ok-label OK --cancel-label Exit \
            --menu "What action would you like to perform?" 25 75 20 \
            1 "Enable Netplay Hosting Port On Your Router" \
            2 "Disable Netplay Hosting Port On Your Router" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) enable  ;;
            2) disable  ;;
            *)  break ;;
        esac
    done
}

function enable() {
clear
echo "Your pi must be connected to the internet for this to work."
sleep 4
echo "*************************************************************************************************"
echo "*Checking that the needed software is installed on this Odroid. If it is missing I'll install it*"
echo "*************************************************************************************************"
echo ""
echo ""
sleep 3
if [ -z "$(which upnpc)" ]; then
echo ""
echo ""
echo "*************************************************************************"
echo "*The software needed for Enabling Netplay is missing. Installing it now.*"
echo "*************************************************************************"
echo ""
echo ""

sleep 5
sudo apt-get update
sudo apt-get --assume-yes install miniupnpc
else
echo ""
echo "*********************************************************"
echo "*Found the software needed for Netplay Port Forwarding. *"
echo "*********************************************************"
sleep 2
echo ""

fi

LAN=`ip route get 8.8.8.8 2>/dev/null | head -1 | cut -d' ' -f8`
WAN=`wget http://ipinfo.io/ip -qO -`
echo "Enabling the port now"
upnpc -a $LAN 55435 55435 UDP
echo "Port SHOULD be enabled. If it is not then your router does not support UPNP or you need to enable it through your router settings"
echo "You will need to give your friend the IP address below so they can connect. You may want to write it down real quick"
echo ""
echo "Write this down = $WAN"
echo ""
sleep 60
exit
}

function disable() {
LAN=`ip route get 8.8.8.8 2>/dev/null | head -1 | cut -d' ' -f8`
WAN=`wget http://ipinfo.io/ip -qO -`
echo "*********************************************************************"
echo "*Disabling Netplay Port*"
echo "*********************************************************************"
echo ""
echo ""
sleep 5
upnpc -d $LAN 55435 55435 UDP
echo ""
echo "**********************"
echo "*Port Disabled.*"
echo "**********************"
echo ""
sleep 5
exit
}

main_menu
