# 参考
# https://wiki.archlinux.org/index.php/Hdparm
# https://docs.oracle.com/cd/E37670_01/E41138/html/ch07s03.html

# SCSI设备，使用sdparm

# 查看硬盘信息
sudo hdparm -I /dev/sda

# 查看硬盘Advanced Power Management(APM，高级电源设置)
sudo hdparm -B /dev/sda
# 设置硬盘APM
# 值域1-255，低代表省电，高代表性能
# 1-127允许停转，128-254不允许，255完全禁用此功能
sudo hdparm -B 127 /dev/sda

# 设置停转时间
# 0禁止
# 1-240乘5秒
# 240以上，减去240，再乘30分钟
# 比如，240代表20min，241代表30min，242代表1hour
sudo hdparm -S 240 /dev/sda

# 设置硬盘转速，降低噪音
sudo hdparm -M /dev/sdb

# 不唤醒硬盘，查询工作，停转状态
sudo smartctl -i -n standby /dev/sdb

# 使用udev让设置持续生效
