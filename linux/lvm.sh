# pv 对应硬盘分区
# vg 对应一组 pv
# lv 对应逻辑分区

# 创建pv
pvcreate /dev/sdb1
# 扩展已存在的vg
vgextend centos /dev/sdb1
# 扩展已存在的lv    
lvextend -L +31G /dev/centos/root
# 扩展
xfs_growfs /dev/centos/root


# 删除 /home lv，全部扩展至 /
# 卸载
umount /home
# 移除lv
lvremove /dev/centos/home
# 查看vg剩余空间
vgs
# 扩展相应lv
lvextend -L +856.88G /dev/centos/root
# 生效 ext
resize2fs /dev/centos/root
# 生效 xfs
xfs_growfs /dev/centos/root
# 删除 /home 的自动挂载
vi /etc/fstab