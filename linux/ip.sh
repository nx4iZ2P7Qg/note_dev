# 显示网络接口
ip link show

# 显示指定网络接口，-s 是统计数据，多个 -s 会给更多信息
ip -s link show caliec61fbe4039

# 开启网卡
ip link set eth0 down

# 关闭网卡
ip link set eth0 up

# 开启混合模式
ip link set eth0 promisc on

# 关闭混合模式
ip link set eth0 promisc off



# 显示网卡 ip 信息
ip addr show

# 显示指定网卡 ip 信息
ip addr show caliec61fbe4039

# 设置 ip 地址
ip addr add 192.168.0.193/24 dev wlan0

# 删除 ip 地址
ip addr del 192.168.0.1/24 dev eth0



# 显示系统路由
ip route show

