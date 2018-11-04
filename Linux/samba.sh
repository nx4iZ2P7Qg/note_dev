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
# 启动服务
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

groupadd sophia
useradd sophia -G sophia
smbpasswd -a sophia

# 验证配置文件
testparm

# 修改samba用户密码
smbpasswd Dexter password
