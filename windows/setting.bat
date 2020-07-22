# 删除占C盘空间的休眠文件
# 设置 - 系统 - 存储 - C盘系统和保留空间 - 休眠文件
# 管理员 cmd 
powercfg -h off
# 恢复
powercfg -h on
