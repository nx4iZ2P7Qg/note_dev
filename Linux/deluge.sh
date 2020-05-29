# 安装下载器
yum install wget
# 下载及添加源
wget http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
rpm -ivh nux-dextop-release-0-5.el7.nux.noarch.rpm
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -ivh epel-release-latest-7.noarch.rpm
# 安装
yum install deluge-web
# 开启web的ssl，web中的远程访问不是指web是否可以远程(web始终可以)，而是deluged是否可以远程
# 将自签的证书放在/var/lib/deluge/.config/deluge/ssl，在web界面勾选use ssl，选择证书及密钥，重启
systemctl restart deluge-web
# 防火墙
firewall-cmd --permanent --zone=public --add-port 8112/tcp
firewall-cmd
# 启动服务
systemctl start deluge-web
# 浏览器访问ipaddress:8112