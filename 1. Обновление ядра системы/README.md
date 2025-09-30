# -----------------------------------
# 1. Обновление ядра системы. 
# -----------------------------------

vassaya@OTUS-PC:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:db:6a:97 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic noprefixroute enp0s3
       valid_lft 86371sec preferred_lft 86371sec
    inet6 fd00::a3ca:4c7f:c90f:67a2/64 scope global temporary dynamic 
       valid_lft 86373sec preferred_lft 14373sec
    inet6 fd00::a00:27ff:fedb:6a97/64 scope global dynamic mngtmpaddr 
       valid_lft 86373sec preferred_lft 14373sec
    inet6 fe80::a00:27ff:fedb:6a97/64 scope link 
       valid_lft forever preferred_lft forever
vassaya@OTUS-PC:~$ uname -r
6.14.0-29-generic
vassaya@OTUS-PC:~$ uname -p
x86_64
vassaya@OTUS-PC:~$ mkdir kernel && cd kernel
vassaya@OTUS-PC:~/kernel$ wget https://kernel.ubuntu.com/mainline/v6.16.6/amd64/linux-headers-6.16.6-061606-generic_6.16.6-061606.202509091747_amd64.deb
--2025-09-10 10:27:54--  https://kernel.ubuntu.com/mainline/v6.16.6/amd64/linux-headers-6.16.6-061606-generic_6.16.6-061606.202509091747_amd64.deb
Resolving kernel.ubuntu.com (kernel.ubuntu.com)... 185.125.189.76, 185.125.189.74, 185.125.189.75
Connecting to kernel.ubuntu.com (kernel.ubuntu.com)|185.125.189.76|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 3671456 (3.5M) [application/x-debian-package]
Saving to: ‘linux-headers-6.16.6-061606-generic_6.16.6-061606.202509091747_amd64.deb’

linux-headers-6.16. 100%[===================>]   3.50M  6.15MB/s    in 0.6s    

2025-09-10 10:27:55 (6.15 MB/s) - ‘linux-headers-6.16.6-061606-generic_6.16.6-061606.202509091747_amd64.deb’ saved [3671456/3671456]

vassaya@OTUS-PC:~/kernel$ wget https://kernel.ubuntu.com/mainline/v6.16.6/amd64/linux-headers-6.16.6-061606_6.16.6-061606.202509091747_all.deb
--2025-09-10 10:28:28--  https://kernel.ubuntu.com/mainline/v6.16.6/amd64/linux-headers-6.16.6-061606_6.16.6-061606.202509091747_all.deb
Resolving kernel.ubuntu.com (kernel.ubuntu.com)... 185.125.189.76, 185.125.189.75, 185.125.189.74
Connecting to kernel.ubuntu.com (kernel.ubuntu.com)|185.125.189.76|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 14251470 (14M) [application/x-debian-package]
Saving to: ‘linux-headers-6.16.6-061606_6.16.6-061606.202509091747_all.deb’

linux-headers-6.16. 100%[===================>]  13.59M  9.13MB/s    in 1.5s    

2025-09-10 10:28:29 (9.13 MB/s) - ‘linux-headers-6.16.6-061606_6.16.6-061606.202509091747_all.deb’ saved [14251470/14251470]

vassaya@OTUS-PC:~/kernel$ wget https://kernel.ubuntu.com/mainline/v6.16.6/amd64/linux-image-unsigned-6.16.6-061606-generic_6.16.6-061606.202509091747_amd64.deb
--2025-09-10 10:29:26--  https://kernel.ubuntu.com/mainline/v6.16.6/amd64/linux-image-unsigned-6.16.6-061606-generic_6.16.6-061606.202509091747_amd64.deb
Resolving kernel.ubuntu.com (kernel.ubuntu.com)... 185.125.189.75, 185.125.189.76, 185.125.189.74
Connecting to kernel.ubuntu.com (kernel.ubuntu.com)|185.125.189.75|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 16066752 (15M) [application/x-debian-package]
Saving to: ‘linux-image-unsigned-6.16.6-061606-generic_6.16.6-061606.202509091747_amd64.deb’

