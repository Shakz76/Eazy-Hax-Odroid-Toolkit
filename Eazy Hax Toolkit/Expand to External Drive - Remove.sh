#!/bin/bash
if [ ! -d /home/pigaming/RetroPie/localroms ]; then
    echo ""
    echo ""
    echo "I do not detect that this Retropie is expanded. Killing this script."
    echo ""
    echo ""
	sleep 5
else

sudo sed -i '/addon/d' /etc/fstab
sudo cp /etc/profile.d/10-retropie.sh.org /etc/profile.d/10-retropie.sh
unlink /home/pigaming/RetroPie/roms; sudo umount /home/pigaming/addonusb; sudo umount overlay; sudo umount /home/pigaming/RetroPie/roms;rm -r /home/pigaming/RetroPie/roms; mv /home/pigaming/RetroPie/localroms /home/pigaming/RetroPie/roms  > /dev/null 2>&1
sudo reboot
fi
