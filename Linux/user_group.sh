# 将用户dexter添加到vboxsf组中，注销后生效
usermod -G vboxsf -a dexter

# 查看用户abc属于哪些组
groups abc

# 新建用户
adduser testuser
# 设置密码
passwd testuser
# 添加用户组
groupadd testgroup

# 关闭用户账号
passwd testuser -l
# 重新释放
passwd testuser -u

# 删除用户账号
userdel testuser
# 删除组
groupdel testgroup

# 显示用户信息
id user
cat /etc/passwd

# 查看某一用户
w user
# 查看登录用户
who