linux-image-unsigne 100%[===================>]  15.32M  9.73MB/s    in 1.6s    

2025-09-10 10:29:27 (9.73 MB/s) - ‘linux-image-unsigned-6.16.6-061606-generic_6.16.6-061606.202509091747_amd64.deb’ saved [16066752/16066752]

vassaya@OTUS-PC:~/kernel$ wget https://kernel.ubuntu.com/mainline/v6.16.6/amd64/linux-modules-6.16.6-061606-generic_6.16.6-061606.202509091747_amd64.deb
--2025-09-10 10:29:49--  https://kernel.ubuntu.com/mainline/v6.16.6/amd64/linux-modules-6.16.6-061606-generic_6.16.6-061606.202509091747_amd64.deb
Resolving kernel.ubuntu.com (kernel.ubuntu.com)... 185.125.189.75, 185.125.189.76, 185.125.189.74
Connecting to kernel.ubuntu.com (kernel.ubuntu.com)|185.125.189.75|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 262308032 (250M) [application/x-debian-package]
Saving to: ‘linux-modules-6.16.6-061606-generic_6.16.6-061606.202509091747_amd64.deb’

linux-modules-6.16. 100%[===================>] 250.16M  10.3MB/s    in 24s     

2025-09-10 10:30:12 (10.6 MB/s) - ‘linux-modules-6.16.6-061606-generic_6.16.6-061606.202509091747_amd64.deb’ saved [262308032/262308032]

vassaya@OTUS-PC:~/kernel$ sudo dpkg -i *.deb
[sudo] password for vassaya: 
Selecting previously unselected package linux-headers-6.16.6-061606.
(Reading database ... 263808 files and directories currently installed.)
Preparing to unpack linux-headers-6.16.6-061606_6.16.6-061606.202509091747_all.deb ...
Unpacking linux-headers-6.16.6-061606 (6.16.6-061606.202509091747) ...
Selecting previously unselected package linux-headers-6.16.6-061606-generic.
Preparing to unpack linux-headers-6.16.6-061606-generic_6.16.6-061606.202509091747_amd64.deb ...
Unpacking linux-headers-6.16.6-061606-generic (6.16.6-061606.202509091747) ...
Selecting previously unselected package linux-image-unsigned-6.16.6-061606-generic.
Preparing to unpack linux-image-unsigned-6.16.6-061606-generic_6.16.6-061606.202509091747_amd64.deb ...
Unpacking linux-image-unsigned-6.16.6-061606-generic (6.16.6-061606.202509091747) ...
Selecting previously unselected package linux-modules-6.16.6-061606-generic.
Preparing to unpack linux-modules-6.16.6-061606-generic_6.16.6-061606.202509091747_amd64.deb ...
Unpacking linux-modules-6.16.6-061606-generic (6.16.6-061606.202509091747) ...
Setting up linux-headers-6.16.6-061606 (6.16.6-061606.202509091747) ...
Setting up linux-headers-6.16.6-061606-generic (6.16.6-061606.202509091747) ...
/etc/kernel/header_postinst.d/dkms:
 * dkms: running auto installation service for kernel 6.16.6-061606-generic
Sign command: /usr/bin/kmodsign
Binary update-secureboot-policy not found, modules won't be signed

Building module:
Cleaning build area...
make -j6 KERNELRELEASE=6.16.6-061606-generic -C /lib/modules/6.16.6-061606-generic/build M=/var/lib/dkms/virtualbox/7.0.16/build...(bad exit status: 2)
ERROR (dkms apport): kernel package linux-headers-6.16.6-061606-generic is not supported
Error! Bad return status for module build on kernel: 6.16.6-061606-generic (x86_64)
Consult /var/lib/dkms/virtualbox/7.0.16/build/make.log for more information.
dkms autoinstall on 6.16.6-061606-generic/x86_64 failed for virtualbox(10)
Error! One or more modules failed to install during autoinstall.
Refer to previous errors for more information.
 * dkms: autoinstall for kernel 6.16.6-061606-generic
   ...fail!
