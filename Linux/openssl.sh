# Generating SSL/TLS Certificate and Private Key 生成SSL/TLS证书及私钥
mkdir /etc/ssl/private
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem
#    解释
#        req - X.509证书签名请求管理的命令
#        x509 - X.509证书数据管理
#        days - 证书有效期
#        newkey - 指定证书key处理器
#        rsa:2048 - RSA key处理器
#        keyout - key文件
#        out - 证书文件，注意证书与key在同一个文件中

# 生成私钥及证书
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout privateKey.key -out certificate.crt

# 使用私钥及证书生成pkcs #12
openssl pkcs12 -export -out certificate.pfx -inkey privateKey.key -in certificate.crt