import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.FutureTask;

/**
 * Callable的范型
 * @author DF
 *
 */
public class CallableThreadTest implements Callable<Integer> {
    public static void main(String[] args) {
        CallableThreadTest ctt = new CallableThreadTest();
        // 将Callable的实现传入FutureTask
        FutureTask<Integer> ft = new FutureTask<>(ctt);
        int loopTime = 100;
        for (int i = 0; i < loopTime; i++) {
            System.out.println(Thread.currentThread().getName() + " 的循环变量i的值" + i);
            // 从第21次循环开始
            if (i == 20) {
                // 指定子线程的参数并启动
                new Thread(ft, "有返回值的线程").start();
            }
        }
        try {
            // 最终结果
            System.out.println("子线程的返回值：" + ft.get());
        } catch (InterruptedException e) {
            e.printStackTrace();
        } catch (ExecutionException e) {
            e.printStackTrace();
        }

    }

    @Override
    public Integer call() throws Exception {
        int i = 0;
        int loopTime = 100;
        for (; i < loopTime; i++) {
            System.out.println(Thread.currentThread().getName() + " " + i);
        }
        return i;
    }
}
