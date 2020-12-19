public class TestArray {
   public static void main(String[] args) {
      double[] myList = {1.9, 2.9, 3.4, 3.5};
 
      // 打印所有数组元素
      //foreach
      //不使用下标情况下进行循环
      for (double element: myList) {
         System.out.println(element);
      }
   }
}