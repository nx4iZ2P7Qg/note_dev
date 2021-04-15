# 自建流服务器

# 参考:https://medium.com/@yenthanh/setup-a-rtmp-livestream-server-in-15-minutes-with-srs-1b0046c77267

# 启动流服务
# 项目
#    https://github.com/ossrs/srs
# 运行
docker run -p 1935:1935 -p 1985:1985 -p 8080:8080 ossrs/srs:3

# 将本地数据推向服务器
# obs设置流
# server:         rtmp://svrx.asuscomm.com/live
# stream key:     secret
# start streaming
# 可以在服务器上检查到上下行网络流量

# 接收视频
# 使用VLC，media -> network address，输入
#     rtmp://svrx.asuscomm.com/live/secret
#     http://svrx.asuscomm.com:8080/live/secret.flv
# 就可以看到流
