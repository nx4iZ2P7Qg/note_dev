freenas 协议   CIFS，AFP，NFS，iSCSI，SSH，rsync，WebDAV，以及 FTP/TFTP
  CouchPotato 电影自动下载
  HTPC-Manager 图形化HTPC管理器
查看ip命令
  ip addr show
  hostname -I
安装NFS
  yum install nfs-utils
创建NFS共享文件夹
  mkdir /var/nfsshare
修改共享文件夹权限
  chmod -R 755 /var/nfsshare
  chown nfsnobody:nfsnobody /var/nfsshare
  如果要共享/home，不能修改权限人
启用NFS相关服务
  systemctl enable rpcbind
  systemctl enable nfs-server
  systemctl enable nfs-lock
  systemctl enable nfs-idmap
  systemctl start rpcbind
  systemctl start nfs-server
  systemctl start nfs-lock
  systemctl start nfs-idmap
修改/etc/exports
  /home/dexter/abcd    10.0.0.131(rw,sync,no_root_squash,no_all_squash)
重启nfs(exportfs -a)
  systemctl restart nfs-server
防火墙
  firewall-cmd --permanent --zone=public --add-service=nfs
  firewall-cmd --permanent --zone=public --add-service=mountd
  firewall-cmd --permanent --zone=public --add-service=rpc-bind
  firewall-cmd --reload
删除防火墙规则
  firewall-cmd --permanent --zone=public --remove-service=nfs
win10端挂载
  mount \\10.0.0.70\home\dexter\abcd z:
安装netstat ifconfig
  yum install net-tools
查看CPU温度
  yum install lm_sensors
  sensors

安装samba服务
  yum install samba samba-client samba-common
防火墙
  firewall-cmd --permanent --zone=public --add-service=samba
  firewall-cmd --reload
查看共享的windows属于哪个工作组
  win + r -> net config workstation
启动服务
  systemctl enable smb.service
  systemctl enable nmb.service
  systemctl start smb.service
  systemctl start nmb.service
设置samba用户密码
  smbpasswd -a tecmint
设置seLinux
  chcon -t samba_share_t /srv/samba/secure
# 如果是在tstab中挂载的目录，不能手动设定seLinux，要在fstab中指定context
/dev/sdj1  /mnt/FLASHKingstonCenton  ntfs context=system_u:object_r:samba_share_t:s0 0 2
配置/etc/samba/smb.conf
  [Secure]
  comment = Secure File Server Share
  path =  /srv/samba/secure
  valid users = @smbgrp
  guest ok = no
  writable = yes
  browsable = yes
查看成功登录的记录
  last
查看登录失败的记录
  lastb
查看登录日志
  vi /var/log/secure


修改sshd的默认端口
    修改/etc/ssh/sshd_config
    Port=22
    Port=30000
    安装selinux管理工具
    yum provides semanage
    yum install policycoreutils-python
    添加selinux规则
    semanage port -a -t ssh_port_t -p tcp 30000
    查看添加的规则
    semanage port -l | grep ssh
    配置防火墙，默认的ssh service不能使用，要
    firewall-cmd --permanent --zone=public --add-port=30000/tcp
    firewall-cmd --reload
    重启sshd
    systemctl restart sshd.service
    最后删除端口22的相关规则
