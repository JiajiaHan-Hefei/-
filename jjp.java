import java.util.Scanner;
public class jjp{
	   public static void main(String[] args) {
        //�������
        Scanner scanner = new Scanner(System.in);
        int[] days = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        int month = -1;
       
        while(true) {
            try {
                System.out.print("�������·ݣ�");
                month = scanner.nextInt();
                if(month >= 1 && month <= 12) {
                    break;
                }
                System.out.println("** ��������ȷ���·� **");//������
            } catch (Exception e) {
                System.out.println("** ��ʽ�������������� **");
                scanner.next();
            }
        }
        System.out.println(month + " �·��У�" + days[month - 1] + " ��");
    }	
}