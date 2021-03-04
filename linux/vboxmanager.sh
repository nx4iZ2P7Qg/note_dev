vboxmanage extpack install Oracle_VM_VirtualBox_Extension_Pack-6.0.0.vbox-extpack

vboxmanage createvm --name "win" --ostype Windows7_64 --register
# nat网络
vboxmanage modifyvm "win" --memory 2048 --acpi on --boot1 dvd --nic1 nat 
# 桥接网络，enp2s0是物理网络接口，使用firewall-cmd --list-all查看
vboxmanage modifyvm "win" --nic1 bridged --nictype1 82545EM --bridgeadapter1 enp2s0
vboxmanage createhd --filename "win.vdi" --size 20480
vboxmanage storagectl "win" --name "IDE Controller" --add ide --controller PIIX4
vboxmanage storageattach "win" --storagectl "IDE Controller" --port 0 --device 0 --type hdd --medium "win.vdi"
vboxmanage storageattach "win" --storagectl "IDE Controller" --port 0 --device 1 --type dvddrive --medium /mnt/sdb1/net_disk/reinstall/cn_windows_7_ultimate_with_sp1_x64_dvd_u_677408.iso
vboxmanage modifyvm "win" --vrde on
vboxmanage modifyvm "win" --cpus 4
vboxheadless --startvm "win"

# 开机
VBoxManage startvm "win" --type headless

# 关机
VBoxManage controlvm "win" poweroff soft

# 删除
vboxmanage unregistervm "win" --delete

# 查看支持系统
vboxmanage list ostypes

# 查看存在的虚机
vboxmanage list vms

# 接入 VBoxGuestAdditions
vboxmanage storageattach "win" --storagectl "IDE Controller" --port 0 --device 1 --type dvddrive --medium /usr/share/virtualbox/VBoxGuestAdditions.iso

# ftp
# http://download.virtualbox.org/virtualbox/6.0.0/
# guest addition
# http://download.virtualbox.org/virtualbox/6.0.0/VBoxGuestAdditions_6.0.0.iso

# 调整硬盘大小
VBoxManage modifyhd "/home/dexter/virtualbox/win.vdi" --resize 40960

# 调整拖放
vboxmanage modifyvm "win" --draganddrop bidirectional

# 调整剪贴板
vboxmanage modifyvm "win" --clipboard bidirectional
