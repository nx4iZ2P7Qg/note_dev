# 官方一键安装
bash <(curl -L -s https://install.direct/go.sh)

systemctl enable v2ray
systemctl start v2ray

# 防火墙
firewall-cmd --permanent --zone=public --add-port=/tcp
firewall-cmd --permanent --zone=public --add-port=/udp
firewall-cmd --reload

# 大致说明参考
# https://since1989.org/vultr/v2ray-vmess-tcp-bbr-serverspeeder.html
wget –no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh
# 其中bbr不用配置，直接运行
sysctl -p

reboot
