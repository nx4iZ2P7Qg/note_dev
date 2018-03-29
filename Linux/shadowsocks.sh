# CentOS 7
# 安装 pip
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
python get-pip.py
# 安装配置 shadowsocks
pip install --upgrade pip
pip install shadowsocks
# 创建配置文件/etc/shadowsocks.json
{
  "server": "0.0.0.0",
  "server_port": 8388,
  "password": "uzon57jd0v869t7w",
  "method": "aes-256-cfb"
}
# 配置自启动
# 新建启动脚本文件/etc/systemd/system/shadowsocks.service，内容如下：
[Unit]
Description=Shadowsocks

[Service]
TimeoutStartSec=0
ExecStart=/usr/bin/ssserver -c /etc/shadowsocks.json

[Install]
WantedBy=multi-user.target
# 启动
systemctl enable shadowsocks
systemctl start shadowsocks
# 检查shadowsocks服务
systemctl status shadowsocks -l
# vultr关闭防火墙
systemctl stop firewalld.service
