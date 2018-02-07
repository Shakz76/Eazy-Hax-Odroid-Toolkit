#!/bin/bash
# Script created by Forrest to expand the roms file system to an external
# So folks will stop getting ripped off for bigger drives on ebay.
mkdir /home/pigaming/addonusb > /dev/null 2>&1
mkdir /home/pigaming/.work > /dev/null 2>&1
mkdir /home/pigaming/combined_drives > /dev/null 2>&1

testdrive=`df |grep media |awk '{print $1 }'|wc -l`
if [ $testdrive -eq 0 ] ; then
echo "No External drive detected. Exiting."
sleep 5
exit
else
echo "External Drive detected. Performing checks for NTFS filesystem and ora_roms directory."
sleep 5
fi

for EXTDR in `df |grep media|grep -v mmc |awk '{print $1 }'`; do

init_usb_type=`sudo blkid|grep $EXTDR |grep -Po 'TYPE="\K.*?(?=")'`
init_usb_mount=`sudo blkid |grep -v mmc|awk '{print $1 }'| sed -r 's/(:)+$//'`
init_usb_dir=`df |grep media|grep -v mmc |awk '{print $6 }'`

sudo umount $EXTDR
sudo mount -t  $init_usb_type $init_usb_mount /home/pigaming/addonusb
usb_path=`find "/home/pigaming/addonusb/" |grep ora_roms |head -1`

if [ ! -d "$usb_path" ]; then
    echo ""
    echo ""
    echo "Cannot locate the /ora_roms directory on this external drive. Checking other disks if this external drive has two mount points like a "Western Digital My Book.""
    echo ""
    echo ""
    echo ""
        sudo umount $init_usb_filesystem
    sleep 8
else
        usb_path=`find "/home/pigaming/addonusb/" |grep ora_roms |head -1`
                usb_dir=/home/pigaming/addonusb
fi
done

usb_designation=`df -T |grep $usb_dir |awk '{print $1 }'|awk -F'/' '{print $3 }'`
usb_mount=`df -T |grep $usb_dir |awk '{print $1 }'`
usb_filesystem=`sudo blkid |grep -w "$usb_mount"|grep -Po 'TYPE="\K.*?(?=")'`
usb_uuid=`ls -l /dev/disk/by-uuid/|grep $usb_designation|awk '{print $9 }'`
if [ "$usb_filesystem" != "ntfs" ] ; then
echo "This external drive is not correctly formatted. It must be formatted using the NTFS filesystem. Please reformat it to NTFS."
echo "Fat vfat exfat filesystems are not supported in linux"
sleep 10; exit
else echo "External drive checks out. Correctly formatted to NTFS"
sleep 5
fi

sudo grep -w UUID /etc/fstab |grep -v ext4 > /dev/null 2>&1
if [ $? -eq 0 ] ; then
echo "It seems you already have an external drive mapped. Only one external drive is supported. Please run the "Remove Drive Expansion" script from the Retropie menu before adding a new drive."
sleep 10
exit
else

echo "UUID=$usb_uuid  /home/pigaming/addonusb      $usb_filesystem    nofail,user,umask=0000  0       2" > /home/pigaming/.currentdrive
sudo sh -c 'cat /home/pigaming/.currentdrive >> /etc/fstab'
sudo umount $usb_mount
sudo mount -a
mkdir $usb_path/roms/
find "/home/pigaming/RetroPie/roms" -mindepth 1 -maxdepth 1 -type d -printf "$usb_path/roms/%f\n" | xargs mkdir -p 2>/dev/null || true
sleep 1
mv /home/pigaming/RetroPie/roms /home/pigaming/RetroPie/localroms/
mkdir /home/pigaming/RetroPie/roms
cd /etc/samba/
sudo wget -o https://raw.githubusercontent.com/Shakz76/Eazy-Hax-Odroid-Toolkit/master/hax/smb.conf.exp
cd /etc/profile.d
sudo wget -o https://raw.githubusercontent.com/Shakz76/Eazy-Hax-Odroid-Toolkit/master/hax/10-retropie.sh.exp
sudo mv /etc/profile.d/10-retropie.sh /etc/profile.d/10-retropie.sh.org
sudo cp /etc/profile.d/10-retropie.sh.exp /etc/profile.d/10-retropie.sh
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bkup
echo "The drive has been expanded and your system will now halt. Detach your external drive...plug it up to your computer. Load the games then plug it back in and restart your Retro Arena rig...you should see your additional games."
echo "You also have the option of uploading games through windows via /\\/odroid. Have fun!!!"
echo "-Forrest aka Eazy Hax on youtube!"
sleep 10
sudo halt
fi
