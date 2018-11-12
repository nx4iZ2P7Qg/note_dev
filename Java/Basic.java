import java.io.Console;
import java.util.Arrays;
import java.util.Scanner;

public class Temp {
    public static strictfp void main(String[] args) {
        // 3.2 注释
        // 多行注释不能嵌套

        // 3.3 数据类型
        // 3.3.1
        // 16进制整数
        int int1 = 0x10;
        // 不建议使用的8进制整数
//    int int2 = 010;
        // 2进制数
        int int3 = 0b10;
        System.out.println("int1 = " + int1); // 16
        System.out.println("int3 = " + int3); // 2
        // java7支持长整数添加下划线方便阅读
        long long1 = 12_3456_7890_0000_0000L;
        System.out.println("long1 = " + long1); // 123456789000000000
        long long2 = 0b111_1111_1000_0000;
        System.out.println("long2 = " + long2); // 32640

        // 3.3.2
        // float 4字节 double 8字节
        // 16进制表示浮点数方法，尾数16进制，指数基数2，指数10进制
        System.out.println("0x1.0p-3 == 0.125结果为" + (0x1.0p-3 == 0.125));
        // Double.POSITIVE_INFINITY
        System.out.println("1.0 / 0 = " + 1.0 / 0);
        // Double.NEGATIVE_INFINITY
        System.out.println("-1.0 / 0 = " + -1.0 / 0);
        // 正负无穷大的判断
        System.out.println("1.0 / 0 == Double.POSITIVE_INFINITY 结果为" + (1.0 / 0 == Double.POSITIVE_INFINITY));
        // 负无穷大类似
        // Double.NaN
        System.out.println(0.0 / 0);
        System.out.println(0 / 0.0);
        // 判断
        System.out.println("非数判断" + Double.isNaN(0.0 / 0));
        // 特别的，异常
        try {
            System.out.println(0 / 0);
        } catch (ArithmeticException e) {
            e.printStackTrace();
        }
        // 浮点数不适用于禁止出现舍入误差的应用场合，尤其是金融
        // 主要原因是浮点数用二进制表示，无法精确表示1/10
        // 就好像整数无法精确表示1/3

        // 3.3.3
        char c1 = 'A';
        // 与A相同的16进制unicode表示方法
        char c2 = '\u0041';
        System.out.println("c2 = " + c2);
        // 16进制unicode表示范围为\u0000 ~ \uffff
        char c3 = '\uffff';
        System.out.println("c3 = " + c3);
        // 特别的
        System.out.println('\u2122'); // ™
        System.out.println('\u03c0'); // π

        // unicode与utf-16的一个例子
        // utf-16中常用字是2Byte16位，最大65536个字符，生僻字用4Byte32位储存
        // 无论哪种，一个Integer可以装下
        // 比如𤭢，在unicode中它的代码点(code point)是U+24B62
        // 转换成UTF-16编码，过程如下
        // 1.减去0x10000，结果为0x14B62，二进制为0001_0100_1011_0110_0010
        // 2.高10位(0001_0100_10，0x052)加上0xD800，结果为0xD852
        // 3.低10位(11_0110_0010，0x362)加上0xDC00，结果为0xDF62
        // 最终是 D852 DF62，过程可逆向转换
        // unicode多语言级别中空闲的2048个字节，人为的分为两段
        // 0xD800，0xDC00是这两段的开始地址，U+D800~U+DBFF，U+DC00~U+DFFF
        // 代码点初始化
        char[] chars1 = Character.toChars(0x24B62);
        System.out.println(chars1); // 𤭢
        // 字符串初始化
        String s1 = "\uD852\uDF62";
        System.out.println(s1); // 𤭢
        // 强烈建议不要在代码中使用char类型

        // 3.4
        // 不推荐，但合法的变量名起始字符
        System.out.println(Character.isJavaIdentifierStart('变'));
        // 不推荐，但合法的变量名非起始字符
        System.out.println(Character.isJavaIdentifierPart('变'));
        // 不要使用$作变量名，javac要使用

        // 3.4.2
        // 用final声明常量，习惯上常量名全大写，字母间加下划线
        final Double pi = 3.1415926535897932384626;
        // const是java未使用的关键字

        // java的可移植性与与浮点数计算精度问题
        // double是64位的，但有些处理器使用80位寄存器，从而中间计算时精度更高，跨平台就无法实现
        // 初始java规定每步都要截断，因为可能会导致溢出，同时降低性能
        // 最终折衷方案，默认情况下，中间步骤允许使用扩展的指数，不允许扩展的尾数
        // 使用strictfp关键字标记的类或方法就截断
        // 实际的方式将取决于处理器，这两种方式的差别在于溢出，对大多数程序员来说不是大问题
        // 本类的main方法就是这种

        // 3.5.3
        // 整形的位运算
        // & | ^ ~
        // >> << >>>，右侧移动位数，要根据被操作数的类型取模，比如int模32，long模64

        // 3.5.4
        // Math类中，为了性能，所有方法都使用计算机浮点单元中的例程
        // 如果得到一个完全可预测的结果更重要时，要使用StrictMath类。
        // 它使用“自由发布的Math库(fdlibm)”，实现算法，确保所有平台得到相同结果

        // 3.5.5
        // int转double没有精度损失，long转double可能有
        // 7个基本类型计算时，优先转成double, float, long, int，再运算

        // 3.5.6
        // 强转，且数值超过类型的范围，数据会乱
        System.out.println((byte) 300); // 44

        // 3.5.8
        // 枚举类，见后面的Size类
        Size s = Size.MEDIUM;
        s = null;

        // 3.6.4
        // +的结果缓存了，substring的结果没有
        String s361 = "ab";
        String s362 = "a" + "b";
        String s363 = "abcdefg".substring(0, 2);
        System.out.println(s361 == s362); // true
        System.out.println(s361 == s363); // false

        // 3.6.6
        String s366 = "\uD852\uDF62\uD852\uDF62"; // "𤭢𤭢"
        System.out.println(s366.length()); // 返回代码单元数量 4
        System.out.println(s366.codePointCount(0, s366.length())); // 实际代码点数量 2
        System.out.println(s366.charAt(0)); // 某处代码单元 ?，无法识别，因为双代码单元
        // 想得到第i处代码点
        int index = s366.offsetByCodePoints(0, 1);
        System.out.println(index); // 2
        System.out.println(s366.codePointAt(2)); // 150370
        // 不要使用char类型，太底层
        // 用codePoint遍历字符串
        int i = 0;
        while (i < s366.length()) {
            int cp = s366.codePointAt(i);
            if (Character.isSupplementaryCodePoint(cp)) {
                i += 2;
            } else {
                i += 1;
            }
            System.out.println("i++, i = " + i + ", cp = " + cp);
        }
        // 以下语句回退遍历
        i = s366.length();
        while (i > 0) {
            i--;
            if (Character.isSurrogate(s366.charAt(i))) {
                i--;
            }
            int cp = s366.codePointAt(i);
            System.out.println("i--, " + cp);
        }

        // 3.7.1
        Scanner sc = new Scanner(System.in);
        String s371 = sc.nextLine();
        sc.nextInt();
        sc.nextDouble();
        // 以下代码在ide中运行会得到空的cons，因为不是在terminal中运行，ide进行了重定向
        // se6加入了console输入密码
//        Console cons = System.console();
//        String s3712 = cons.readLine("Username:");
//        char[] passwd = cons.readPassword("Password:");
        // passwd使用后应立即填充

        // 3.7.2
        double d372 = 10000.0 / 3;
        System.out.printf("%8.2f\n", d372);
        // d x十六进制 o八 f e指数 g通用浮点数 a十六进制浮点数
        // s c b h散列码 tx日期 % n平台相关分隔符
        // 内容表格化，参见原文

        // 3.8.5
        // 最好不要使用switch语句，break容易漏写
        // case值可以是char, byte, short, int及其包装类，枚举，字符串字面量

        // 3.8.5
        // break可以跳出语句块
        label:
        {
            if (true) {
                break label;
            }
        }
        // continue也可以带标签
        // break与continue是可选的，可以完全不用，一样能表达相同的语义

        // 3.10
        // 创建数组时，若为数字类型，所有值为0，boolean则所有元素为false，对象则所有元素为null

        // 3.10.6
        // 二维数据输出用deepToString
        int[][] arr = {
                {1, 2, 3},
                {4, 5, 6},
                {7, 8, 9}
        };
        System.out.println(Arrays.deepToString(arr));

        // 3.10.7
        // 不规则数组
        int[][] odds = new int[3][];
        for (int li = 0; li < 3; li++) {
            odds[li] = new int[li + 1];
        }
        System.out.println(Arrays.deepToString(odds));

        // 4.3.6
        // 类设计中不要返回引用可变对象的访问器方法，比如public String getName()
        // 这样可以通过赋值的方法改变name，破坏了封装
        // 如果一定要返回，最好返回引用的克隆return name.clone()

        // 4.3.9
        // 如果一个类的方法不改变任何成员，就是一个不可变类

        // 4.4.3
        // 静态方法没有this隐藏参数

        // 4.6.1
        // 重载中，方法签名不包含返回类型，不能存在两个签名相同的方法

        // 4.6.6
        // 如果构造器第一行语句形如this(...)，表示调用另外一个构造器

        // 4.6.7
        // 只要构造类的对象，初始化块就会被执行，并且在构造器之前执行
        // 这种机制不常用
        // 如果一定要用，建议将初始化块放在域定义后，防止循环定义
        // 调用构造器的细节
        // 1.所有数据域被初始化为默认值
        // 2.按照在类声明中出现的顺序，依次执行所有域初始化语句及初始化块
        // 3.如果构造器第一行调用了另外构造器，执行
        // 4.执行本本构造器剩下语句
        // 在类第一次加载时，进行静态域的初始化，所有静态初始化语句与静态初始化块都将依照定义的顺序执行

        // 类可以使用同包的所有类，及其他包中的公有类

        // 4.8 完全不知道在说什么

        // 4.9 文档注释

        // 5
        // 反射是指在程序运行期间发现更多的类及其属性的能力

        // 5.1
        // 一个变量可以指示引用多种类型叫多态
        // 在运行时可以自动选择调用哪个方法叫动态绑定

        // 5.1.3
        // 返回类型不是方法签名的一部分，所以在子类重写方法时，要注意保证返回类型的兼容性，允许子类的返回类型为原类型的子类


    }
    enum Size {
        SMALL, MEDIUM, LARGE, EXTRA_LARGE
    }
}
