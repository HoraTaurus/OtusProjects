vassaya@OTUS-PC:~/Desktop/OtusProjects/2. Дисковая подсистема. Работа с mdadm$ ./create_raid5.sh 
=== Интерактивное создание RAID ===
Запустите скрипт с sudo!
vassaya@OTUS-PC:~/Desktop/OtusProjects/2. Дисковая подсистема. Работа с mdadm$ sudo ./create_raid5.sh 
=== Интерактивное создание RAID ===
Доступные диски:
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0    7:0    0     4K  1 loop /snap/bare/5
loop1    7:1    0 319.2M  1 loop /snap/code/182
loop2    7:2    0 329.6M  1 loop /snap/code/208
loop3    7:3    0  55.5M  1 loop /snap/core18/2940
loop4    7:4    0  55.5M  1 loop /snap/core18/2952
loop5    7:5    0  63.8M  1 loop /snap/core20/2669
loop6    7:6    0 246.4M  1 loop /snap/firefox/6738
loop7    7:7    0  73.9M  1 loop /snap/core22/2133
loop8    7:8    0  63.8M  1 loop /snap/core20/2599
loop9    7:9    0  73.9M  1 loop /snap/core22/2111
loop10   7:10   0  66.8M  1 loop /snap/core24/1151
loop11   7:11   0  66.8M  1 loop /snap/core24/1196
loop12   7:12   0  11.1M  1 loop /snap/firmware-updater/147
loop13   7:13   0  11.1M  1 loop /snap/firmware-updater/167
loop14   7:14   0  62.2M  1 loop /snap/github-gui/2
loop15   7:15   0 164.8M  1 loop /snap/gnome-3-28-1804/198
loop16   7:16   0 516.2M  1 loop /snap/gnome-42-2204/226
loop17   7:17   0   516M  1 loop /snap/gnome-42-2204/202
loop18   7:18   0 618.3M  1 loop /snap/gnome-46-2404/125
loop19   7:19   0  91.7M  1 loop /snap/gtk-common-themes/1535
loop20   7:20   0  10.8M  1 loop /snap/snap-store/1270
loop21   7:21   0 290.8M  1 loop /snap/mesa-2404/912
loop22   7:22   0  44.4M  1 loop /snap/snapd/23545
loop23   7:23   0  10.8M  1 loop /snap/snap-store/1248
loop24   7:24   0  50.8M  1 loop /snap/snapd/25202
loop25   7:25   0   576K  1 loop /snap/snapd-desktop-integration/315
loop26   7:26   0 247.1M  1 loop /snap/firefox/6836
loop27   7:27   0   568K  1 loop /snap/snapd-desktop-integration/253
loop28   7:28   0  64.7M  1 loop /snap/sublime-text/209
loop29   7:29   0  79.3M  1 loop /snap/telegram-desktop/6798
loop30   7:30   0  64.7M  1 loop /snap/sublime-text/217
sda      8:0    0   100G  0 disk 
├─sda1   8:1    0     1M  0 part 
└─sda2   8:2    0   100G  0 part /
sdb      8:16   0     1G  0 disk 
sdc      8:32   0     1G  0 disk 
sdd      8:48   0     1G  0 disk 
sde      8:64   0     1G  0 disk 
sdf      8:80   0     1G  0 disk 
sdg      8:96   0     1G  0 disk 
sr0     11:0    1  1024M  0 rom  
Создать RAID 5 из /dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf? (y/n): y
mdadm: layout defaults to left-symmetric
mdadm: layout defaults to left-symmetric
mdadm: chunk size defaults to 512K
mdadm: size set to 1046528K
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started.
Статус создания:
Personalities : [raid0] [raid1] [raid4] [raid5] [raid6] [raid10] [linear] 
md0 : active raid5 sdf[5](S) sde[3] sdd[2] sdc[1] sdb[0]
      4186112 blocks super 1.2 level 5, 512k chunk, algorithm 2 [5/4] [UUUU_]
      
