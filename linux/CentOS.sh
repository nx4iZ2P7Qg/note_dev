# 默认yum源
# 备份系统自带yum源配置文件/etc/yum.repos.d/*
# 下载ailiyun的yum源配置文件到/etc/yum.repos.d/
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
# 生成缓存
yum makecache


# 安装 gnome
# 查看可以安装的 group 包
yum group list
# gnome
yum groupinstall "Server with GUI"
# 运行 gnome
startx


# 安装 VirtualBox Guest Additions
dnf install epel-release
dnf install gcc make perl kernel-devel kernel-headers bzip2 dkms
dnf update kernel-*
reboot
./VBoxLinuxAdditions.run


# 安装python3与yum
# http://blog.csdn.net/miaoqiucheng/article/details/73322937


# 重启gnome
# alt + F2, r


# 修改未启动的网卡
vi /etc/sysconfig/network-scripts/ifcfg-eno1
# 修改ONBOOT=no为yes，ifcfg-eno1名字可能会不同


# 如果BOOTPROTO=dhcp，重新启动网络服务后就可以拿到ip
systemctl restart network


# 查看主机名
hostname


# 修改主机名并立即生效
hostnamectl set-hostname nas-server


# 公网IP
curl ifconfig.me


# 安装go
# 下载安装包
# https://golang.org/dl/


# 安装五笔
yum install ibus ibus-table
yum install ibus ibus-table-wubi


# 查看CPU个数
cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l
# 查看核心数
cat /proc/cpuinfo| grep "cpu cores"| uniq
# 查看逻辑核心数
cat /proc/cpuinfo| grep "processor"| wc -l


# 设置静态IP
# vi /etc/sysconfig/network-scripts/ifcfg-enp0s3
# 变更
# BOOTPROTO="static"
# ONBOOT="yes"
# 添加
# IPADDR=192.168.13.241
# GATEWAY=192.168.13.1
# NETMASK=255.255.255.0
# 访问外网还需要添加 dns
echo nameserver 223.5.5.5 >> /etc/resolv.conf
# centos7 生效
systemctl restart network
# centos8 生效
nmcli c up enp0s3
