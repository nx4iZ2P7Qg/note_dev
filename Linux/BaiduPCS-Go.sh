
# 列出目录
./BaiduPCS-Go ll /df

# 后台下载
nohup ./BaiduPCS-Go d file.rar --save --locate --stream -p 1 -l 1 &

# 查看后台下载进度
tail -f nohup.out