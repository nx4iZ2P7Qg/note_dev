# 测试局域网速，服务端
iperf -s -u -i 1
# 客户端
iperf -c 10.0.0.131 -u -b 1000m -t 60
