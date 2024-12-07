
#repository update
emerge --sync --quiet

#set profile
eselect profile list
echo "Input Profile Number"
read profileNum
echo "Thank You!"
eselect profile set $profileNum

#@world update
emerge --ask --verbose --update --deep --newuse @world

		echo "End PortageSetting----------------------------------------------------------"
		
		
	echo "Start SetTimeZone----------------------------------------------------------"
ln -sf ../usr/share/zoneinfo/Japan /etc/localtime
		echo "End SetTimeZone--------------------------------------------"
		
		
	echo "Start SetLocale----------------------------------------------------------"
nano /etc/locale.gen
locale-gen

eselect locale list
echo "Input Locale Number"
read localeNum
echo "Thank You!"
eselect locale set $localeNum

#locale reload
env-update && source /etc/profile && export PS1="(chroot) ${PS1}"

		echo "End SetLocale--------------------------------------------"




	echo "Start Install Farmware--------------------------------------------"
echo 'ACCEPT_LICENSE="-* @FREE @BINARY-REDISTRIBUTABLE"' > /etc/portage/make.conf
emerge --ask sys-kernel/linux-firmware
		echo "End Install FarmWare--------------------------------------------"


	echo "Start Intel Microcode--------------------------------------------"
emerge --ask sys-firmware/intel-microcode
		echo "End Intel Microcode--------------------------------------------"


	echo "Start Kernel Compile--------------------------------------------"
#dracut ON
echo "sys-kernel/installkernel dracut" > /etc/portage/package.use/installkernel
	
#compile kernel
emerge --ask sys-kernel/gentoo-kernel-bin

#delete
#emerge --depclean

#rebuild
#emerge --ask @module-rebuild
#emerge --config sys-kernel/gentoo-kernel-bin

		echo "End Kernel Compile--------------------------------------------"


	echo "Start Kernel Source Install--------------------------------------------"
emerge --ask sys-kernel/installkernel

eselect kernel list
echo "Input Kernel Number"
read kernelNum
echo "Thank You!"
eselect kernel set $kernelNum
		echo "End Kernel Source Compile--------------------------------------------"

	#echo "Start Kernel Install--------------------------------------------"
echo "sys-kernel/installkernel grub" > /etc/portage/package.use/installkernel
#emerge --ask sys-kernel/installkernel

		#echo "End Kernel Install--------------------------------------------"


	echo "Start Initramfs Build--------------------------------------------"
#echo "sys-kernel/installkernel dracut" > /etc/portage/package.use/installkernel
emerge --ask sys-kernel/dracut

#draw kernel Var
cd /usr/src/
ls
cd
echo "Input Kernel Varsion"
read kernelVarsion  #数字部分のみを入力 (例 6.6.62)  (Enter numbers only (Example 6.6.62))
echo "Thank You!"
dracut --kver=${kernelVarsion}-gentoo


echo "*/* dist-kernel" >  /etc/portage/package.use/module-rebuild
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
#echo $hostName > /etc/hostname
hostnamectl hostname ${hostName}
		echo "End  Host Setting--------------------------------------------"

	echo "Start Network Setting--------------------------------------------"
emerge --ask net-misc/dhcpcd
systemctl enable dhcpcd

ifconfig

echo "Input IP Address"
read ipAddress
echo "Thank You!"
echo "${ipAddress}     ${hostname}.homenetwork ${hostName} localhost" > /etc/hosts
		echo "End  IP Setting--------------------------------------------"



	echo "Start Set Password--------------------------------------------"
passwd
		echo "End Set Password--------------------------------------------"




	echo "Start Systemd Option--------------------------------------------"
systemd-machine-id-setup
systemd-firstboot --prompt
systemctl preset-all --preset-mode=enable-only
		echo "End Systemd Option--------------------------------------------"



	echo "Start Chrony--------------------------------------------"
emerge --ask net-misc/chrony
		echo "End Chrony--------------------------------------------"


	echo "Start Install GRUB--------------------------------------------"
echo 'GRUB_PLATFORMS="efi-64"' >> /etc/portage/make.conf
emerge --ask sys-boot/grub
grub-install --efi-directory=/efi
grub-mkconfig -o /boot/grub/grub.cfg
		echo "End Install GRUB--------------------------------------------"





	echo "Start Other Setup--------------------------------------------"





	echo "Start Install Japanese Fonts--------------------------------------------"
emerge source-han-sans
		echo "End Install Japanese Fonts--------------------------------------------"



	echo "Start Setup Sudo--------------------------------------------"
emerge --ask app-admin/sudo
#add groop
usermod -aG wheel

		echo "End Setup Sudo--------------------------------------------"




	echo "Start Setup Wifi--------------------------------------------"
#emerge --ask net-wireless/wpa_supplicant
#emerge --ask networkmanager
#systemctl enable NetworkManager
#echo "modules="wpa_supplicant"" > /etc/conf.d/net
		echo "End Setup Wifi--------------------------------------------"



		echo "End Setup--------------------------------------------"


	echo "Start Reboot--------------------------------------------"
	
	
echo "gentooInstall_3.sh End!!! Next _4!!!"
exit




