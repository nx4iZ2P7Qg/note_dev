# 选择设备，进入交互模式
parted /dev/sdc
# 退出
# q

# 指令模式
# 查看信息
parted /dev/sdc p
# 创建gpt分区表
parted /dev/sdc mklabel gpt
# 分区
parted /dev/sdc mkpart '{{volume name}}' btrfs 1 100%
