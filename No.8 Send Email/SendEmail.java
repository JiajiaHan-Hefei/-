// ��Ҫ�û��������ʼ�����ʵ��
//�ļ��� SendEmail.java
//��ʵ����QQ����Ϊ��������Ҫ��qq��̨����
 
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
      // �ռ��˵�������
      String to = "1150943013@qq.com";
 
      // �����˵�������
      String from = "1620227741@qq.com";
 
      // ָ�������ʼ�������Ϊ smtp.qq.com
      String host = "smtp.qq.com";  //QQ �ʼ�������
 
      // ��ȡϵͳ����
      Properties properties = System.getProperties();
 
      // �����ʼ�������
      properties.setProperty("mail.smtp.host", host);
 
      properties.put("mail.smtp.auth", "true");
      
      // ��ȡĬ��session����
      Session session = Session.getDefaultInstance(properties,new Authenticator(){
        
        public PasswordAuthentication getPasswordAuthentication()
        {
         return new PasswordAuthentication("1620227741@qq.com", "qrjmrapgcbbsedei"); //�������ʼ��û���������
        }
       });
       
 
      try{
         // ����Ĭ�ϵ� MimeMessage ����
         MimeMessage message = new MimeMessage(session);
 
         // Set From: ͷ��ͷ�ֶ�
         message.setFrom(new InternetAddress(from));
 
         // Set To: ͷ��ͷ�ֶ�
         message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));
 
         // Set Subject: ͷ��ͷ�ֶ�
         message.setSubject("This is the Subject Line!");
 
         // ������Ϣ��
         message.setText("Hello,I study the Java language,so I write a code about how to send email to you.");
 
         // ������Ϣ
         Transport.send(message);
         System.out.println("sending this  mail succeed.");
      }catch (MessagingException mex) {
         mex.printStackTrace();
      }
   }
}