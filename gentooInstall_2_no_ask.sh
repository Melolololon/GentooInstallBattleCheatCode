
#chroot

source /etc/profile
export PS1="(chroot) ${PS1}"

# efi setting
mkdir /efi
mount /dev/sda1 /efi

		echo "End Chroot--------------------------------------------"
		
		
	echo "Start PortageSetting----------------------------------------------------------"
#sync
emerge-webrsync

#mirror select
emerge  --verbose --oneshot app-portage/mirrorselect
mirrorselect -i -o >> /etc/portage/make.conf


echo "gentooInstall_2.sh End!!! Next _3!!!"