run-parts: /etc/kernel/header_postinst.d/dkms exited with return code 11
dpkg: error processing package linux-headers-6.16.6-061606-generic (--install):
 installed linux-headers-6.16.6-061606-generic package post-installation script subprocess returned error exit status 11
Setting up linux-modules-6.16.6-061606-generic (6.16.6-061606.202509091747) ...
Setting up linux-image-unsigned-6.16.6-061606-generic (6.16.6-061606.202509091747) ...
I: /boot/vmlinuz.old is now a symlink to vmlinuz-6.14.0-29-generic
I: /boot/initrd.img.old is now a symlink to initrd.img-6.14.0-29-generic
I: /boot/vmlinuz is now a symlink to vmlinuz-6.16.6-061606-generic
I: /boot/initrd.img is now a symlink to initrd.img-6.16.6-061606-generic
Processing triggers for linux-image-unsigned-6.16.6-061606-generic (6.16.6-061606.202509091747) ...
/etc/kernel/postinst.d/dkms:
 * dkms: running auto installation service for kernel 6.16.6-061606-generic
Sign command: /usr/bin/kmodsign
Binary update-secureboot-policy not found, modules won't be signed

Building module:
Cleaning build area...
make -j6 KERNELRELEASE=6.16.6-061606-generic -C /lib/modules/6.16.6-061606-generic/build M=/var/lib/dkms/virtualbox/7.0.16/build...(bad exit status: 2)
ERROR (dkms apport): kernel package linux-headers-6.16.6-061606-generic is not supported
Error! Bad return status for module build on kernel: 6.16.6-061606-generic (x86_64)
Consult /var/lib/dkms/virtualbox/7.0.16/build/make.log for more information.
dkms autoinstall on 6.16.6-061606-generic/x86_64 failed for virtualbox(10)
Error! One or more modules failed to install during autoinstall.
Refer to previous errors for more information.
 * dkms: autoinstall for kernel 6.16.6-061606-generic
   ...fail!
run-parts: /etc/kernel/postinst.d/dkms exited with return code 11
dpkg: error processing package linux-image-unsigned-6.16.6-061606-generic (--install):
 installed linux-image-unsigned-6.16.6-061606-generic package post-installation script subprocess returned error exit status 11
Errors were encountered while processing:
 linux-headers-6.16.6-061606-generic
 linux-image-unsigned-6.16.6-061606-generic
