# 获取脚本及配置环境
curl  https://get.acme.sh | sh

# 重新登录ssh

# 修改key及secret
vi ~/.acme.sh/dnsapi/dns_gd.sh

# 申请证书
acme.sh --issue --dns dns_gd -d sodex.dev