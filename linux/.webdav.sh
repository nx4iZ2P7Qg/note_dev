# 建立webdav文件共享

# 检查apache2是否包含webdav模块，默认是包含且开启的
sudo httpd -M | grep fs
# 如果出现dav_fs_module(shared)表示正常

# 建立欲共享的webdav文件夹
sudo mkdir /mnt/sdb1/webdav_sophie
# 调整权限
sudo chown -R apache:apache /mnt/sdb1/webdav_sophie
sudo chmod -R 755 /mnt/sdb1/webdav_sophie

# 设置密码
sudo htpasswd -c /etc/httpd/.htpasswd sophia
# 调整权限
sudo chown root:apache /etc/httpd/.htpasswd
sudo chmod 640 /etc/httpd/.htpasswd

# 配置apache2服务器
sudo vi /etc/httpd/conf.d/webdav_sophie.conf
# 内容如下
ServerAdmin webmaster@localhost
DocumentRoot /mnt/sdb1/webdav_sophie
ErrorLog /var/log/httpd/error_webdav_sophie.log
CustomLog /var/log/httpd/access_webdav_sophie.log combined
Alias /webdav_sophie /mnt/sdb1/webdav_sophie
<Directory /mnt/sdb1/webdav_sophie>
    DAV On
    AuthType Basic
    AuthName "sophia"
    AuthUserFile /etc/httpd/.htpasswd
    Require valid-user
</Directory>

# 重启apache2服务，测试