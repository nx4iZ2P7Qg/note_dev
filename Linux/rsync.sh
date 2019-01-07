#!/usr/bin/env bash

# 以root登录
su
# 查看具体文件的操作
rsync -n -a --info=ALL -H -u --delete /mnt/sdc1/ /mnt/usb1/
# 正式运行
# 默认以文件大小及修改日期决定是否更新，使用-c可以变更为以checksum来决定是否更新，需要大量时间
nohup rsync -a --info=ALL -H -u --delete /mnt/sdc1/ /mnt/usb1/ &
nohup rsync -a --info=ALL -H -u --delete /mnt/sdb1/PT/ /mnt/sde1/sdb1/ &