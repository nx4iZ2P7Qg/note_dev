# 参考
# https://zaomianbao.com/blog/2019/07/31/1
# https://zhuanlan.zhihu.com/p/105315199

docker run \
    --name confluence_mysql \
    -p 33060:3306 \
    -v /home/dexter/docker/confluence_mysql/export/config/mysql/mysqld.cnf:/etc/mysql/my.cnf \
    -v /home/dexter/docker/confluence_mysql/export/data/mysql:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=mysql_con \
    -d mysql:5.7


alter user 'root'@'localhost' identified by 'abc@123CBA'


docker run \
    -v /home/dexter/docker/confluence/export/data/confluence/:/var/atlassian/application-data/confluence/ \
    --name="confluence" \
    -d \
    -p 8090:8090 \
    -p 8091:8091 \
    atlassian/confluence-server:7.3.1


mv /opt/atlassian/confluence/confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.4.1.jar /mnt/
mv /opt/atlassian/confluence/confluence/WEB-INF/atlassian-bundled-plugins/atlassian-universal-plugin-manager-plugin-4.0.6.jar /mnt/



docker cp atlassian-extras-decoder-v2-3.2.jar confluence:/opt/atlassian/confluence/confluence/WEB-INF/lib/


create schema confluence charset 'utf8' collate 'utf8_bin';
