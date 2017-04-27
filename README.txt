Create a new guest operating system in Virtual Box. Give it a name and choose CentOS 64 bit as the version.
Assign RAM to it.
Select the Use an existing virtual hard disk file option and navigate to the folder where the .vdi file is stored. Select it and continue.
After the OS is booted to the grub screen, enter the following commands
grub> set root=(hd0, msdos1)
grub> linux /bzImage
grub> initrd /rootfs.cpio.gz
grub> boot
Thus the system boots and brings it to the command prompt. Enter user as root.
Check whether both the NIC cards are being detected using ifconfig.
The output  should show eth0 and eth1.
Assign a public ip address to  eth1.
Thus, you can easily run any IPtables commands  to implement the firewall facility.