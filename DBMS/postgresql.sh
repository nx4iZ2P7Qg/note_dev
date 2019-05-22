#!/usr/bin/env bash

# 在CentOS7上的安装
    yum install postgresql-server
    # 数据库初始化
    postgresql-setup initdb
    # 修改认证方式
    # 修改/var/lib/pgsql/data/pg_hba.conf，将host对应的行ident的方式改为md5
    # 启动服务
    systemctl start postgresql
    systemctl enable postgresql
    # 切换用户
    sudo -i -u postgres
    # 连接到数据库
    psql
    # 添加新用户
    create user dexter with password 'secret';
    # 添加权限到默认数据库
    grant all privileges on database postgres to dexter;
    # 退出数据库
    \q
    # 配置远程连接
    # 修改/var/lib/pgsql/data/postgresql.conf中
    listen_address = '*'
    # 修改/var/lib/pgsql/data/pg_hba.conf，添加一行
    host all all 0.0.0.0/0 md5
# 防火墙
    firewall-cmd --permanent --zone=public --add-service=postgresql
    firewall-cmd --reload
# 数据备份
    # 改变命令执行路径
    cd /mnt/sdb1/net_disk/
    # 创建文件
    touch /mnt/sdb1/net_disk/pg_dump.sql
    # 修改权限
    chown postgres:postgres /mnt/sdb1/net_disk/pg_dump.sql
    # dump
    sudo -u postgres pg_dump -c -C -f /mnt/sdb1/net_disk/pg_dump.sql --column-inserts df
# 运行sql
    psql -h localhost -d df -U dexter -c "insert into t_menstrul_cycle values(41, '2019-04-14', 0)"