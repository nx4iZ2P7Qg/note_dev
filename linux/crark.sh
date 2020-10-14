#!/usr/bin/env bash

# 密码长度4-20位
# -c disable GPU support (use CPU only)
# -p set the name of password definition file ("PASSWORD.DEF" by default).
nohup ./crark -c -l4 -g20 -pcrackme.def ../test.rar > log &