# 安装firewalld
yum install firewalld
# 开启服务
systemctl start firewalld.service
#关闭
systemctl stop firewalld.service
# 开机自动启动
systemctl enable firewalld.service
# 关闭开机制动启动
systemctl disable firewalld.service

# 使用firewall-cmd 命令
# 查看状态
firewall-cmd --state
# 获取活动的区域
firewall-cmd --get-active-zones
# 获取所有支持的服务
firewall-cmd --get-service
# 重新加载防火墙
firewall-cmd --reload
# 启用某个服务，改变规则后要reload
firewall-cmd --zone=public --add-service=https
firewall-cmd --permanent --zone=public --add-service=https
# 开启某个端口
firewall-cmd --permanent --zone=public --add-port=8080-8081/tcp
firewall-cmd --zone=public --add-port=8080-8081/tcp
# 查看开启的端口和服务
firewall-cmd --permanent --zone=public --list-services
firewall-cmd --permanent --zone=public --list-ports
# 设置某个ip 访问某个服务，ip 192.168.0.4/24 访问 http
firewall-cmd --permanent --zone=public --add-rich-rule="rule family="ipv4" source address="192.168.0.4/24" service name="http" accept"
# 允许特定ip通过特定端口
firewall-cmd --permanent --zone=public --add-rich-rule='rule family=ipv4 source address=10.0.0.131 port port=3389 protocol=tcp accept'
# 删除上面设置的规则
firewall-cmd --permanent --zone=public --remove-rich-rule="rule family="ipv4" source address="192.168.0.4/24" service name="http" accept"
# 检查设定是否生效
iptables -L -n | grep 21
ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:21 ctstate NEW
# 执行命令
firewall-cmd --list-all
# 查询服务的启动状态
firewall-cmd --query-service ftp
yes
firewall-cmd --query-service ssh
yes
firewall-cmd --query-service samba
no
firewall-cmd --query-service http
no
# 自行加入要开放的 Port
firewall-cmd --add-port=3128/tcp
firewall-cmd --list-all