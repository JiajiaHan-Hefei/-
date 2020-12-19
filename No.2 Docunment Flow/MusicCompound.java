import java.io.*;
/*
 1. ʹ�� FileInputStream ����������Ƶ

2. ʹ�� FileInputStream��skip(long n) ���������ض��ֽڳ��ȵ���Ƶ�ļ�������˵������ skip(1024*1024*3)���������ܶ�������Ƶ�ļ�ǰ��� 3MB �����ݡ�

3. ��ȡ�м��ض����ȵ���Ƶ�ļ���ÿ������ 8KB �����ݣ�ʹ�� count ��¼����������ﵽ���õĴ�������ֹ��Ƶ���롣����˵Ҫ��ȡ 2MB ����Ƶ��ÿ���������������� 8KB �����ݣ���Ҫ���� 1024*2/8 �Ρ�

4. ��ͬһ������� FileOutputStream �������Ƶ���������ļ���ʵ����Ƶ��ϡ�
*/
public class MusicCompound 
{
    public static void main(String args[])
    {
        FileOutputStream fileOutputStream = null;
        FileInputStream fileInputStream = null;
        
        String fileNames[] = {"������.mp3","��ֻ�ں���.mp3"};
        
        //����byte���飬ÿ����������д���8K������
        byte by[] = new byte[1024*8];
        try
        {
            fileOutputStream = new FileOutputStream("�ϲ�.mp3");
            for(int i=0;i<2;i++)
            {
                int count = 0;
                fileInputStream = new FileInputStream(fileNames[i]);
                //����ǰ��3M�ĸ�������
                fileInputStream.skip(1024*1024*3);
                while(fileInputStream.read(by) != -1)
                {                    
                    fileOutputStream.write(by);
                    count++;
                    System.out.println(count);
                    
                    //Ҫ��ȡ�м�2MB�����ݣ�ÿ������8k�����ݣ���������Ĵ�����1024*2/8
                    if(count == (1024*2/8))
                    {
                        break;
                    }
                }
            }
        }
        catch(FileNotFoundException e)
        {
            e.printStackTrace();
        }
        catch(IOException e)
        {
            e.printStackTrace();
        }
        finally
        {
            try
            {
                //�����ɺ�ر����������
                fileInputStream.close();
                fileOutputStream.close();
            } 
            catch(IOException e)
            {
                e.printStackTrace();
            }
        }
    }
}