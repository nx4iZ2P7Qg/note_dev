/**
 * 参考：https://javarevisited.blogspot.sg/2014/05/double-checked-locking-on-singleton-in-java.html
 *
 * 单例模式中的两次check，保证多线程或其他情况下始终只有一个实例，在jdk1.5修复内存模型以前
 * 通常会破坏单例的情况是多线程
 */
class SingletonDemo {
    private static Singleton _instance;

    public static Singleton getInstance() {
        if (_instance == null) {
            _instance = new Singleton();
        }
        return _instance;
    }
}

/**
 * 在并发的时候，以上代码会破坏单例
 * 尝试在getInstance前加上synchronized，可以解决这个问题，但性能并不好
 * 考虑到同步的一些原则，最小化同步范围
 * 在判空处同步，就是double check locking pattern
 */
class ConcurrentSingletonDemo {
    private static Singleton _instance;

    public static Singleton getInstanceDC() {
        if (_instance == null) {                // Single Checked
            synchronized (Singleton.class) {
                if (_instance == null) {        // Double checked
                    _instance = new Singleton();
                }
            }
        }
        return _instance;
    }
}

/**
 * 上面的单例看起来很美好，实际还有问题
 * 没有volatile修饰_instance，其他线程可能会看到初始化进行了一半的_instance
 * 如果有volatile修饰，由于此字段的特性(guaranteeing happens-before relationship)，在_instance的读取之前所有的写入操作都会完成
 * 顺便说一句，这并不是最好的线程安全单例的实现方式
 * 可以使用枚举单例，它提供了内建的线程安全，另外可以使用static holder pattern
 */

/**
 * 以上就是double check locking of singleton class，是一种有争议的方法
 * 不建议在代码中使用
 * 这个问题有一些历史重要性，同时说明了并发中微妙的bug
 * 在当代测试驱动的开发中(test driven development)，单例被认为是反模式(anti pattern)的
 * 如果是测试驱动的开发项目中，最好不要使用单例
 */