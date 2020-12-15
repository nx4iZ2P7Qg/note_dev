# 删除第3行到最后一行
sed '3,$d'
# 添加行
sed '3a content'
# 插入行
sed '3i content'
# 替换行
sed '3,4c content'
# 打印
sed -n '1,2p'
# 行内替换
sed 's/aaa/bbb/'

# 直接修改文件
sed -i 's/xxx/yyy/g'
