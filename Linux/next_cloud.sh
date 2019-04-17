# 配置php7.1源
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
# 安装
yum install php71w-devel php71w-fpm
# 查看module list
php -m

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
#	  # 用来防止http header提示，强制所有流量走https 
#	  <IfModule mod_headers.c>
#             Header always set Strict-Transport-Security "max-age=15552000; includeSubDomains"
#         </IfModule>
#
#         SetEnv HOME /var/www/nextcloud
#         SetEnv HTTP_HOME /var/www/nextcloud
#
# </Directory>

# 修改文件夹selinux
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/nextcloud/data(/.*)?'
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/nextcloud/config(/.*)?'
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/nextcloud/apps(/.*)?'
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/nextcloud/.htaccess'
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/nextcloud/.user.ini'
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/nextcloud/console.php'
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/nextcloud/version.php'
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/nextcloud/COPYING'
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/nextcloud/AUTHORS'
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/nextcloud/index.php'
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/nextcloud/status.php'
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/nextcloud/robots.txt'
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/nextcloud/occ'
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/nextcloud/remote.php'
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/nextcloud/cron.php'
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/nextcloud/index.html'
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/nextcloud/public.php'
restorecon -Rv '/var/www/nextcloud/'

# 查看https是否正确配置
openssl s_client -debug -connect df-host.asuscomm.com:30002

# 移动data目录的方法
https://help.nextcloud.com/t/howto-change-move-data-directory-after-installation/17170

# 也许有用的进阶安装向导
https://www.c-rieger.de/nextcloud-installation-guide-advanced/#excursion41

# 在nextcloud的目录下执行，可以重新扫描data目录下的文件到云盘数据库
sudo -u apache php console.php files:scan --all
# 扫描指定目录
sudo -u apache php console.php files:scan --path=dexter/files/video/video_ht/
# 有时刚刚扫描文件后，会遇到You don't have permission to upload or create files here的问题
# 一般是文件夹权限，user与group都设置成apache，data目录有写权限
# 有时一切正常，但还是有这个问题，可以将上面的扫描命令再执行一遍，就正常了
# 很明显的数据库保存了目录的权限，所以在
sudo chown apache:apache -R data
# 后，还需要刷新一次，就可以正常上传了

# 远程访问的trusted_domains
# 修改nextcloud/config/config.php，添加相应条目，通常是
# 1 => 'svrx.asuscomm.com:30002',

# 意外的停留在维护模式时
sudo -u apache php /var/www/nextcloud/occ maintenance:mode --off

# samba, selinux共存的问题
#
# nextcloud的data文件夹，只能指定一个地方
# 如果指定到本地磁盘，当用户多了后(用户目录在data/[username]，所属文件在下层/files)
# 文件很快就会占满本地磁盘，所以考虑放在/mnt盘上

# nextcloud/data目录会反复地重置权限为770，影响samba服务
# 添加用户到apache组解决
usermod -a -G apache dexter
# 可能需要重启smb

# /mnt最初是作为samba共享在使用，里面所有的文件只有一个selinux type，手动挂载时是samba_share_t
# 作为fstab挂载时可以指定，但也只有一个
# 如果需要samba访问的同时，又要httpd访问
# 官网给的解决方案，可能哪里和我的环境有不同，他们用的是
sudo setsebool httpd_use_cifs on
# 我这边无效，日志提示scontext=httpd_t, tcontext=samba_share_t, denied
#
# 暂时的解决办法
# 在fstab中配置type为public_content_rw_t，使得不同进程域可以访问
# 设置httpd匿名写入
sudo setsebool -P httpd_anon_write on
# 设置samba匿名写入
sudo setsebool -P smbd_anon_write on
#
# 问题在于httpd写入权限过大，不过这和初始要求完全相同
# 考虑将data的内容分开，一部分只读比较合适

# 缓存配置
# 安装
yum install redis
yum install php71w-pecl-redis
systemctl enable redis
systemctl start redis
# 修改nextcloud/config/config.php，添加以下内容
  'memcache.locking' => '\OC\Memcache\Redis',
  'memcache.local' => '\OC\Memcache\Redis',
  'redis' => array(
     'host' => 'localhost',
     'port' => 6379,
   ),
# 修改/etc/hosts，让localhost指向127.0.0.1
# 同时让httpd能访问redis端口，注意-m参数，不是-a
semanage port -m -t http_port_t -p tcp 6379
# 使用web interface上传文件
sudo setsebool -P httpd_unified 1
# 但安全原因又建议关闭此功能
# 删除
sudo semanage port -d -t http_port_t -p tcp 6379
# 允许http执行外部命令
setsebool -P httpd_execmem 1
setsebool -P httpd_can_network_connect 1

# 配置页的警告信息及解决办法
# Use of the the built in php mailer is no longer supported
# 在邮箱设置界面随便填个邮箱就行，等nc15，会有结果
# Your web server is not properly set up to resolve "/.well-known/caldav"
# 在sites-available/nextcloud.conf最后添加两行
Redirect 301 /.well-known/carddav /nextcloud/remote.php/dav
Redirect 301 /.well-known/caldav /nextcloud/remote.php/dav
# opcache
# 配好redis后，修改/etc/php.d/opcache.ini，逐条与页面对比
#The “Referrer-Policy” HTTP header is not set to “no-referrer”
# 修改nextcloud/.htaccess
# 在Header set X-Permitted-Cross-Domain-Policies "none"下面添加一行
# Header set Referrer-Policy "no-referrer"
