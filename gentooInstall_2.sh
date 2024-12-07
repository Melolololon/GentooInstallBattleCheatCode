
#chroot

source /etc/profile
export PS1="(chroot) ${PS1}"

# efi setting
mkdir /efi
mount /dev/sda1 /efi

		echo "End Chroot--------------------------------------------"
		
		
	echo "Start PortageSetting----------------------------------------------------------"
mkdir --parents /etc/portage/repos.conf
cp /usr/share/portage/config/repos.conf /etc/portage/repos.conf/gentoo.conf


#sync
emerge-webrsync

#mirror select
emerge --ask --verbose --oneshot app-portage/mirrorselect
mirrorselect -i -o >> /etc/portage/make.conf


echo "gentooInstall_2.sh End!!! Next _3!!!"

