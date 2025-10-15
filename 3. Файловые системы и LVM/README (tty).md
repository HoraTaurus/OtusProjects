vassaya@OTUS-PC:~$ lsblk
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0    7:0    0     4K  1 loop /snap/bare/5
loop1    7:1    0  55.5M  1 loop /snap/core18/2940
loop2    7:2    0 319.2M  1 loop /snap/code/182
loop3    7:3    0 329.6M  1 loop /snap/code/208
loop4    7:4    0  55.5M  1 loop /snap/core18/2952
loop5    7:5    0  63.8M  1 loop /snap/core20/2599
loop6    7:6    0  63.8M  1 loop /snap/core20/2669
loop7    7:7    0  73.9M  1 loop /snap/core22/2111
loop8    7:8    0  66.8M  1 loop /snap/core24/1151
loop9    7:9    0  66.8M  1 loop /snap/core24/1196
loop10   7:10   0 246.4M  1 loop /snap/firefox/6738
loop11   7:11   0  11.1M  1 loop /snap/firmware-updater/167
loop12   7:12   0 247.1M  1 loop /snap/firefox/6836
loop13   7:13   0  11.1M  1 loop /snap/firmware-updater/147
loop14   7:14   0  62.2M  1 loop /snap/github-gui/2
loop15   7:15   0   516M  1 loop /snap/gnome-42-2204/202
loop16   7:16   0 164.8M  1 loop /snap/gnome-3-28-1804/198
loop17   7:17   0 516.2M  1 loop /snap/gnome-42-2204/226
loop18   7:18   0 618.3M  1 loop /snap/gnome-46-2404/125
loop19   7:19   0  91.7M  1 loop /snap/gtk-common-themes/1535
loop20   7:20   0 290.8M  1 loop /snap/mesa-2404/912
loop21   7:21   0  10.8M  1 loop /snap/snap-store/1270
loop22   7:22   0  17.5M  1 loop /snap/snap-store/1300
loop23   7:23   0  44.4M  1 loop /snap/snapd/23545
loop24   7:24   0  50.8M  1 loop /snap/snapd/25202
loop25   7:25   0  73.9M  1 loop /snap/core22/2133
loop26   7:26   0   568K  1 loop /snap/snapd-desktop-integration/253
loop27   7:27   0   576K  1 loop /snap/snapd-desktop-integration/315
loop28   7:28   0  64.7M  1 loop /snap/sublime-text/209
loop29   7:29   0  64.7M  1 loop /snap/sublime-text/217
loop30   7:30   0  79.3M  1 loop /snap/telegram-desktop/6798
loop31   7:31   0  79.3M  1 loop /snap/telegram-desktop/6814
sda      8:0    0   100G  0 disk 
├─sda1   8:1    0     1M  0 part 
└─sda2   8:2    0   100G  0 part /
sdb      8:16   0    10G  0 disk 
sdc      8:32   0     2G  0 disk 
sdd      8:48   0     1G  0 disk 
sde      8:64   0     1G  0 disk 
sr0     11:0    1  1024M  0 rom  
vassaya@OTUS-PC:~$ fdisk -l /dev/sdb
fdisk: cannot open /dev/sdb: Permission denied
vassaya@OTUS-PC:~$ sudo fdisk -l /dev/sdb
[sudo] password for vassaya: 
Disk /dev/sdb: 10 GiB, 10737418240 bytes, 20971520 sectors
Disk model: VBOX HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 4AE155F3-D4F8-41CF-9CDD-26F269AF97D9
vassaya@OTUS-PC:~$ wipefs -a /dev/sdb
wipefs: error: /dev/sdb: probing initialization failed: Permission denied
vassaya@OTUS-PC:~$ sudo wipefs -a /dev/sdb
/dev/sdb: 8 bytes were erased at offset 0x00000200 (gpt): 45 46 49 20 50 41 52 54
/dev/sdb: 8 bytes were erased at offset 0x27ffffe00 (gpt): 45 46 49 20 50 41 52 54
/dev/sdb: 2 bytes were erased at offset 0x000001fe (PMBR): 55 aa
/dev/sdb: calling ioctl to re-read partition table: Success
vassaya@OTUS-PC:~$ sudo fdisk -l /dev/sdb
Disk /dev/sdb: 10 GiB, 10737418240 bytes, 20971520 sectors
Disk model: VBOX HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
vassaya@OTUS-PC:~$ sudo fdisk -l /dev/sdc
Disk /dev/sdc: 2 GiB, 2147483648 bytes, 4194304 sectors
Disk model: VBOX HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
vassaya@OTUS-PC:~$ sudo fdisk -l /dev/sdd
Disk /dev/sdd: 1 GiB, 1073741824 bytes, 2097152 sectors
Disk model: VBOX HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
vassaya@OTUS-PC:~$ sudo fdisk -l /dev/sde
Disk /dev/sde: 1 GiB, 1073741824 bytes, 2097152 sectors
Disk model: VBOX HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
vassaya@OTUS-PC:~$ sudo fdisk -l /dev/sdf
fdisk: cannot open /dev/sdf: No such file or directory
vassaya@OTUS-PC:~$ sudo -i
root@OTUS-PC:~# sudo -i
root@OTUS-PC:~# pvcreate /dev/sdb
  Physical volume "/dev/sdb" successfully created.
root@OTUS-PC:~# vgcreate ubuntu-vg /dev/sdb
  Volume group "ubuntu-vg" successfully created
root@OTUS-PC:~# lvcreate -n ubuntu-lv -L 8G ubuntu-vg
  Logical volume "ubuntu-lv" created.
root@OTUS-PC:~# mkfs.ext4 /dev/ubuntu-vg/ubuntu-lv
mke2fs 1.47.0 (5-Feb-2023)
Creating filesystem with 2097152 4k blocks and 524288 inodes
Filesystem UUID: d8a3bad0-db36-484a-947f-8f72bcb17923
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done 

root@OTUS-PC:~# mount /dev/ubuntu-vg/ubuntu-lv /mnt
root@OTUS-PC:~# 

