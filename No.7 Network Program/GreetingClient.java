// �ļ��� GreetingClient.java
//�ͻ���ʵ��
import java.net.*;
import java.io.*;
 
public class GreetingClient
{
   public static void main(String [] args)
   {
      String serverName = args[0];//����
      int port = Integer.parseInt(args[1]);//�˿ں�
      
      //����������
      try
      {
         System.out.println("���ӵ�������" + serverName + " ���˿ںţ�" + port);
         Socket client = new Socket(serverName, port);
         System.out.println("Զ��������ַ��" + client.getRemoteSocketAddress());
         OutputStream outToServer = client.getOutputStream();
         DataOutputStream out = new DataOutputStream(outToServer);
 
         out.writeUTF("Hello from " + client.getLocalSocketAddress());
         InputStream inFromServer = client.getInputStream();//���ش��׽��ֵ���������
         DataInputStream in = new DataInputStream(inFromServer);
         System.out.println("��������Ӧ�� " + in.readUTF());
         client.close();
      }catch(IOException e)
      {
         e.printStackTrace();
      }
   }
}