# 启动 crontab 日志
vi /etc/rsyslog.conf
# 反注释以下行
# cron.*                          /var/log/cron.log
# 重启
systemctl restart rsyslog
