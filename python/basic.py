编码
    # -*- coding: utf-8 -*-

数字
    + - * / ()
    /   返回float
    //  floor division
    %   余数
    **  乘方
    在交互模式下
    最后一个输出的表达式被赋值给_，这样可以便于使用，此内置变量只读，但你可以定义这个变量来覆盖，然后赋值
    python支持Decimal, Fraction, complex numbers(复数), 比如3 + 5j

字符串
    ''或者""都可以，\转义
    交互模式中的字符串输出会用引号及转义，使得输入输出看起来不太一样，建议使用print()输出，可读性更好
    如果不希望转义，可以使用raw string比如，print(r"c:\some\name")
    有些字符串包含多行，可以使用"""或者'''引用，其中可以使用\转义
    +   拼接
    *   重复，比如3 * "a"
    []  取字符，使用正数或负数，负数从-1开始
    [:] 取子串，缺省时，前面为0，后面为字符串长度
    []过长的下标会出错，[:]过长的下标会模处理后正常使用
    字符串为不可变量，给字符或子字符串赋值会出错，例word[0] = 'a'; word[2:] = 'ab';
    len()返回长度

list
    可以引用不同的类型，但通常是一致的
    squares = [1, 4, 9, 16, 25]
    像string和其他所有sequence type一样，支持indexed和sliced操作
    squares[:]返回相同的数组
    支持拼接，比如squares + [36, 49, 64, 81, 100]
    append()在尾部添加新元素
    支持slice赋值，如squares[1:3] = [1, 2], squares[1:3] = [];
    len()返回长度
    可嵌套

实际coding
    Fibonacci数列问题
    a, b = 0, 1
    while b < 10:
        print(b)
        a, b = b, a + b
    python和c一样，非0整数为true，0为false，也可以为字符串或数组，长度非0为true，长度0为false
    print(b, end=',')可以将结果输出在一行

if
    x = int(input('Please enter an integer'))
    if x < 0:
        x = 0
        print('Negative changed to zero')
    elif x == 0:
        print('Zero')
    elif x == 1:
        print('Single')
    else:
        print('More')

for
    对于list的迭代，如果要修改list的内容，建议先复制，[:]符号在此特别方便
    for w in words[:]:
        if len(w) > 6:
            words.insert(0, w)
    如果没有片操作，代码生成无限list

range
    python中for循环不迭代数字，如果要，使用range
    for i in range(5):
        print(i)
    range(5, 10)
        5, 6, 7, 8, 9
    range(0, 10, 3)
        0, 3, 6, 9
    range(-10, -100, -30)
        -10, -40, -70
    如果要迭代数组下标，可以使用for与range
    a = ['Mary', 'had', 'a', 'little', 'lamb']
    for i in range(len(a)):
        print(i, a[i])
    这些情况用enumerate() 最方便
    print(range(10))不返回数组，而是对象，只在迭代时生成各item，并不生成list，这种对象被称为iterable
    for循环可以接收iterable，list()也可以

break
    跳出最近的for和while

loop中的else
    只在for迭代完成或while条件不成立时执行，break不执行
    for n in range(2, 10):
        for x in range(2, n):
            if n % x == 0:
                print(n, 'equals', x, '*', n//x)
                break
        else:
            print(n, 'is a prime number')

pass
    空命令，语法需要但不用做任何事时使用，coding时可以先写上，之后再实现相应功能

定义函数
    def fib(n):
        """Print a Fibonacci series up to n."""
        a, b = 0, 1
        while a < n:
            print(a, end=' ')
            a, b = b, a+b
        print()
    def指函数定义，函数体在下行开始，必须缩进
    函数体首行可以是字符串常量，作为函数文档
    全局变量不能在函数中赋值，除非使用global
    定义的函数名可以赋值给新变量
    f = fib
    没有返回值的函数会返回内建的值，None
    if ok in ('y', 'ye', 'yes'):   in的一种判断用法
    可定义参数默认值，默认值可用变量
    默认参数只处理一次
    def f(a, L=[]):
        L.append(a)
        return L
    print(f(1))
    print(f(2))
    print(f(3))
    返回
    [1]
    [1, 2]
    [1, 2, 3]
    如果不想在调用间共享，可如下定义
    def f(a, L=None):
        if L is None:
            L = []
        L.append(a)
        return L
    调用时，可以指定参数名并传值
    **name形式的参数可以接受一个dictionary
    *name可变参数，接受tuple，在range()中也可以使用range(*args)

文档描述
    首先必须是精简的描述，以动词开关，.结尾
    如果有多行，第二行必须是空行
    对齐问题参考https://docs.python.org/3/tutorial/controlflow.html#documentation-strings
    print(my_function.__doc__)查看函数文档描述

list操作
    squares = []
    for x in range(10):
        squares.append(x**2)
    生成list后还会有x变量残留
    用squares = list(map(lambda x: x**2, range(10)))
    或squares = [x**2 for x in range(10)]
    可以达到相同效果，且没有x留下
    这种用[]，for，if创建数组的方法叫list comprehension
    zip()，二维list行列转换
    del()用下标删除元素，或片，或删除变量
    tuples和sequences
    list, tuple, range都是sequence类型
    tuple是用,分隔的一些值，t = 12345, 54321, 'hello!'，三个项目被pack到t中作为tuple
    tuple不可变
    x, y, z = t，t被unpack成3个项目
    Note that multiple assignment is really just a combination of tuple packing and sequence unpacking.


