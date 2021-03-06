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
    # 修改权限
    chown postgres:postgres /mnt/sde1/backup/server/psql/pg_dump.sql
    # dump
    pg_dump -U postgres -c -C -f /mnt/sde1/backup/server/psql/pg_dump.sql --column-inserts df
# 运行sql
    psql -h localhost -d df -U dexter -c "select * from t_menstrul_cycle"
    psql -h localhost -d df -U dexter -c "insert into t_menstrul_cycle values(41, '2019-04-14', 0)"

# docker 查询
    docker exec -it postgres psql -h localhost -d df -U postgres -c "select * from pg_tables where schemaname = 'public'"
# docker 备份
    docker exec -it postgres /bin/bash
    pg_dump -U postgres -c -C -f pg_dump.sql --column-inserts df
    docker cp postgres:/pg_dump.sql /mnt/d3/backup/server/psql/pg_dump_2021-04-11.sql

# docker 还原
    docker cp /mnt/d3/backup/server/psql/pg_dump_2021-05-07.sql postgres:/pg_dump.sql
    docker exec -it postgres psql -U postgres -f pg_dump.sql
