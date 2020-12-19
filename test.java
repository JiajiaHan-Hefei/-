import java.io.*;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

class test   {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String str = sc.nextLine();
        for(int i = 0; i < str.length(); i++){
            char c=str.charAt(i);
            System.out.println(c);
            if((c<'A') ||((c>'Z')&&(c<'a'))|| (c>'z') ){
                str=str.replace(c+"", "");
                i-=1;
            }
        }
        System.out.println(str);
        //
        int count = 0;//统计单个字符出现的次数
        for (int i = 0; i < str.length(); i++) {
            int old_length = str.length();
            char c = str.charAt(0);
            //定义一个字符等于字符串第一个字符.每次统计完会将统计过的字符替换掉.
            String new_str=str.replaceAll(c+"", "");//定义一个新字符串将出现的字符
            //System.out.println(new_str);
            //赋给一个新的字符串
            int new_length=new_str.length();
            count = old_length - new_length;//旧的长度减去新的长度就是字符出现的 次数
            str=new_str;//将替换并统计过次数的字符串赋给原来的字符串,便于下一次遍历
            System.out.print(""+c+count);
        }
    }
}
