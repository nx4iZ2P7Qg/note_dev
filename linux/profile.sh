# 自定义指令
alias lg='ls -al | grep'



# 配置全局 socks5 代理
# 其中 socks5://192.168.13.48:10808 是 v2rayN 的监听地址，并且需要开启"允许来自局域网的连接"
echo '
PROXY_URL="socks5://192.168.13.48:10808"
export http_proxy="$PROXY_URL"
export https_proxy="$PROXY_URL"
' >> /etc/profile

source /etc/profile
