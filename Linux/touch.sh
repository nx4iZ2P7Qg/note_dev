# 修改某文件mtime
touch -t '12310101' abc

# 修改某文件mtime，使与某文件一致
touch -r origin target