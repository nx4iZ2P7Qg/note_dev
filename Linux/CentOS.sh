# 查看可以安装的group包
yum grouplist
# 安装gnome环境，使用-y可以跳过确认
yum install "GNOME Desktop"
# 运行gnome
startx

# 挂载点
cd /run/media/dexter/
# 安装VBoxAddition
./VBoxLinuxAddition.sh
# 缺少gcc
yum install gcc

# 安装python3与yum
http://blog.csdn.net/miaoqiucheng/article/details/73322937

# 重启gnome
alt + F2, r

# 查看网络情况
ip addr

# 修改未启动的网卡
vi /etc/sysconfig/network-scripts/ifcfg-eno1
# 修改ONBOOT=no为yes，ifcfg-eno1名字可能会不同

# 如果BOOTPROTO=dhcp，重新启动网络服务后就可以拿到ip
systemctl restart network

# 查看主机名
hostname

# 修改主机名并立即生效
hostnamectl set-hostname nas-server