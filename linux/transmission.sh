# 下载最新的源
wget https://mirrors.tuna.tsinghua.edu.cn/epel/epel-release-latest-7.noarch.rpm
# 添加源
rpm -ivh epel-release-latest-7.noarch.rpm
# 安装
yum install transmission-cli transmission-common transmission-daemon
# 添加服务
systemctl enable transmission-daemon
# 启动服务初始化文件夹
systemctl start transmission-daemon
# 停止服务以修改配置
systemctl stop transmission-daemon
# 修改以下配置
vi /var/lib/transmission/.config/transmission-daemon/settings.json
# 添加防火墙规则
firewall-cmd --permanent --zone=public --add-port 9091/tcp
firewall-cmd --permanent --zone=public --add-port 9091/udp
# 51413用来处理peer
firewall-cmd --permanent --zone=public --add-port 51413/tcp
firewall-cmd --permanent --zone=public --add-port 51413/udp
firewall-cmd --reload
# 正式启动服务
systemctl start transmission-daemon
# 浏览器用以下地址访问
http://ipaddress:9091
# 默认web-ui比较弱，可以使用transgui
https://github.com/transmission-remote-gui/transgui

# 命令行查看任务状态
transmission-remote -n 'trans:pass_bt_0Z' -l