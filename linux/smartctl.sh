# 安装
yum install smartmontools

# 检查硬盘是否支持smart
smartctl -i /dev/sda

# 检查硬盘健康状态
smartctl -H /dev/sda

# 查看全部信息
smartctl -A /dev/sda

# 检测硬盘
smartctl -t short /dev/sda # 后台检测硬盘，消耗时间短
smartctl -t long /dev/sda # 后台检测硬盘，消耗时间长
smartctl -C -t short /dev/sda # 前台检测硬盘，消耗时间短
smartctl -C -t long /dev/sda # 前台检测硬盘，消耗时间长
# 检测运输是否引起问题
smartctl -t conveyance /dev/sde
# 中断检测
smartctl -X /dev/sda

# 查看检测进度用结果，4T硬盘差不多需要10小时
smartctl -l selftest /dev/sda

# 查看错误日志
smartctl -l error /dev/sda