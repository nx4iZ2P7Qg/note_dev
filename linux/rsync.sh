#!/usr/bin/env bash

# 查看具体文件的操作
rsync -n -a --info=ALL -H -h -u --delete /mnt/sdc1/ /mnt/usb1/
# 去掉-n正式运行

# 默认以文件大小及修改日期决定是否更新，使用-c可以变更为以checksum来决定是否更新，需要大量时间
nohup rsync -a --info=ALL -H -h -u --delete /mnt/sdc1/ /mnt/usb1/ &
nohup rsync -a --info=ALL -H -h -u --delete /mnt/sdb1/PT/ /mnt/sde1/sdb1/ &

# 2T，不备份download，注意exclude指定的是src后的相对路径
rsync -n -a --info=ALL -H -h -u --delete --exclude net_disk/download --exclude aria2 /mnt/sdb1/ /mnt/usb1/

# 4T d2 s2
mount /dev/disk/by-uuid/5b21df7e-b418-4311-b9e0-2f763ecd0dc4 /mnt/ud2
rsync -n -a --info=ALL -H -h -u --delete /mnt/d2/ /mnt/ud2/
umount /mnt/ud2

# 8T d3 s3
mount /dev/disk/by-uuid/f88814cd-9567-4f37-a168-9fce3ead28ed /mnt/ud3
rsync -n -a --info=ALL -H -h -u --delete /mnt/d3/ /mnt/ud3/
umount /mnt/ud3

# 8T d7 vid
mount /dev/disk/by-uuid/9e6e9617-0057-41df-9915-098f80bf13bb /mnt/ud7
rsync -n -a --info=ALL -H -h -u --delete /mnt/d7/ /mnt/ud7/
umount /mnt/ud7

# 8T d8 xxx
mount /dev/disk/by-uuid/154590c5-50a2-431e-b2e8-f3eb088cdca0 /mnt/ud8
rsync -n -a --info=ALL -H -h -u --delete /mnt/d8/ /mnt/ud8/
umount /mnt/ud8
