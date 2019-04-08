#!/usr/bin/env bash

docker run ubuntu:15.10 /bin/echo "Hello world"

docker run -i -t ubuntu:15.10 /bin/bash

# 查看运行的容器，-l查看最后一次创建的容器
docker ps

# 查看容器内标准输出，-f持续输出
docker logs 7b7b24d85fce

# 查看指定docker命令
docker ps --help

# 获取镜像
docker pull training/webapp

# 查看容器内进程
docker top 1f5bb2af8b0d

docker port 1f5bb2af8b0d
docker port 1f5bb2af8b0d 5000

# 查看docker底层信息
docker inspect 1f5bb2af8b0d

# 列出本地主机上镜像
docker images
docker image ls

# 镜像、容器、数据卷所占用的空间
docker system df

# 删除本地镜像
docker image rm

# 查看容器存储层的变动
docker diff <c-id>

# 将容器的存储层保存为镜像
docker commit

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

# 导出当前运行的容器
docker export -o certusvmanagerdriver.tar e07593dc83d5

# 登录，才能往docker上推自己的镜像
docker login


############################ svn ############################
# Dockerfile
FROM alpine:3.8

CMD [ "/usr/bin/svnserve", "--daemon", "--foreground", "--root", "/var/opt/svn" ]
EXPOSE 3690
VOLUME [ "/var/opt/svn" ]
WORKDIR /var/opt/svn

RUN apk add --no-cache subversion==1.10.4-r0

# 参考 https://hub.docker.com/r/garethflowers/svn-server

# 启动容器
docker run \
    --name svn-server \
    --detach \
    --volume /home/svn:/var/opt/svn \
    --publish 3690:3690 \
    qt72k1wy/svn

# 进入容器
docker exec -it svn-server /bin/sh

# 创建仓库
svnadmin create --fs-type fsfs s-repo

# 配置认证
# /var/opt/svn/s-repo/conf目录中
# svnserve.conf 中反注释 password-db = passwd
# passwd 中添加 sophia = a17
############################ svn ############################
