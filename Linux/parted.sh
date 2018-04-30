# 选择硬盘
parted /dev/sdc
# 查看信息
p
# 创建gpt分区表
mklabel gpt
# 分区
mkpart primary xfs 0 100%
# 退出
quit
