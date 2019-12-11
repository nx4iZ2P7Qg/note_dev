# 创建pv
    pvcreate /dev/sdb1
# 扩展已存在的vg
    vgextend centos /dev/sdb1
# 扩展已存在的lv    
    lvextend -L +31G /dev/centos/root
# 扩展
    xfs_growfs /dev/centos/root