vassaya@OTUS-PC:~/kernel$ ls -al /boot
total 211652
drwxr-xr-x  3 root root     4096 Sep 10 10:31 .
drwxr-xr-x 23 root root     4096 Feb  6  2025 ..
-rw-r--r--  1 root root   292076 Jan 20  2025 config-6.11.0-17-generic
-rw-r--r--  1 root root   296143 Aug 14 15:02 config-6.14.0-29-generic
-rw-r--r--  1 root root   299505 Sep  9 17:47 config-6.16.6-061606-generic
drwxr-xr-x  5 root root     4096 Sep  3 06:13 grub
lrwxrwxrwx  1 root root       32 Sep 10 10:31 initrd.img -> initrd.img-6.16.6-061606-generic
-rw-r--r--  1 root root 66832322 Feb 12  2025 initrd.img-6.11.0-17-generic
-rw-r--r--  1 root root 72791136 Sep  3 06:12 initrd.img-6.14.0-29-generic
lrwxrwxrwx  1 root root       28 Sep 10 10:31 initrd.img.old -> initrd.img-6.14.0-29-generic
-rw-r--r--  1 root root   142796 Apr  8  2024 memtest86+ia32.bin
-rw-r--r--  1 root root   143872 Apr  8  2024 memtest86+ia32.efi
-rw-r--r--  1 root root   147744 Apr  8  2024 memtest86+x64.bin
-rw-r--r--  1 root root   148992 Apr  8  2024 memtest86+x64.efi
-rw-------  1 root root  9400106 Jan 20  2025 System.map-6.11.0-17-generic
-rw-------  1 root root  9148044 Aug 14 15:02 System.map-6.14.0-29-generic
-rw-------  1 root root 10126744 Sep  9 17:47 System.map-6.16.6-061606-generic
lrwxrwxrwx  1 root root       29 Sep 10 10:31 vmlinuz -> vmlinuz-6.16.6-061606-generic
-rw-------  1 root root 15341960 Jan 20  2025 vmlinuz-6.11.0-17-generic
-rw-------  1 root root 15546760 Aug 14 15:08 vmlinuz-6.14.0-29-generic
-rw-------  1 root root 16032256 Sep  9 17:47 vmlinuz-6.16.6-061606-generic
lrwxrwxrwx  1 root root       25 Sep 10 10:31 vmlinuz.old -> vmlinuz-6.14.0-29-generic
vassaya@OTUS-PC:~/kernel$ sudo upgrade-grub
sudo: upgrade-grub: command not found
vassaya@OTUS-PC:~/kernel$ sudo update-grub
Sourcing file `/etc/default/grub'
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-6.16.6-061606-generic
Found linux image: /boot/vmlinuz-6.14.0-29-generic
Found initrd image: /boot/initrd.img-6.14.0-29-generic
Found linux image: /boot/vmlinuz-6.11.0-17-generic
Found initrd image: /boot/initrd.img-6.11.0-17-generic
Found memtest86+x64 image: /boot/memtest86+x64.bin
Warning: os-prober will not be executed to detect other bootable partitions.
Systems on them will not be added to the GRUB boot configuration.
Check GRUB_DISABLE_OS_PROBER documentation entry.
Adding boot menu entry for UEFI Firmware Settings ...
done
vassaya@OTUS-PC:~/kernel$ sudo grub-set-default 0
vassaya@OTUS-PC:~/kernel$ uname -r
6.14.0-29-generic

# --------------------------------------------------------
# 2. Решение проблемы с загрузкой обновлённого ядра
# --------------------------------------------------------

vassaya@OTUS-PC:~$ sudo update-initramfs -c -k 6.16.6-061606-generic
[sudo] password for vassaya: 
update-initramfs: Generating /boot/initrd.img-6.16.6-061606-generic
vassaya@OTUS-PC:~$ ls -la /lib/modules/
total 32
drwxr-xr-x   8 root root 4096 Sep 10 13:24 .
drwxr-xr-x 106 root root 4096 Sep 10 13:38 ..
drwxr-xr-x   6 root root 4096 Feb 12  2025 6.11.0-17-generic
drwxr-xr-x   5 root root 4096 Sep 10 13:40 6.12.0-061200-generic
drwxr-xr-x   5 root root 4096 Sep 10 13:39 6.13.2-061302-generic
drwxr-xr-x   6 root root 4096 Sep  3 06:06 6.14.0-29-generic
drwxr-xr-x   5 root root 4096 Sep 10 13:40 6.16.6-061606-generic
drwxr-xr-x   2 root root 4096 Sep 10 11:05 6.8.0-52-generic
vassaya@OTUS-PC:~$ sudo update-grub
Sourcing file `/etc/default/grub'
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-6.16.6-061606-generic
Found initrd image: /boot/initrd.img-6.16.6-061606-generic
Found linux image: /boot/vmlinuz-6.14.0-29-generic
Found initrd image: /boot/initrd.img-6.14.0-29-generic
Found linux image: /boot/vmlinuz-6.13.2-061302-generic
Found linux image: /boot/vmlinuz-6.12.0-061200-generic
Found linux image: /boot/vmlinuz-6.11.0-17-generic
Found initrd image: /boot/initrd.img-6.11.0-17-generic
Found memtest86+x64 image: /boot/memtest86+x64.bin
Warning: os-prober will not be executed to detect other bootable partitions.
Systems on them will not be added to the GRUB boot configuration.
Check GRUB_DISABLE_OS_PROBER documentation entry.
Adding boot menu entry for UEFI Firmware Settings ...
done
vassaya@OTUS-PC:~$ sudo grub-set-default 0
vassaya@OTUS-PC:~$ uname -r
6.14.0-29-generic
vassaya@OTUS-PC:~$ reboot

# -------------------------
#   3.После перезапуска
# -------------------------

vassaya@OTUS-PC:~$ uname -r
6.16.6-061606-generic
vassaya@OTUS-PC:~$