unused devices: <none>
Ожидание сборки массива...
mke2fs 1.47.0 (5-Feb-2023)
Creating filesystem with 1046528 4k blocks and 261632 inodes
Filesystem UUID: 0782f6e1-54ef-4a3b-8664-f59e2a6a8849
Superblock backups stored on blocks: 
    32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done 

Готово!
/dev/md0:
           Version : 1.2
     Creation Time : Fri Oct  3 12:06:03 2025
        Raid Level : raid5
        Array Size : 4186112 (3.99 GiB 4.29 GB)
     Used Dev Size : 1046528 (1022.00 MiB 1071.64 MB)
      Raid Devices : 5
     Total Devices : 5
       Persistence : Superblock is persistent

       Update Time : Fri Oct  3 12:06:07 2025
             State : active, degraded, recovering 
    Active Devices : 4
   Working Devices : 5
    Failed Devices : 0
     Spare Devices : 1

            Layout : left-symmetric
        Chunk Size : 512K

Consistency Policy : resync

    Rebuild Status : 16% complete

              Name : OTUS-PC:0  (local to host OTUS-PC)
              UUID : 00323f09:6c5d4742:18196235:daaa6421
            Events : 4

    Number   Major   Minor   RaidDevice State
       0       8       16        0      active sync   /dev/sdb
       1       8       32        1      active sync   /dev/sdc
       2       8       48        2      active sync   /dev/sdd
       3       8       64        3      active sync   /dev/sde
       5       8       80        4      spare rebuilding   /dev/sdf
vassaya@OTUS-PC:~/Desktop/OtusProjects/2. Дисковая подсистема. Работа с mdadm$ cat /proc/mdstat
Personalities : [raid0] [raid1] [raid4] [raid5] [raid6] [raid10] [linear] 
md0 : active raid5 sdf[5] sde[3] sdd[2] sdc[1] sdb[0]
      4186112 blocks super 1.2 level 5, 512k chunk, algorithm 2 [5/5] [UUUUU]
      
unused devices: <none>
vassaya@OTUS-PC:~/Desktop/OtusProjects/2. Дисковая подсистема. Работа с mdadm$ cd ~
vassaya@OTUS-PC:~$ mdadm -D /dev/md0
mdadm: must be super-user to perform this action
vassaya@OTUS-PC:~$ sudo mdadm -D /dev/md0
[sudo] password for vassaya: 
/dev/md0:
           Version : 1.2
     Creation Time : Fri Oct  3 12:06:03 2025
        Raid Level : raid5
        Array Size : 4186112 (3.99 GiB 4.29 GB)
     Used Dev Size : 1046528 (1022.00 MiB 1071.64 MB)
      Raid Devices : 5
     Total Devices : 5
       Persistence : Superblock is persistent

       Update Time : Fri Oct  3 12:06:47 2025
             State : clean 
    Active Devices : 5
   Working Devices : 5
    Failed Devices : 0
     Spare Devices : 0

            Layout : left-symmetric
        Chunk Size : 512K

Consistency Policy : resync

              Name : OTUS-PC:0  (local to host OTUS-PC)
              UUID : 00323f09:6c5d4742:18196235:daaa6421
            Events : 24

    Number   Major   Minor   RaidDevice State
       0       8       16        0      active sync   /dev/sdb
       1       8       32        1      active sync   /dev/sdc
       2       8       48        2      active sync   /dev/sdd
       3       8       64        3      active sync   /dev/sde
       5       8       80        4      active sync   /dev/sdf
vassaya@OTUS-PC:~$ mdadm /dev/md0 --fail /dev/sde
mdadm: error opening /dev/md0: Permission denied
vassaya@OTUS-PC:~$ sudo mdadm /dev/md0 --fail /dev/sde
mdadm: set /dev/sde faulty in /dev/md0
vassaya@OTUS-PC:~$ cat /proc/mdstat
Personalities : [raid0] [raid1] [raid4] [raid5] [raid6] [raid10] [linear] 
md0 : active raid5 sdf[5] sde[3](F) sdd[2] sdc[1] sdb[0]
      4186112 blocks super 1.2 level 5, 512k chunk, algorithm 2 [5/4] [UUU_U]
      
