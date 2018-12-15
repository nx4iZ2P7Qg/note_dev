/**
 * 参考：https://javarevisited.blogspot.sg/2012/07/cyclicbarrier-example-java-5-concurrency-tutorial.html
 *
 * 此类与CountDownLatch一样，在其他线程完成后，执行某线程
 * All threads which wait for each other to reach barrier are called parties, CyclicBarrier is initialized with a number of parties to wait and threads wait for each other by calling CyclicBarrier.await() method which is a blocking method in Java and  blocks until all Thread or parties call await().
 */

import java.util.concurrent.BrokenBarrierException;
import java.util.concurrent.CyclicBarrier;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Java program to demonstrate how to use CyclicBarrier in Java. CyclicBarrier is a
 * new Concurrency Utility added in Java 5 Concurrent package.
 *
 * @author Javin Paul
 */
public class CyclicBarrierExample {

    /**
     * Runnable task for each thread
     * @author DF
     *
     */
    private static class Task implements Runnable {

        private CyclicBarrier barrier;

        public Task(CyclicBarrier barrier) {
            this.barrier = barrier;
        }

        @Override
        public void run() {
            try {
                System.out.println(Thread.currentThread().getName() + " is waiting on barrier");
                barrier.await();
                System.out.println(Thread.currentThread().getName() + " has crossed the barrier");
            } catch (InterruptedException ex) {
                Logger.getLogger(CyclicBarrierExample.class.getName()).log(Level.SEVERE, null, ex);
            } catch (BrokenBarrierException ex) {
                Logger.getLogger(CyclicBarrierExample.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public static void main(String args[]) {

        //creating CyclicBarrier with 3 parties i.e. 3 Threads needs to call await()
        final CyclicBarrier cb = new CyclicBarrier(3, new Runnable(){
            @Override
            public void run(){
                //This task will be executed once all thread reaches barrier
                System.out.println("All parties are arrived at barrier, lets play");
            }
        });

        //starting each of thread
        Thread t1 = new Thread(new Task(cb), "Thread 1");
        Thread t2 = new Thread(new Task(cb), "Thread 2");
        Thread t3 = new Thread(new Task(cb), "Thread 3");

        t1.start();
        t2.start();
        t3.start();
    }
}

/**
 * 什么时候使用
 * 像map reduce类似的fork-join framework of Java 7工作，其中大的任务被分解成几个小任务
 * 比如说用4个线程计算印度人口，分别计算东部，南部，西部，北部，当4个线程完成时，最后在主线程中求和
 *
 * 多人游戏，等待所有玩家确认后游戏才开始
 * 冗长的计算，实现map reduce
 *
 * 如果有线程阻断了在barrier上等待的线程，会产生BrokernBarrierException异常
 *
 * CyclicBarrier.reset()运行时，其他在barrier上等待的，或者尚未到达barrier的线程将被终止，并产生BrokenBarrierException
 */