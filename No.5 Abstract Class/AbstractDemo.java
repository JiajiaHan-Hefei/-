


/* ÎÄ¼þÃû : AbstractDemo.java */
public class AbstractDemo
{
   public static void main(String [] args)
   {
      double salary;
      Salary s = new Salary("Mohd Mohtashim", "Ambehta, UP", 3, 3600.00);
      Employee e = new Salary("John Adams", "Boston, MA", 2, 2400.00);
 
      System.out.println("\nCall mailCheck using Salary reference --");
      s.mailCheck();
      salary = s.computePay();
      System.out.println("now,the salary in month is "+ salary);
 
      System.out.println("\n Call mailCheck using Employee reference--");
      e.mailCheck();
    }
}