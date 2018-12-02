# 挂载点
cd /media/cdrom
# 安装VBoxLinuxAddition.sh
./VBoxLinuxAddition.sh
# 缺少的文件
apt-get install build-essential linux-headers-$(uname -r)

# 解决用户不在sudoer用户组的问题
# 修改/etc/sudoers，在workzmp ALL=(ALL:ALL) ALL后面添加一行，内容即yourusername ALL=(ALL:ALL)




# gedit不能正确显示GBK编码文件的处理方式
gsettings set org.gnome.gedit.preferences.encodings auto-detected "['GB18030', 'GB2312', 'GBK', 'UTF-8', 'BIG5', 'CURRENT', 'UTF-16']"
gsettings set org.gnome.gedit.preferences.encodings shown-in-menu "['GB18030', 'GB2312', 'GBK', 'UTF-8', 'BIG5', 'CURRENT', 'UTF-16']"

# 修改默认文件关联
# ape
sed -i 's/\(audio\/x-ape=\).*/\1audacious/' /etc/gnome/defaults.list
# flac
sed -i 's/\(audio\/x-flac=\).*/\1audacious/' /etc/gnome/defaults.list
sed -i 's/\(application\/x-flac=\).*/\1audacious/' /etc/gnome/defaults.list
sed -i 's/\(audio\/flac=\).*/\1audacious/' /etc/gnome/defaults.list
# mp3
sed -i 's/\(audio\/x-mp3=\).*/\1audacious/' /etc/gnome/defaults.list
# fictx输入法
sudo apt-get install fcitx
# fictx下的五笔
sudo apt-get install fcitx-table-wbpy
# 清空DNS缓存
# service nscd restart
