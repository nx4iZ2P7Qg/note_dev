
# 链表关系
# PREROUTING  raw mangle  nat
# INPUT           mangle  nat filter
# FORWARD         mangle      filter
# OUTPUT      raw mangle  nat filter
# POSTROUTING     mangle  nat


# 查看 filter 表
iptables -t filter -nvL

# 查看 filter 表，INPUT 链
iptables -t filter -nvL INPUT

# 查看规则行号
iptables -t filter --line-number -nvL INPUT

# 添加规则
iptables -t filter -I INPUT 2 -s 192.168.0.7 -j ACCEPT

# 删除规则
iptables -t filter -D INPUT 2

# 清空规则
iptalbes -t filter -F INPUT

# 修改默认策略
iptables -t filter -P FORWARD DROP

# -d    目标地址
# -p    协议
# -i    本机多个网卡时，匹配报文是通过哪块网卡流入本机，不能匹配流出网卡，只能用于 PREROUTING、INPUT、FORWARD
# -o    匹配报文将由哪块网卡流出，作用于 FORWARD、OUTPUT、POSTROUTING
# -m tcp --sport
# -m tcp --dport
# -m multiport --sport 22,80
# -m iprange --src-range 192.168.0.100-192.168.0.199
# -m string --algo bm --string "ABC"    -m 模块 --algo 匹配算法
# -m time --timestart 09:00:00 --timestop 10:00:00
# -m time --weekdays 6,7
# -m connlimit --connlimit-above 2  限制单IP并发连接限制
# -m limt --limit 10/minute     限制包速率
# -m tcp --tcp-flags SYN,ACK,FIN,RST,URG,PSH SYH,ACK
# -m udp --sport
# -m udp --dport
# -m state --state RELATED,ESTABLISHED

# 自定义链的存在，只是为了方便管理
# 创建链
iptables -t filter -N IN_WEB
# 删除链
iptables -t filter -X IN_WEB
# 修改链名
iptables -E IN_WEB WEB
# 由 INPUT 来引用新链
iptables -t filter -I INPUT -p tcp --dport 80 -j IN_WEB

# 输出日志
# -j LOG
# --log-level
# --log-prefix
# vim /etc/rsyslog.conf
# kern.warning /var/log/iptables.log
# service rsyslog restart

# -j SNAT
# -j DNAT
# -j MASQUERADE
# -j REDIRECT
