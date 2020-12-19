/* 文件名 : VirtualDemo.java */
public class VirtualDemo {
   public static void main(String [] args) {
      Salary s = new Salary("员工 A", "北京", 3, 3600.00);//该句执行了父类的Employee
      Employee e = new Salary("员工 B", "上海", 2, 2400.00);//该句执行了父类的Employee
      Employee d = new Employee("员工 C", "广州", 5);
      
      System.out.println("使用 Salary 的引用调用 mailCheck -- ");
      s.mailCheck();
      System.out.println("\n使用 Employee 的引用调用 mailCheck--");
      e.mailCheck();
      System.out.println("\n使用 Employee 的引用调用 mailCheck--");
      d.mailCheck();
      
    }
}