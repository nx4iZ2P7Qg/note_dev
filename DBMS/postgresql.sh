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
    create user foo with password 'secret';
    # 退出数据库
    \q
    # 配置远程连接
    # 修改/var/lib/pgsql/data/postgresql.conf中
    listen_address = '*'
    # 修改/var/lib/pgsql/data/pg_hba.conf，添加一行
    host all all 0.0.0.0/0 md5