unused devices: <none>
vassaya@OTUS-PC:~$ sudo mdadm -D /dev/md0
/dev/md0:
           Version : 1.2
     Creation Time : Fri Oct  3 12:06:03 2025
        Raid Level : raid5
        Array Size : 4186112 (3.99 GiB 4.29 GB)
     Used Dev Size : 1046528 (1022.00 MiB 1071.64 MB)
      Raid Devices : 5
     Total Devices : 5
       Persistence : Superblock is persistent

       Update Time : Fri Oct  3 12:35:11 2025
             State : clean, degraded 
    Active Devices : 4
   Working Devices : 4
    Failed Devices : 1
     Spare Devices : 0

            Layout : left-symmetric
        Chunk Size : 512K

Consistency Policy : resync

              Name : OTUS-PC:0  (local to host OTUS-PC)
              UUID : 00323f09:6c5d4742:18196235:daaa6421
            Events : 26

    Number   Major   Minor   RaidDevice State
       0       8       16        0      active sync   /dev/sdb
       1       8       32        1      active sync   /dev/sdc
       2       8       48        2      active sync   /dev/sdd
       -       0        0        3      removed
       5       8       80        4      active sync   /dev/sdf

       3       8       64        -      faulty   /dev/sde
vassaya@OTUS-PC:~$ mdadm /dev/md0 --remove /dev/sde
mdadm: error opening /dev/md0: Permission denied
vassaya@OTUS-PC:~$ sudo mdadm /dev/md0 --remove /dev/sde
mdadm: hot removed /dev/sde from /dev/md0
vassaya@OTUS-PC:~$ sudo mdadm -D /dev/md0
/dev/md0:
           Version : 1.2
     Creation Time : Fri Oct  3 12:06:03 2025
        Raid Level : raid5
        Array Size : 4186112 (3.99 GiB 4.29 GB)
     Used Dev Size : 1046528 (1022.00 MiB 1071.64 MB)
      Raid Devices : 5
     Total Devices : 4
       Persistence : Superblock is persistent

       Update Time : Fri Oct  3 12:36:08 2025
             State : clean, degraded 
    Active Devices : 4
   Working Devices : 4
    Failed Devices : 0
     Spare Devices : 0

            Layout : left-symmetric
        Chunk Size : 512K

Consistency Policy : resync

              Name : OTUS-PC:0  (local to host OTUS-PC)
              UUID : 00323f09:6c5d4742:18196235:daaa6421
            Events : 27

    Number   Major   Minor   RaidDevice State
       0       8       16        0      active sync   /dev/sdb
       1       8       32        1      active sync   /dev/sdc
       2       8       48        2      active sync   /dev/sdd
       -       0        0        3      removed
       5       8       80        4      active sync   /dev/sdf
vassaya@OTUS-PC:~$ mdadm /dev/md0 --add /dev/sde
mdadm: error opening /dev/md0: Permission denied
vassaya@OTUS-PC:~$ sudo mdadm /dev/md0 --add /dev/sde
mdadm: added /dev/sde
vassaya@OTUS-PC:~$ cat /proc/mdstat
Personalities : [raid0] [raid1] [raid4] [raid5] [raid6] [raid10] [linear] 
md0 : active raid5 sde[6] sdf[5] sdd[2] sdc[1] sdb[0]
      4186112 blocks super 1.2 level 5, 512k chunk, algorithm 2 [5/4] [UUU_U]
      [===========>.........]  recovery = 55.2% (578168/1046528) finish=0.2min speed=36135K/sec
      
unused devices: <none>
vassaya@OTUS-PC:~$ cat /proc/mdstat
Personalities : [raid0] [raid1] [raid4] [raid5] [raid6] [raid10] [linear] 
md0 : active raid5 sde[6] sdf[5] sdd[2] sdc[1] sdb[0]
      4186112 blocks super 1.2 level 5, 512k chunk, algorithm 2 [5/5] [UUUUU]
      
