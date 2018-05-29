/**
 * 继承Thread类，重写run()方法
 * 实例用start()方法启用线程
 */
public class ThreadDemo extends Thread {

    /**
     * 用来分辨是哪个实例在运行
     */
    private int i;

    private Thread01(int i) {
        this.i = i;
    }

    public void run() {
        // 输出的结果无序，但正确
        System.out.println("MyThread " + i + ".run()");
    }

    public static void main(String args[]) {
        Thread01 myT1 = new Thread01(1);
        Thread01 myT2 = new Thread01(2);
        Thread01 myT3 = new Thread01(3);
        myT1.start();
        myT2.start();
        myT3.start();
    }
}

