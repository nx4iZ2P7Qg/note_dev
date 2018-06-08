# 参考https://www.howtoforge.com/samba-server-installation-and-configuration-on-centos-7
# 教程说明如何在centos7上安装samba服务
# samba是开源软件，用来给samba客户端(比如windows)提供文件和打印机共享服务
# 本例中的hostname server1.example.com & IP as 192.168.0.100

# 首先保证相同的工作组workgroup
# windows中命令行输入
net config workstation

# 匿名samba
# 安装samba
yum install samba samba-client samba-common
# 备份samba配置
cp -pf /etc/samba/smb.conf /etc/samba/smb.conf.bak
# 从空文件开始配备，清空原文件
cat /dev/null > /etc/samba/smb.conf
# 配置内容
[global]
workgroup = WORKGROUP
server string = Samba Server %v
netbios name = centos
security = user
map to guest = bad user
dns proxy = no
#============================ Share Definitions ==============================
[Anonymous]
path = /samba/anonymous
browsable =yes
writable = yes
guest ok = yes
read only = no
# 补充文件夹，启动服务
mkdir -p /samba/anonymous
systemctl enable smb.service
systemctl enable nmb.service
systemctl restart smb.service
systemctl restart nmb.service
# 打开防火墙
firewall-cmd --permanent --zone=public --add-service=samba
firewall-cmd --reload
# 修改权限
cd /samba
chmod -R 0755 anonymous/
chown -R nobody:nobody anonymous/
# selinux处理
chcon -t samba_share_t anonymous/

# 安全samba
# 新建samba组用用户
groupadd smbgrp
useradd srijan -G smbgrp
smbpasswd -a srijan
# 新建文件夹
mkdir -p /samba/secured
# 修改权限
cd /samba
chmod -R 0777 secured/
chcon -t samba_share_t secured/
# 修改配置
[...]
[secured]
 path = /samba/secured
 valid users = @smbgrp
 guest ok = no
 writable = yes
 browsable = yes
# 重启服务
systemctl restart smb.service
systemctl restart nmb.service
# 验证配置文件
testparm
# 权限
cd /samba
chown -R srijan:smbgrp secured/



# 修改samba用户密码
smbpasswd Dexter password
