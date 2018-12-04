package java7;

import java.lang.reflect.Constructor;


public class Reflection {
    /**
     * key_reflection_Contructor_newInstance
     * @param args
     */
    public static void main(String[] args) {
        try {
            Reflection b = new Reflection();
            Class<?> c = Class.forName("java7.TestB");
            // 无参数
            TestB b1 = (TestB) c.newInstance();
            // 有参数需要使用Constructor类对象
            Constructor ct = c.getDeclaredConstructor(int.class, String.class);
            ct.setAccessible(true);
            TestB b2 = (TestB) ct.newInstance(1, "2");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

class TestB {
    public TestB() {
        System.out.println("Test A");
    }

    /**
     * 私有构造方法
     */
    private TestB(int a, String b) {
        System.out.println("Test parames");
    }
}