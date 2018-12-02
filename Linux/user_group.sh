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







1、与用户（user）和用户组（group）相关的配置文件；

1）与用户（user）相关的配置文件；


　　/etc/passwd 注：用户（user）的配置文件；
　　/etc/shadow 注：用户（user）影子口令文件；

2）与用户组（group）相关的配置文件；

　　/etc/group 注：用户组（group）配置文件；
　　/etc/gshadow 注：用户组（group）的影子文件；

2、管理用户（user）和用户组（group）的相关工具或命令；

1）管理用户（user）的工具或命令；

复制代码
代码如下:

useradd 注：添加用户
adduser 注：添加用户
passwd 注：为用户设置密码
usermod 注：修改用户命令，可以通过usermod 来修改登录名、用户的家目录等等；
pwcov 注：同步用户从/etc/passwd 到/etc/shadow
pwck 注：pwck是校验用户配置文件/etc/passwd 和/etc/shadow 文件内容是否合法或完整；
pwunconv 注：是pwcov 的立逆向操作，是从/etc/shadow和 /etc/passwd 创建/etc/passwd ，然后会删除 /etc/shadow 文件；
finger 注：查看用户信息工具
id 注：查看用户的UID、GID及所归属的用户组
chfn 注：更改用户信息工具
su 注：用户切换工具
sudo 注：sudo 是通过另一个用户来执行命令（execute a command as another user），su 是用来切换用户，然后通过切换到的用户来完成相应的任务，但sudo 能后面直接执行命令，比如sudo 不需要root 密码就可以执行root 赋与的执行只有root才能执行相应的命令；但得通过visudo 来编辑/etc/sudoers来实现；
visudo 注：visodo 是编辑 /etc/sudoers 的命令；也可以不用这个命令，直接用vi 来编辑 /etc/sudoers 的效果是一样的；
sudoedit 注：和sudo 功能差不多；



2）管理用户组（group）的工具或命令；

复制代码
代码如下:

groupadd 注：添加用户组；
groupdel 注：删除用户组；
groupmod 注：修改用户组信息
groups 注：显示用户所属的用户组
grpck
grpconv 注：通过/etc/group和/etc/gshadow 的文件内容来同步或创建/etc/gshadow ，如果/etc/gshadow 不存在则创建；
grpunconv 注：通过/etc/group 和/etc/gshadow 文件内容来同步或创建/etc/group ，然后删除gshadow文件；



3、/etc/skel 目录；
　　/etc/skel目录一般是存放用户启动文件的目录，这个目录是由root权限控制，当我们添加用户时，这个目录下的文件自动复制到新添加的用户的家目录下；/etc/skel 目录下的文件都是隐藏文件，也就是类似.file格式的；我们可通过修改、添加、删除/etc/skel目录下的文件，来为用户提供一个统一、标准的、默认的用户环境；

复制代码
代码如下:

[root@localhost beinan]# ls -la /etc/skel/
总用量 92
drwxr-xr-x 3 root root 4096 8月 11 23:32 .
drwxr-xr-x 115 root root 12288 10月 14 13:44 ..
-rw-r--r-- 1 root root 24 5月 11 00:15 .bash_logout
-rw-r--r-- 1 root root 191 5月 11 00:15 .bash_profile
-rw-r--r-- 1 root root 124 5月 11 00:15 .bashrc
-rw-r--r-- 1 root root 5619 2005-03-08 .canna
-rw-r--r-- 1 root root 438 5月 18 15:23 .emacs
-rw-r--r-- 1 root root 120 5月 23 05:18 .gtkrc
drwxr-xr-x 3 root root 4096 8月 11 23:16 .kde
-rw-r--r-- 1 root root 658 2005-01-17 .zshrc

　　/etc/skel 目录下的文件，一般是我们用useradd 和adduser 命令添加用户（user）时，系统自动复制到新添加用户（user）的家目录下；如果我们通过修改 /etc/passwd 来添加用户时，我们可以自己创建用户的家目录，然后把/etc/skel 下的文件复制到用户的家目录下，然后要用chown 来改变新用户家目录的属主；

4、/etc/login.defs 配置文件；
　　/etc/login.defs 文件是当创建用户时的一些规划，比如创建用户时，是否需要家目录，UID和GID的范围；用户的期限等等，这个文件是可以通过root来定义的；

比如Fedora 的 /etc/logins.defs 文件内容；

复制代码
代码如下:

# *REQUIRED*
# Directory where mailboxes reside, _or_ name of file, relative to the
# home directory. If you _do_ define both, MAIL_DIR takes precedence.
# QMAIL_DIR is for Qmail
#
#QMAIL_DIR Maildir
MAIL_DIR /var/spool/mail 注：创建用户时，要在目录/var/spool/mail中创建一个用户mail文件；
#MAIL_FILE .mail
# Password aging controls:
#
# PASS_MAX_DAYS Maximum number of days a password may be used.
# PASS_MIN_DAYS Minimum number of days allowed between password changes.
# PASS_MIN_LEN Minimum acceptable password length.
# PASS_WARN_AGE Number of days warning given before a password expires.
#
PASS_MAX_DAYS 99999 注：用户的密码不过期最多的天数；
PASS_MIN_DAYS 0 注：密码修改之间最小的天数；
PASS_MIN_LEN 5 注：密码最小长度；
PASS_WARN_AGE 7 注：
#
# Min/max values for automatic uid selection in useradd
#
UID_MIN 500 注：最小UID为500 ，也就是说添加用户时，UID 是从500开始的；
UID_MAX 60000 注：最大UID为60000；
#
# Min/max values for automatic gid selection in groupadd
#
GID_MIN 500 注：GID 是从500开始；
GID_MAX 60000
#
# If defined, this command is run when removing a user.
# It should remove any at/cron/print jobs etc. owned by
# the user to be removed (passed as the first argument).
#
#USERDEL_CMD /usr/sbin/userdel_local
#
# If useradd should create home directories for users by default
# On RH systems, we do. This option is ORed with the -m flag on
# useradd command line.
#
CREATE_HOME yes 注：是否创用户家目录，要求创建；

5、/etc/default/useradd 文件；

　　通过useradd 添加用户时的规则文件；


复制代码
代码如下:

# useradd defaults file
GROUP=100
HOME=/home 注：把用户的家目录建在/home中；
INACTIVE=-1 注：是否启用帐号过期停权，-1表示不启用；
EXPIRE= 注：帐号终止日期，不设置表示不启用；
SHELL=/bin/bash 注：所用SHELL的类型；
SKEL=/etc/skel 注： 默认添加用户的目录默认文件存放位置；也就是说，当我们用adduser添加用户时，用户家目录下的文件，都是从这个目录中复制过去的； 
