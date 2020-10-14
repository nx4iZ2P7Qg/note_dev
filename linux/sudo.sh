# 将固定的用户添加到sudoer中，参考以下链接
# https://www.digitalocean.com/community/tutorials/how-to-edit-the-sudoers-file-on-ubuntu-and-centos
# CentOS7中，执行以下命令
sudo usermod -aG wheel username

# 以特定用户执行命令
sudo -u dexter ./aria_auto.sh
