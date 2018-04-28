# Generating SSL/TLS Certificate and Private Key 生成SSL/TLS证书及私钥
mkdir /etc/ssl/private
openssl req -x509 -nodes -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem -days 365 -newkey rsa:2048
#    解释
#        req - X.509证书签名请求管理的命令
#        x509 - X.509证书数据管理
#        days - 证书有效期
#        newkey - 指定证书key处理器
#        rsa:2048 - RSA key处理器
#        keyout - key文件
#        out - 证书文件，注意证书与key在同一个文件中