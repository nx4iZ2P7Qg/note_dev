# 查看可以安装的group包
yum grouplist
# 安装gnome环境，使用-y可以跳过确认
yum install "GNOME Desktop"
# 运行gnome
startx

# 挂载点
cd /run/media/dexter/
# 安装VBoxAddition
./VBoxLinuxAddition.sh
# 缺少gcc
yum install gcc

# 安装python3与yum
http://blog.csdn.net/miaoqiucheng/article/details/73322937

# 重启gnome
alt + F2, r