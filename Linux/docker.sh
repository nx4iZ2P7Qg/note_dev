# 安装docker centos7
----------------------------------------------------------------------------------------------
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce
systemctl start docker
systemctl enable docker
docker --version

# 安装docker centos8
----------------------------------------------------------------------------------------------
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y docker-ce --nobest
systemctl start docker
systemctl enable docker
docker --version

# 安装docker-compose
----------------------------------------------------------------------------------------------
# 看一下版本 https://github.com/docker/compose/releases
curl -L "https://github.com/docker/compose/releases/download/1.27.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version

# /etc/docker/daemon.json
----------------------------------------------------------------------------------------------
# 修改 docker 默认数据位置，包含镜像，容器，网络
# docker 默认位置是 /var/lib/docker
{
  "data-root": "/root/data/docker"
}
# 镜像源
{
  "registry-mirrors": ["http://hub-mirror.c.163.com"]
}
# 跳过自签证书
{
  "insecure-registries": ["192.168.10.203"]
}

#!/usr/bin/env bash

sudo usermod -aG docker <username>

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

# 批量删除容器
docker rm -f $(docker ps -a | grep "Exited" | awk '{print $1}')

# image
----------------------------------------------------------------------------------------------
# 列出本地主机上镜像
docker image ls

# 镜像、容器、数据卷所占用的空间
docker system df

# 删除本地镜像
docker image rm

#批量删除image
docker rmi $(docker images | grep "none" | awk '{print $3}')
docker rmi $(docker images | awk '{print $3}')

# volume
----------------------------------------------------------------------------------------------
# 批量删除volume
docker volume ls | awk '{print $2}' | while read i
do
    docker volume rm "${i}"
done

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


############################ mariadb ############################
docker run -d \
--name wordpress_db \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=<root_pwd> \
-e MYSQL_DATABASE=<schema> \
mariadb
############################ mariadb ############################


############################ wordpress ############################
docker run -d \
--name wordpress \
-p 980:80 \
-p 303:443 \
--volume /home/dexter/docker/wordpress:/home/wordpress/ \
--volume /home/dexter/docker/cert/:/home/cert/ \
wordpress

# 启用apache2 ssl支持， 进入容器
a2enmod ssl
# 创建default-ssl.conf的链接， 进入容器
ln -s ../sites-available/default-ssl.conf default-ssl.conf

# 修改default-ssl.conf ssl配置
ServerName = xxx
SSLEngine = on
SSLCertificateFile      /home/ca.crt
SSLCertificateKeyFile   /home/ca.key

# 将配置导入容器
docker cp default-ssl.conf wordpress:/etc/apache2/sites-available

# 重启容器
docker restart wordpress

# wordpress管理页
# 安装Really Simple SSL
# 修改settings -> general -> WordPress Address (URL)
# 修改settings -> general -> Site Address (URL)
# 为新的https地址 

# 访问 http://<ip>:<port>
# 安装向导页 http://<ip>:<port>/wp-admin/install.php
# 管理页 http://<ip>:<port>/wp-admin
############################ wordpress ############################


############################ jellyfin ############################
docker run -d \
--name jellyfin \
--volume /home/dexter/docker/jellyfin/config:/config \
--volume /home/dexter/docker/jellyfin/cache:/cache \
--volume /mnt/sdd1:/media/video \
--volume /mnt/sde1/audio:/media/audio \
--volume /mnt/sdf1:/media/video_ht \
--net=host \
jellyfin/jellyfin

# http://<yourmachine>:8096
############################ jellyfin ############################
