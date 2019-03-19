#!/usr/bin/env bash

# 以root登录
su

# 查看备份硬盘的smart status
smartctl -A /dev/sd.

# 查看备份硬盘的bit rot情况，需要btrfs硬盘格式
btrfs device stats /dev/sd.1

# 查看具体文件的操作
rsync -n -a --info=ALL -H -h -u --delete /mnt/sdc1/ /mnt/usb1/
# 去掉-n正式运行

# 默认以文件大小及修改日期决定是否更新，使用-c可以变更为以checksum来决定是否更新，需要大量时间
nohup rsync -a --info=ALL -H -h -u --delete /mnt/sdc1/ /mnt/usb1/ &
nohup rsync -a --info=ALL -H -h -u --delete /mnt/sdb1/PT/ /mnt/sde1/sdb1/ &

# 2T，不备份download，注意exclude指定的是src后的相对路径
rsync -n -a --info=ALL -H -h -u --delete --exclude net_disk/download /mnt/sdb1/ /mnt/sdd1/sdb1/

# 8T
rsync -n -a --info=ALL -H -h -u --delete --exclude net_disk/download /mnt/sde1/ /mnt/sdf1/
