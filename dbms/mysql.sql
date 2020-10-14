-- 清除日志
    -- 查看日志
    show BINARY LOGS ;
    -- 删除000247之前的日志
    purge BINARY LOGS to 'mysql-bin.000247';
    -- /etc/my.cnf中添加，只保留7天的日志
    expire_logs_day = 7