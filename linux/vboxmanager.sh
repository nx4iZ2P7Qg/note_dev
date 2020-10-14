vboxmanage extpack install Oracle_VM_VirtualBox_Extension_Pack-6.0.0.vbox-extpack

vboxmanage createvm --name "win7" --ostype Windows7_64 --register
# nat网络
vboxmanage modifyvm "win7" --memory 2048 --acpi on --boot1 dvd --nic1 nat 
# 桥接网络，enp2s0是物理网络接口，使用firewall-cmd --list-all查看
vboxmanage modifyvm "win7" --nic1 bridged --nictype1 82545EM --bridgeadapter1 enp2s0
vboxmanage createhd --filename "win7.vdi" --size 20480
vboxmanage storagectl "win7" --name "IDE Controller" --add ide --controller PIIX4
vboxmanage storageattach "win7" --storagectl "IDE Controller" --port 0 --device 0 --type hdd --medium "win7.vdi"
vboxmanage storageattach "win7" --storagectl "IDE Controller" --port 0 --device 1 --type dvddrive --medium /mnt/sdb1/net_disk/reinstall/cn_windows_7_ultimate_with_sp1_x64_dvd_u_677408.iso
vboxmanage modifyvm "win7" --vrde on
vboxmanage modifyvm "win7" --cpus 4
vboxheadless --startvm "win7"

# 开机
VBoxManage startvm "win7" --type headless

# 关机
VBoxManage controlvm "win7" poweroff soft

# 删除
vboxmanage unregistervm "win7" --delete

# 查看支持系统
vboxmanage list ostypes

# 查看存在的虚机
vboxmanage list vms

# ftp
# http://download.virtualbox.org/virtualbox/6.0.0/
# guest addition
# http://download.virtualbox.org/virtualbox/6.0.0/VBoxGuestAdditions_6.0.0.iso

# 调整硬盘大小
VBoxManage modifyhd "/home/dexter/virtualbox/win7.vdi" --resize 40960

# 调整拖放
vboxmanage modifyvm "win7" --draganddrop bidirectional

# 调整剪贴板
vboxmanage modifyvm "win7" --clipboard bidirectional
