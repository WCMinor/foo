#!/bin/sh

#this is a script for bundling the current running system
#modified from one blowing in the internet, we have to copy the "creds" directory and modify the novarc file (the first line gave me errors) 

#next line must point to your novarc variables file wherever it is
. /root/creds/novarc

#we're giving a name to the bucket
SYSTEM=$(uname -r)
read -p "Please enter your bucket/container name:" BUCKET_NAME

euca-bundle-vol --no-inherit -d /tmp/image -e /mnt, /tmp
losetup /dev/loop3 /tmp/image/image.img
mount /dev/loop3 /mnt
sed -i 's/^UUID=[a-z0-9]\{8\}-[a-z0-9]\{4\}-[a-z0-9]\{4\}-[a-z0-9]\{4\}-[a-z0-9]\{12\}[\t]* \//\/dev\/vda1\t\//1' /mnt/etc/fstab
sed -i 's/^UUID=[a-z0-9]\{8\}-[a-z0-9]\{4\}-[a-z0-9]\{4\}-[a-z0-9]\{4\}-[a-z0-9]\{12\}[\t]* none/\/mnt\/swap.file\tnone/1' /mnt/etc/fstab
cp /mnt/etc/network/interfaces /mnt/root/interfaces.bak
cat > /mnt/etc/network/interfaces << INTERFACE_UPDATE
# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet dhcp
INTERFACE_UPDATE
 

dd if=/dev/zero of=/mnt/swap.file bs=1024 count=512000
sleep 1
mkswap /mnt/swap.file
sleep 1
umount /mnt

euca-bundle-image -i /boot/initrd.img-$SYSTEM -d /tmp/ramdisk --ramdisk true
euca-bundle-image -i /boot/vmlinuz-$SYSTEM -d /tmp/kernel --kernel true
euca-upload-bundle -m /tmp/kernel/vmlinuz-$SYSTEM.manifest.xml -b $BUCKET_NAME
euca-upload-bundle -m /tmp/ramdisk/initrd.img-$SYSTEM.manifest.xml -b $BUCKET_NAME
KERNEL_IMAGE=$(euca-register $BUCKET_NAME/vmlinuz-$SYSTEM.manifest.xml | awk '{print $2}')
RAMDISK_IMAGE=$(euca-register $BUCKET_NAME/initrd.img-$SYSTEM.manifest.xml | awk '{print $2}')
euca-bundle-image -i /tmp/image/image.img --kernel $KERNEL_IMAGE --ramdisk $RAMDISK_IMAGE -d /tmp/imagebuild
euca-upload-bundle -m /tmp/imagebuild/image.img.manifest.xml -b $BUCKET_NAME
AMI_IMAGE=$(euca-register $BUCKET_NAME/image.img.manifest.xml | awk '{print $2}'); echo "Image is decrypting and untarring for usage."

