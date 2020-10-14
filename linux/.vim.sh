# centos等dis中有时是最小的vim，没有语法高亮功能
# 安装vim
yum install vim-enhanced
# 在~/.vimrc中定制需要的属性

一般模式
    dw
    de 当前->单词结束
    e 下一个单词尾
    0 行首
    U 整行撤销，可以被u撤销
    ctr+r redo
    dd 会将删除的内容放到vim的一个寄存器中，d命令都会放入寄存器
    cw 删除到词尾，进入编辑模式
    c$
    R 连续替换

    :r 读取文件到当前位置
    :r ls 读取ls命令的结果

    ~ 切换大小写

    1,$!sort 可以把1到最后一行的内容交给sort排序

    4!!awk '{print "text", $0}' 从当前行开始的4行，给awk
    :1,$!awk '{print $1}' | sort | tr [:lower:] [:upper:] 将每行首字母大写
    6,9w >> /tmp/newfile 6~9行添加到newfile尾部

    m [a-z] 保存书签，只能存26个
    ` [a-z] 引用书签
    `` 在最近的两个书签间切换
    M 跳转到屏幕中间行

    ctrl+g 显示文件信息及状态
    ctrl+o 回到
    ctrl+i 前进
    ctrl+w两次 在窗口间跳转

    5>> 本行开始，5行缩进1级

    % 匹配()[]{}
    1,2s/old/new/gc c是表示确认

    :! 输入外部命令

    y yw,yd复制内容

v模式下
    w <filename> 保存相应行的内容到文件
    d 删除选中内容
    y 复制选中的内容

set ic 搜索时忽略大小写，/abc\c 一次忽略大小写
set noic
set hls 高亮匹配项
set nohlsearch
set is 逐字匹配
:set all 显示选项及命令列表


文档
    F1
    :help
    :help vimrc-intro 了解更多vimrc设置

:模式中
    ctrl+d 显示命令列表
    tab 自动补全
    补全对很多命令都有效，对:help非常有用

搜索
    /aaa/;/bbb/ 搜索aaa换行后的bbb
    匹配到目标后，ce/cw消除并修改成要的字符，之后再用.重复

替换
    搜索时用\n代表新行，但替换时要用\r，\n被用来表示null了



vimtutor -> :help user-manual