// 文件名 : ThreadClassDemo.java
public class ThreadClassDemo {
 
   public static void main(String [] args) {
   	
      Runnable hello = new DisplayMessage("Hello");//创建DisplayMessage对象
      Thread thread1 = new Thread(hello);
      thread1.setDaemon(true);//将该线程标记为守护线程或用户线程。
      thread1.setName("hello");//改变线程名称，使之与参数 "hello" 相同。
      System.out.println("Starting hello thread...");
      thread1.start();
      
      Runnable bye = new DisplayMessage("Goodbye");//创建DisplayMessage对象
      Thread thread2 = new Thread(bye);
      thread2.setPriority(Thread.MIN_PRIORITY);//更改线程的优先级。
      thread2.setDaemon(true);
      System.out.println("Starting goodbye thread...");
      thread2.start();
 
 
      System.out.println("Starting thread3...");
      Thread thread3 = new GuessANumber(2);//创建GuessANumber对象
      thread3.start();
      try {
         thread3.join();
      }catch(InterruptedException e) {
         System.out.println("Thread interrupted.");
      }
      
      System.out.println("Starting thread4...");
      Thread thread4 = new GuessANumber(5);//创建GuessANumber对象
      thread4.start();
      System.out.println("main() is ending...");
   }
}