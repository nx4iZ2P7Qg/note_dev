# 配置php7.1源
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
# 安装
yum install php71w-devel php71w-fpm
# 查看module list
php -m
# 对比官网安装向导，缺module dom，查找php-dom，可以看到需要安装php-xml包
yum provides php-dom
# 安装下面的包后解决
yum install php71w-xml.x86_64
# 缺少gd
yum install php71w-gd.x86_64
# 缺少mbstring
yum install php71w-mbstring.x86_64
# 缺少posix
yum install php71w-process.x86_64
# 安装数据库连接
yum install php71w-pgsql.x86_64
# 安装推荐包
yum install php71w-intl.x86_64
yum install php71w-mcrypt.x86_64
# 某些应用使用的包
yum install php71w-ldap.x86_64 php71w-snmp.x86_64 php71w-imap.x86_64

# 设置php开机启动
systemctl enable php-fpm.service
# 启动php
systemctl start php-fpm.service

# 安装apache2，就是httpd
yum install httpd.x86_64
# 防火墙
firewall-cmd --permanent --add-port=30001/tcp
firewall-cmd --permanent --add-port=30002/tcp
firewall-cmd --reload
# 启动，开机启动
systemctl start httpd
systemctl enable httpd
# 调整httpd端口
sed -i 's/^Listen 80/Listen 30001/' /etc/httpd/conf/httpd.conf
# 调整se端口
semanage port -a -t http_port_t -p tcp 30001
# 查看调整的端口
semanage port -l | grep http

# 不确定是修改了dexter到sudoer
# 还是修改了/var/www/nextcloud的所有人及组为apache
# 最后成功访问了页面
# httpd主线程是root，子线程是apache
# php-fpm一样

# 主流程参考
# https://www.marksei.com/install-nextcloud-13-centos-7/

# https配置参考
# https://www.techrepublic.com/article/how-to-enable-https-on-apache-centos/

# 最后，并没有使用virtual host的标签，直接使用了官网的<Directory>标签，加上上面链接的sites_available，
# sites_enabled，ln -s，改过证书

# 以下是配置文件的比较
# diff /etc/httpd/conf/httpd.conf httpd.conf
# 42c42
# < Listen 30001
# ---
# > Listen 80
# 96d95
# < ServerName CentOS7-20180421
# 355d353
# < IncludeOptional sites-enabled/*.conf

# diff /etc/httpd/conf.d/ssl.conf ssl.conf
# 5c5
# < Listen 30002 https
# ---
# > Listen 443 https
# 56c56
# < <VirtualHost _default_:30002>
# ---
# > <VirtualHost _default_:443>
# 100c100
# < SSLCertificateFile /etc/pki/tls/certs/ca.crt
# ---
# > SSLCertificateFile /etc/pki/tls/certs/localhost.crt
# 107c107
# < SSLCertificateKeyFile /etc/pki/tls/private/ca.key
# ---
# > SSLCertificateKeyFile /etc/pki/tls/private/localhost.key

# 服务文件配置，基本和官网一致
# Alias /nextcloud "/var/www/nextcloud/"
#
# <Directory "/var/www/nextcloud/">
#         DirectoryIndex index.html index.php
#         Options +FollowSymLinks
#         AllowOverride All
#         Require all granted
#
#         <IfModule mod_dav.c>
#             Dav off
#         </IfModule>
#
#         SetEnv HOME /var/www/nextcloud
#         SetEnv HTTP_HOME /var/www/nextcloud
#
# </Directory>

# 查看https是否正确配置
openssl s_client -debug -connect df-host.asuscomm.com:30002

# 移动data目录的方法
https://help.nextcloud.com/t/howto-change-move-data-directory-after-installation/17170

# 也许有用的进阶安装向导
https://www.c-rieger.de/nextcloud-installation-guide-advanced/#excursion41

# 在nextcloud的目录下执行，可以重新扫描data目录下的文件到云盘数据库
sudo -u apache php console.php files:scan --all