# 修改端口号
vi /etc/httpd/conf.d/ssl.conf
# 添加selinux策略
semanage port -a -t http_port_t -p tcp 302
# 处理防火墙