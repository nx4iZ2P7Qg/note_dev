# debian 安装
apt-get install btrfs-tools

# 查看bit rot情况，corruption_errs
btrfs device stats /mnt/d1

# 完整性检查




[root@localhost ~]# lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda           8:0    0  128G  0 disk
├─sda1        8:1    0    1G  0 part /boot
└─sda2        8:2    0  127G  0 part
  ├─cl-root 252:0    0  123G  0 lvm  /
  └─cl-swap 252:1    0    4G  0 lvm  [SWAP]
sdb           8:16   0    8G  0 disk
sdc           8:32   0    8G  0 disk
sdd           8:48   0    8G  0 disk
sde           8:64   0   16G  0 disk
sr0          11:0    1 1024M  0 rom

-f 是强制，会清除掉已有的文件系统
-d 是 data
-m 是 metadata
[root@localhost ~]# mkfs.btrfs -f -d raid0 -m raid1 /dev/sdb /dev/sdc /dev/sdd
btrfs-progs v5.4
See http://btrfs.wiki.kernel.org for more information.

Label:              (null)
UUID:               b0cc45c9-52f3-4aec-8395-900c2c0d2546
Node size:          16384
Sector size:        4096
Filesystem size:    24.00GiB
Block group profiles:
  Data:             RAID0             2.40GiB
  Metadata:         RAID1           256.00MiB
  System:           RAID1             8.00MiB
SSD detected:       no
Incompat features:  extref, skinny-metadata
Checksum:           crc32c
Number of devices:  3
Devices:
   ID        SIZE  PATH
    1     8.00GiB  /dev/sdb
    2     8.00GiB  /dev/sdc
    3     8.00GiB  /dev/sdd

可以看到 size 是 3 * 8 = 24


看起来可以转换 raid 级别
btrfs balance start -dconvert=raid1 -mconvert=raid1 /home

使用其中任何一个设备，都可以将 raid 挂载
mount /dev/sdb mnt/

写入数据后，会发现分别写入3个虚拟硬盘，大小差不多

重启后需要扫描
btrfs device scan

打印出本机 btrfs 信息
btrfs filesystem show

查看大小
btrfs fi df mnt

添加新设备
btrfs device add /dev/sde /root/mnt

使新设备生效，需要关注 filter options
btrfs balance start /root/mnt

删除，数据转移到其他 dev
btrfs device delete /dev/sde /root/mnt

看起来 raid0 能否救回来的关键是，delete 命令能否正常完成

需要测试 raid0 与 single 的性能差别

官方建议，如果硬盘出现问题，不要使用 add, delete
mount -o degraded /dev/sdb /mnt
sudo btrfs replace start 7 /dev/sdf /root/mnt



硬盘读取故障，可以拿去修，磁盘与数据没坏，换机械设备
