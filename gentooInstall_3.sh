
#repository update
emerge --sync --quiet

#set profile
eselect profile list
echo "Input Profile Number"
read profileNum
echo "Thank You!"
eselect profile set $profileNum

#@world update
echo "yes" | emerge --ask --verbose --update --deep --newuse @world

		echo "End PortageSetting----------------------------------------------------------"
		
		
	echo "Start SetTimeZone----------------------------------------------------------"
ln -sf ../usr/share/zoneinfo/Japan /etc/localtime
		echo "End SetTimeZone--------------------------------------------"
		
		
	echo "Start SetLocale----------------------------------------------------------"
nano /etc/locale.gen
locale-gen

eselect locale list
echo "Input Locale Number"
read locareNum
echo "Thank You!"
eselect locale set $localeNum

#locale reload
env-update && source /etc/profile && export PS1="(chroot) ${PS1}"
		echo "End SetLocale--------------------------------------------"


	echo "Start Install FormWare--------------------------------------------"
emerge --ask sys-kernel/linux-firmware
		echo "End Install FormWare--------------------------------------------"



	echo "Start Kernel Compile--------------------------------------------"
#dracut ON
echo "sys-kernel/installkernel dracut" > /etc/portage/package.use/installkernel
	
#compile kernel
echo "y" | emerge --ask sys-kernel/gentoo-kernel-bin

#delete
echo "y" | emerge --depclean

#rebuild
emerge --ask @module-rebuild
echo "y" | emerge --config sys-kernel/gentoo-kernel-bin

		echo "End Kernel Compile--------------------------------------------"


	echo "Start Kernel Source Install--------------------------------------------"
emerge --ask sys-kernel/installkernel

eselect kernel list
echo "Input Kernel Number"
read kernelNum
echo "Thank You!"
eselect kernel set $kernelNum
		echo "End Kernel Source Compile--------------------------------------------"

	echo "Start Kernel Install--------------------------------------------"
emerge --ask sys-kernel/installkernel

		echo "End Kernel Install--------------------------------------------"


	echo "Start Initramfs Build--------------------------------------------"
echo "sys-kernel/installkernel dracut" >  /etc/portage/package.use/installkernel
emerge --ask sys-kernel/dracut

#draw kernel Var
cd /usr/src/
ls
cd
echo "Input Kernel Varsion"
read kernelVarsion
echo "Thank You!"
dracut --kver=${kernelVarsion}-gentoo
		echo "End Initramfs Build--------------------------------------------"


	#echo "Start Kernel Module Rebuild"
#emerge --ask @module-rebuild

		#echo "End Kernel Module Rebuild--------------------------------------------""

	echo "Start Fstab Write--------------------------------------------"
echo "/dev/sda1   /efi        vfat    umask=0077     0 2" > /etc/fstab
echo "/dev/sda2   none         swap    sw                   0 0" > /etc/fstab
echo "/dev/sda3   /            ext4    defaults,noatime              0 1" > /etc/fstab
echo "/dev/cdrom  /mnt/cdrom   auto    noauto,user          0 0" > /etc/fstab
		echo "End  Fstab Write--------------------------------------------"

	echo "Start Host Setting--------------------------------------------"
echo "Input Host Name"
read hostName
echo "Thank You!"
echo $hostName > /etc/hostname

		echo "End  Host Setting--------------------------------------------"

	echo "Start Network Setting--------------------------------------------"
echo "yes" | emerge --ask net-misc/dhcpcd
systemctl enable dhcpcd

ifconfig

echo "Input IP Address"
read ipAddress
echo "Thank You!"
echo "${ipAddress}     tux.homenetwork ${hostName} localhost" > /etc/hosts
		echo "End  IP Setting--------------------------------------------"



	echo "Start Set Password--------------------------------------------"
passwd
		echo "End Set Password--------------------------------------------"



	echo "Start Chrony--------------------------------------------"
echo "yes" | emerge --ask net-misc/chrony
		echo "End Chrony--------------------------------------------"


	echo "Start Install GRUB--------------------------------------------"
echo 'GRUB_PLATFORMS="efi-64"' >> /etc/portage/make.conf
echo "yes" | emerge --ask sys-boot/grub
grub-install --efi-directory=/efi
grub-mkconfig -o /boot/grub/grub.cfg
		echo "End Install GRUB--------------------------------------------"


	echo "Start Reboot--------------------------------------------"
	
	
echo "gentooInstall_3.sh End!!! Next _4!!!"
exit



