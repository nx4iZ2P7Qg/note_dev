# 挂载点
cd /media/cdrom
# 安装VBoxLinuxAddition.sh
./VBoxLinuxAddition.sh
# 缺少的文件
apt-get install build-essential linux-headers-$(uname -r)

# 解决用户不在sudoer用户组的问题
# 修改/etc/sudoers，在workzmp ALL=(ALL:ALL) ALL后面添加一行，内容即yourusername ALL=(ALL:ALL)