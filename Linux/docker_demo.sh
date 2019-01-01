#!/usr/bin/env bash

# docker二进制文件
# ubuntu:15.10 镜像名，找不到镜像会自动下载
# /bin/echo "Hello world" 容器内命令
docker run ubuntu:15.10 /bin/echo "Hello world"

# -t 在容器内指定一个伪终端或终端
# -i 与容器内STDIN交互
docker run -i -t ubuntu:15.10 /bin/bash

# -d --detach，后台运行，并输出ID
# 返回串为容器ID
docker run -d ubuntu:15.10 /bin/sh -c "while true; do echo hello world; sleep 1; done"

# -v $PWD/www:/www 将主机当前目录www挂载到容器/www
# -v $PWD/conf/nginx.conf:/etc/nginx/nginx.conf 文件挂载

# -e MYSQL_ROOT_PASSWORD=123456 指定root密码

# 查看运行的容器，-l查看最后一次创建的容器
docker ps

# 查看容器内标准输出，-f持续输出
docker logs 7b7b24d85fce

docker restart 7b7b24d85fce

# 停止容器
docker stop 7b7b24d85fce

# 语法
docker

# 查看指定docker命令
docker ps --help

# 获取镜像
docker pull training/webapp
# 运行一个web
# -P 将容器内部使用的网络端口映射到docker主机上
# -p 指定主机、端口、协议
# --name 指定容器NAMES
docker run -d -P training/webapp python app.py
docker run -d -p 127.0.0.1:5001:5000/udp --name python_flash training/webapp app.py
# 使用默认配置的default machine with IP 192.168.99.100加上port访问
# http://192.168.99.100:5000/

# 端口映射并不是唯一把 docker 连接到另一个容器的方法
# docker 有一个连接系统允许将多个容器连接在一起，共享连接信息
# docker 连接会创建一个父子关系，其中父容器可以看到子容器的信息

# 查看容器内进程
docker top 1f5bb2af8b0d

docker port 1f5bb2af8b0d
docker port 1f5bb2af8b0d 5000

# 查看docker底层信息
docker inspect 1f5bb2af8b0d

docker rm 7b7b24d85fce

# 列出本地主机上镜像
# REPOSITORY 镜像源
# TAG 镜像标签
# IMAGE ID 镜像ID
docker images

# 从https://hub.docker.com/查需要的镜像，也可以使用
docker search httpd

# 如果仓库中的镜像不满足要求，可以通过2种方式对镜像更新
# 1从已经创建的容器中更新，并提交（不推荐的方法）
# 2使用dockerfile指令来创建新镜像
FROM    centos:7.0
MAINTAINER      Fisher "fisher@sudops.com"

RUN     /bin/echo 'root:123456' |chpasswd
RUN     useradd runoob
RUN     /bin/echo 'runoob:123456' |chpasswd
RUN     /bin/echo -e "LANG=\"en_US.UTF-8\"" >/etc/default/local
EXPOSE  22
EXPOSE  80
CMD     /usr/sbin/sshd -D

# -t 指定目标镜像名
# . dockerfile所在目录
docker build -t df/centos:7.0 .

# 为镜像添加标签
docker tag container_id df/centos:newtag
