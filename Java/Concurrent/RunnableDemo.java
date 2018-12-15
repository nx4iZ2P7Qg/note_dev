/**
 * 实现Runnable类，重写run()方法
 * 实例用start()方法启用线程
 * 
 * @author DF
 */
public class RunnableDemo implements Runnable {

    /**
     * 用来分辨是哪个实例在运行
     */
    private int i;

    private Thread02(int i) {
        this.i = i;
    }

    public void run() {
        // 输出的结果无序，但正确
        System.out.println("MyThread " + i + ".run()");
    }

    public static void main(String args[]) {
        Thread02 myT1 = new Thread02(1);
        Thread02 myT2 = new Thread02(2);
        Thread02 myT3 = new Thread02(3);
        Thread t1 = new Thread(myT1);
        Thread t2 = new Thread(myT2);
        Thread t3 = new Thread(myT3);
        t1.start();
        t2.start();
        t3.start();
    }
}

