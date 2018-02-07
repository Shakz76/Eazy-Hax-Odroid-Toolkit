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
sudo cp /etc/samba/smb.conf.bkup /etc/samba/smb.conf
sudo /usr/sbin/service smbd stop
unlink /home/pigaming/RetroPie/roms; sudo umount /home/pigaming/addonusb; sudo umount overlay; rm -r /home/pigaming/RetroPie/combined_drives; mv /home/pigaming/RetroPie/localroms /home/pigaming/RetroPie/roms  > /dev/null 2>&1
sudo reboot
fi