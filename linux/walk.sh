function check() {
    local path=$1
    # 输出完整时间
    ls -l --time-style=full $path
    ls $path | while read i
    do
        # 文件不处理
        if [ -f $path/$i ]; then
            :
        fi
        # 目录递归
        if [ -d $path/$i ]; then
            check $path/$i
        fi
    done
}

check $1