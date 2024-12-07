
	echo "Start parted---------------------------------------------"
#speep
(sleep 2s;
#efi
echo "n" ;echo ""; echo ""; echo "+256M";echo "ef00";
#swap
echo "n" ;echo ""; echo ""; echo "+1G";echo "8200";
#root
echo "n" ;echo ""; echo ""; echo "";echo "";
#write
echo "w"; sleep 1s; echo "y"
) | gdisk /dev/sda

		echo "End parted-----------------------------------------------"


	echo "Start Format--------------------------------------------"

#efi
mkfs.vfat -F 32 /dev/sda1

#swap
mkswap /dev/sda2
swapon /dev/sda2

#root
mkfs.ext4 /dev/sda3

		echo "End Format----------------------------------------------"

echo "Start Mount-----------------------------------------------------"
mkdir --parents /mnt/gentoo
mkdir --parents /mnt/gentoo/efi
mount /dev/sda3 /mnt/gentoo

echo "End Mount-------------------------------------------------------"

	echo "Start GetStage3------------------------------------------"

cd /mnt/gentoo

#Set Time
chronyd -q

#Get Stage3
#Caution!!!!!!!!!! Stage3にリネームして保存してください(Please rename and save to Stage3.)
links https://www.gentoo.org/downloads/mirrors/

#unzip
tar xpvf stage3.tar.xz --xattrs-include='*.*' --numeric-owner
		echo "End GetStage3--------------------------------------------"
		

	echo "Start Chroot----------------------------------------------------------"

#copy dnf data
cp --dereference /etc/resolv.conf /mnt/gentoo/etc/

#mount
mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
mount --bind /run /mnt/gentoo/run
mount --make-slave /mnt/gentoo/run

#chroot
echo "gentooInstall_1.sh End!!!  Next _2!!!"
chroot /mnt/gentoo /bin/bash