unused devices: <none>
vassaya@OTUS-PC:~$ sudo parted -s /dev/md0 mklabel gpt
Error: Partition(s) on /dev/md0 are being used.
vassaya@OTUS-PC:~$ for i in $(seq 1 5); do
    start=$(( (i-1)*20 ))
    end=$(( i*20 ))
    parted /dev/md0 mkpart primary ext4 ${start}% ${end}%
done
WARNING: You are not superuser.  Watch out for permissions.
Error: Error opening /dev/md0: Permission denied
Retry/Cancel? Cancel                                                      
WARNING: You are not superuser.  Watch out for permissions.
Error: Error opening /dev/md0: Permission denied
Retry/Cancel? Cancel 
WARNING: You are not superuser.  Watch out for permissions.
Error: Error opening /dev/md0: Permission denied
Retry/Cancel? ^C                                                          
WARNING: You are not superuser.  Watch out for permissions.
Error: Error opening /dev/md0: Permission denied
Retry/Cancel? ^Z                                                          
[1]+  Stopped                 parted /dev/md0 mkpart primary ext4 ${start}% ${end}%
vassaya@OTUS-PC:~$ sudo for i in $(seq 1 5); do     start=$(( (i-1)*20 ));     end=$(( i*20 ));     parted /dev/md0 mkpart primary ext4 ${start}% ${end}%; done
bash: syntax error near unexpected token `do'
vassaya@OTUS-PC:~$ sudo for i in $(seq 1 5); do start=$(( (i-1)*20 )); end=$(( i*20 )); parted /dev/md0 mkpart primary ext4 ${start}% ${end}%; done
bash: syntax error near unexpected token `do'
vassaya@OTUS-PC:~$ sudo parted -s /dev/md0 mklabel gpt
Error: Partition(s) on /dev/md0 are being used.
vassaya@OTUS-PC:~$ sudo parted /dev/md0 mkpart primary ext4 0% 20%
parted: invalid token: primary
File system type?  [ext2]? ^C                                             
Error: Expecting a file system type.
vassaya@OTUS-PC:~$ sudo sudo parted /dev/md0 mkpart 0% 20%
Error: Too many primary partitions.
vassaya@OTUS-PC:~$ ^C                                                     
vassaya@OTUS-PC:~$ sudo parted /dev/md0 mkpart 0% 20%
Error: Too many primary partitions.
vassaya@OTUS-PC:~$ sudo parted /dev/md0 mklabel gpt                       
Warning: Partition(s) on /dev/md0 are being used.
Ignore/Cancel? Ignore 
Warning: The existing disk label on /dev/md0 will be destroyed and all data on
this disk will be lost. Do you want to continue?
Yes/No? Yes                                                               
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 mkpart primary ext4 0% 20%        
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 mkpart primary ext4 20% 40%
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 mkpart primary ext4 40% 60%      
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 mkpart primary ext4 60% 80%      
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 mkpart primary ext4 80% 100%     
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo for i in $(seq 1 5); do sudo mkfs.ext4 /dev/md0p$i; donebash: syntax error near unexpected token `do'
vassaya@OTUS-PC:~$ ^C
vassaya@OTUS-PC:~$ ^C
vassaya@OTUS-PC:~$ sudo parted /dev/md0 print
Error: The primary GPT table is corrupt, but the backup appears OK, so that will
be used.
OK/Cancel? Cancel                                                         
Model: Linux Software RAID Array (md)
Disk /dev/md0: 4287MB
Sector size (logical/physical): 512B/512B
Partition Table: unknown
Disk Flags: 
vassaya@OTUS-PC:~$ sudo parted /dev/md0 print
Error: The primary GPT table is corrupt, but the backup appears OK, so that will
be used.
OK/Cancel? OK
Model: Linux Software RAID Array (md)
Disk /dev/md0: 4287MB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size   File system  Name     Flags
 1      2097kB  858MB   856MB               primary
 2      858MB   1715MB  858MB               primary
 3      1715MB  2571MB  856MB               primary
 4      2571MB  3429MB  858MB               primary
 5      3429MB  4284MB  856MB               primary

vassaya@OTUS-PC:~$ sudo parted /dev/md0 mkpart part1 0% 20%
Error: The primary GPT table is corrupt, but the backup appears OK, so that will
be used.
OK/Cancel? OK
Partition name?  []? part1                                                
File system type?  [ext2]? ext4
Start? 0%                                                                 
End? 20%                                                                  
Warning: You requested a partition from 0.00B to 857MB (sectors 0..1674444).
The closest location we can manage is 17.4kB to 2097kB (sectors 34..4095).
Is this still acceptable to you?
Yes/No? Yes                                                               
Warning: The resulting partition is not properly aligned for best performance:
34s % 4096s != 0s
Ignore/Cancel? Ignore                                                     
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 mkpart part2 2% 40%
Warning: You requested a partition from 85.7MB to 1715MB (sectors
167444..3348889).
The closest location we can manage is 4284MB to 4284MB (sectors
8368128..8368128).
Is this still acceptable to you?
Yes/No? Yes                                                               
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 mkpart part2 20% 40%               
Warning: You requested a partition from 857MB to 1715MB (sectors
1674444..3348889).
The closest location we can manage is 4284MB to 4284MB (sectors
8368129..8368129).
Is this still acceptable to you?
Yes/No? Yes                                                               
Warning: The resulting partition is not properly aligned for best performance:
8368129s % 4096s != 0s
Ignore/Cancel? Ignore                                                     
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 mkpart part3 40% 60%             
Warning: You requested a partition from 1715MB to 2572MB (sectors
3348889..5023334).
The closest location we can manage is 4284MB to 4284MB (sectors
8368130..8368130).
Is this still acceptable to you?
Yes/No? Yes                                                               
Warning: The resulting partition is not properly aligned for best performance:
8368130s % 4096s != 0s
Ignore/Cancel? Ignore                                                     
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 print
Model: Linux Software RAID Array (md)
Disk /dev/md0: 4287MB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system  Name     Flags
 6      17.4kB  2097kB  2080kB               part1
 1      2097kB  858MB   856MB                primary
 2      858MB   1715MB  858MB                primary
 3      1715MB  2571MB  856MB                primary
 4      2571MB  3429MB  858MB                primary
 5      3429MB  4284MB  856MB                primary
 7      4284MB  4284MB  512B                 part2
 8      4284MB  4284MB  512B                 part2
 9      4284MB  4284MB  512B                 part3

vassaya@OTUS-PC:~$ sudo parted /dev/md0 rm 1
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 rm 2
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 rm 3
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 rm 4
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 rm 5
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 rm 6
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 rm 7
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 rm 8
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 rm 9
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 print                             
Model: Linux Software RAID Array (md)
Disk /dev/md0: 4287MB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start  End  Size  File system  Name  Flags

vassaya@OTUS-PC:~$ ^C
vassaya@OTUS-PC:~$ sudo parted /dev/md0 mklabel gpt
Warning: Partition(s) on /dev/md0 are being used.
Ignore/Cancel? Ignore 
Warning: The existing disk label on /dev/md0 will be destroyed and all data on
this disk will be lost. Do you want to continue?
Yes/No? Yes                                                               
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 mkpart part1 0% 20%               
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 mkpart part2 20% 40%              
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 mkpart part3 40% 60%              
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 mkpart part4 60% 80%              
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 mkpart part5 80% 100%             
Information: You may need to update /etc/fstab.

vassaya@OTUS-PC:~$ sudo parted /dev/md0 print                             
Model: Linux Software RAID Array (md)
Disk /dev/md0: 4287MB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size   File system  Name   Flags
 1      2097kB  858MB   856MB               part1
 2      858MB   1715MB  858MB               part2
 3      1715MB  2571MB  856MB               part3
 4      2571MB  3429MB  858MB               part4
 5      3429MB  4284MB  856MB               part5

vassaya@OTUS-PC:~$ ^C
vassaya@OTUS-PC:~$ sudo mkfs.ext4 /dev/md0p1
mke2fs 1.47.0 (5-Feb-2023)
/dev/md0p1 is apparently in use by the system; will not make a filesystem here!
vassaya@OTUS-PC:~$ sudo mkfs.ext4 /dev/md0p2
mke2fs 1.47.0 (5-Feb-2023)
/dev/md0p2 is apparently in use by the system; will not make a filesystem here!
vassaya@OTUS-PC:~$ sudo mkfs.ext4 /dev/md0p3
mke2fs 1.47.0 (5-Feb-2023)
/dev/md0p3 is apparently in use by the system; will not make a filesystem here!
vassaya@OTUS-PC:~$ sudo mkfs.ext4 /dev/md0p4
mke2fs 1.47.0 (5-Feb-2023)
/dev/md0p4 is apparently in use by the system; will not make a filesystem here!
vassaya@OTUS-PC:~$ sudo mkfs.ext4 /dev/md0p5
mke2fs 1.47.0 (5-Feb-2023)
/dev/md0p5 is apparently in use by the system; will not make a filesystem here!
vassaya@OTUS-PC:~$ sudo lsof /dev/md0p1
lsof: WARNING: can't stat() fuse.portal file system /run/user/1000/doc
      Output information may be incomplete.
lsof: WARNING: can't stat() fuse.gvfsd-fuse file system /run/user/1000/gvfs
      Output information may be incomplete.
vassaya@OTUS-PC:~$ sudo dmsetup ls
No devices found
vassaya@OTUS-PC:~$ sudo lsblk -f /dev/md0
NAME    FSTYPE FSVER LABEL UUID FSAVAIL FSUSE% MOUNTPOINTS
md0                                   0   100% /mnt/raid5
├─md0p1                                        
├─md0p2                                        
├─md0p3                                        
├─md0p4                                        
└─md0p5                                        
vassaya@OTUS-PC:~$ sudo modprobe -r dm_mod
modprobe: FATAL: Module dm_mod is builtin.
vassaya@OTUS-PC:~$ sudo modprobe dm_mod
vassaya@OTUS-PC:~$ sudo mkfs.ext4 -F /dev/md0p1
mke2fs 1.47.0 (5-Feb-2023)
/dev/md0p1 is apparently in use by the system; will not make a filesystem here!
vassaya@OTUS-PC:~$ sudo umount /mnt/raid5
vassaya@OTUS-PC:~$ df -h | grep md0
vassaya@OTUS-PC:~$ sudo mkfs.ext4 /dev/md0p1
mke2fs 1.47.0 (5-Feb-2023)
Creating filesystem with 208896 4k blocks and 52304 inodes
Filesystem UUID: 53d114f2-edda-4b3a-ab2c-49cbf534f2d7
Superblock backups stored on blocks: 
    32768, 98304, 163840

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

vassaya@OTUS-PC:~$ sudo mkfs.ext4 /dev/md0p2
mke2fs 1.47.0 (5-Feb-2023)
Creating filesystem with 209408 4k blocks and 52416 inodes
Filesystem UUID: 6d7a4bf1-e2f5-4c82-a172-b468f49c1b82
Superblock backups stored on blocks: 
    32768, 98304, 163840

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

vassaya@OTUS-PC:~$ sudo mkfs.ext4 /dev/md0p3
mke2fs 1.47.0 (5-Feb-2023)
Creating filesystem with 208896 4k blocks and 52304 inodes
Filesystem UUID: df242000-29e4-4853-adb4-35066c6f340b
Superblock backups stored on blocks: 
    32768, 98304, 163840

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

vassaya@OTUS-PC:~$ sudo mkfs.ext4 /dev/md0p4
mke2fs 1.47.0 (5-Feb-2023)
Creating filesystem with 209408 4k blocks and 52416 inodes
Filesystem UUID: 6cd6e172-4116-4cf0-917b-b277f8a29965
Superblock backups stored on blocks: 
    32768, 98304, 163840

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

vassaya@OTUS-PC:~$ sudo mkfs.ext4 /dev/md0p5
mke2fs 1.47.0 (5-Feb-2023)
Creating filesystem with 208896 4k blocks and 52304 inodes
Filesystem UUID: 780f4835-1551-4c0c-aa0f-dbaa92b78b91
Superblock backups stored on blocks: 
    32768, 98304, 163840

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

vassaya@OTUS-PC:~$ sudo lsblk -f /dev/md0
NAME FSTYPE FSVER LABEL UUID                                 FSAVAIL FSUSE% MOUNTPOINTS
md0                                                                         
├─md0p1
│    ext4   1.0         53d114f2-edda-4b3a-ab2c-49cbf534f2d7                
├─md0p2
│    ext4   1.0         6d7a4bf1-e2f5-4c82-a172-b468f49c1b82                
├─md0p3
│    ext4   1.0         df242000-29e4-4853-adb4-35066c6f340b                
├─md0p4
│    ext4   1.0         6cd6e172-4116-4cf0-917b-b277f8a29965                
└─md0p5
     ext4   1.0         780f4835-1551-4c0c-aa0f-dbaa92b78b91                
vassaya@OTUS-PC:~$ sudo parted /dev/md0 print
Error: The primary GPT table is corrupt, but the backup appears OK, so that will
be used.
OK/Cancel? OK
Model: Linux Software RAID Array (md)
Disk /dev/md0: 4287MB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size   File system  Name   Flags
 1      2097kB  858MB   856MB  ext4         part1
 2      858MB   1715MB  858MB  ext4         part2
 3      1715MB  2571MB  856MB  ext4         part3
 4      2571MB  3429MB  858MB  ext4         part4
 5      3429MB  4284MB  856MB  ext4         part5

vassaya@OTUS-PC:~$ sudo nano /etc/fstab
vassaya@OTUS-PC:~$ mkdir -p /raid/part{1,2,3,4,5}
mkdir: cannot create directory ‘/raid’: Permission denied
mkdir: cannot create directory ‘/raid’: Permission denied
mkdir: cannot create directory ‘/raid’: Permission denied
mkdir: cannot create directory ‘/raid’: Permission denied
mkdir: cannot create directory ‘/raid’: Permission denied
vassaya@OTUS-PC:~$ sudo mkdir -p /raid/part{1,2,3,4,5}
vassaya@OTUS-PC:~$ for i in $(seq 1 5); do mount /dev/md0p$i /raid/part$i; done
mount: /raid/part1: must be superuser to use mount.
       dmesg(1) may have more information after failed mount system call.
mount: (hint) your fstab has been modified, but systemd still uses
       the old version; use 'systemctl daemon-reload' to reload.
mount: /raid/part2: must be superuser to use mount.
       dmesg(1) may have more information after failed mount system call.
mount: (hint) your fstab has been modified, but systemd still uses
       the old version; use 'systemctl daemon-reload' to reload.
mount: /raid/part3: must be superuser to use mount.
       dmesg(1) may have more information after failed mount system call.
mount: (hint) your fstab has been modified, but systemd still uses
       the old version; use 'systemctl daemon-reload' to reload.
mount: /raid/part4: must be superuser to use mount.
       dmesg(1) may have more information after failed mount system call.
mount: (hint) your fstab has been modified, but systemd still uses
       the old version; use 'systemctl daemon-reload' to reload.
mount: /raid/part5: must be superuser to use mount.
       dmesg(1) may have more information after failed mount system call.
mount: (hint) your fstab has been modified, but systemd still uses
       the old version; use 'systemctl daemon-reload' to reload.
vassaya@OTUS-PC:~$ 
