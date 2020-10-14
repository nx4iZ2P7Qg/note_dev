#!/bin/bash

# 接受两个参数，用来判断两个参数字符串是否相等

# 如果第一个参数没输入
if [ -z "$1" ]; then
  echo "please input first parameter"
  exit
fi

# 如果第二个参数没输入
if [ -z "$2" ]; then
  echo "please input second parameter"
  exit
fi

# 如果输入了第三个参数，直接返回
if [ -n "$3" ]; then
  echo "only two parameters accepted"
  exit
fi

# 转换成小写
first=$(echo $1 | tr '[A-Z]' '[a-z]')
second=$(echo $2 | tr '[A-Z]' '[a-z]')

# 输出结果
if [ "$first" = "$second" ]; then
  echo "equal"
else
  echo "not equal"
fi