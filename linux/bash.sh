# 删除游标前
ctrl + u
# 删除游标后
ctrl + k

# 取消变量
unset abc

# 生成一个随机数，0~32767之间
echo ${RANDOM}

# 当前shell的进程号
echo ${$}
# 上条命令的执行结果，正常为0
echo ${?}

# 将自定义变量转换成环境变量
export ABC
# 将环境变量转换成自定义变量
declare ABC=

# 切换到作为参数的目录，并把原目录和当前目录压入到一个虚拟的堆栈中
pushd
# 弹出堆栈中最近的目录
popd
# 列出当前堆栈中保存的目录列表
dirs
