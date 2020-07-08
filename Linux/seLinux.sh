sestatus # 查看selinux状态
setenforce 0 # 暂时关闭se
setenforce 1 # 暂时开启se
sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config # 关闭selinux，重启生效
# SELinux 遵从最小权限，strict（严格型）编写很困难，会为系统管理员及用户带来使用不便
# CentOS预置政策是targeted，CentOS4定义了15个目标，CentOS5超过200个，其他进程，用户程式和自制程式都在unConfined区域运行
# 不纳入se的保护范围
# 这样做的目的，让每个已安装及开机时在运行的程序，都在一个预设的范围内运行
# targeted在设计时尽量保护最多的主要进程，同时不影响用户使用，多数用户都察觉不到se在运行

# targeted主要包含4种存取方法
# 强制类别 - TE，targeted的主要机制
# 基于角色的存取控制 - RBAC，以selinux用户为基础，预设未采用
# 多层保障 - MLS，普遍不获采用
# 多种类保护 - MCS，多层保护的延伸，
# 所有进程及档案都有一个se安全性脉络