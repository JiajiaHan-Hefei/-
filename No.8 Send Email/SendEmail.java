// 需要用户名密码邮件发送实例
//文件名 SendEmail.java
//本实例以QQ邮箱为例，你需要在qq后台设置
 
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
 
public class SendEmail{
   public static void main(String [] args)
   {
      // 收件人电子邮箱
      String to = "1150943013@qq.com";
 
      // 发件人电子邮箱
      String from = "1620227741@qq.com";
 
      // 指定发送邮件的主机为 smtp.qq.com
      String host = "smtp.qq.com";  //QQ 邮件服务器
 
      // 获取系统属性
      Properties properties = System.getProperties();
 
      // 设置邮件服务器
      properties.setProperty("mail.smtp.host", host);
 
      properties.put("mail.smtp.auth", "true");
      
      // 获取默认session对象
      Session session = Session.getDefaultInstance(properties,new Authenticator(){
        
        public PasswordAuthentication getPasswordAuthentication()
        {
         return new PasswordAuthentication("1620227741@qq.com", "qrjmrapgcbbsedei"); //发件人邮件用户名、密码
        }
       });
       
 
      try{
         // 创建默认的 MimeMessage 对象
         MimeMessage message = new MimeMessage(session);
 
         // Set From: 头部头字段
         message.setFrom(new InternetAddress(from));
 
         // Set To: 头部头字段
         message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));
 
         // Set Subject: 头部头字段
         message.setSubject("This is the Subject Line!");
 
         // 设置消息体
         message.setText("Hello,I study the Java language,so I write a code about how to send email to you.");
 
         // 发送消息
         Transport.send(message);
         System.out.println("sending this  mail succeed.");
      }catch (MessagingException mex) {
         mex.printStackTrace();
      }
   }
}