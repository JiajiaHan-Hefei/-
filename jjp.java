import java.util.Scanner;
public class jjp{
	   public static void main(String[] args) {
        //输入语句
        Scanner scanner = new Scanner(System.in);
        int[] days = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        int month = -1;
       
        while(true) {
            try {
                System.out.print("请输入月份：");
                month = scanner.nextInt();
                if(month >= 1 && month <= 12) {
                    break;
                }
                System.out.println("** 请输入正确的月份 **");//输出语句
            } catch (Exception e) {
                System.out.println("** 格式错误！请输入数字 **");
                scanner.next();
            }
        }
        System.out.println(month + " 月份有：" + days[month - 1] + " 天");
    }	
}