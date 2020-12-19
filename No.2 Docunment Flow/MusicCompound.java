import java.io.*;
/*
 1. 使用 FileInputStream 输入两个音频

2. 使用 FileInputStream的skip(long n) 方法跳过特定字节长度的音频文件，比如说：输入 skip(1024*1024*3)，这样就能丢弃掉音频文件前面的 3MB 的内容。

3. 截取中间特定长度的音频文件：每次输入 8KB 的内容，使用 count 记录输入次数，达到设置的次数就终止音频输入。比如说要截取 2MB 的音频，每次往输入流中输入 8KB 的内容，就要输入 1024*2/8 次。

4. 往同一个输出流 FileOutputStream 中输出音频，并生成文件，实现音频混合。
*/
public class MusicCompound 
{
    public static void main(String args[])
    {
        FileOutputStream fileOutputStream = null;
        FileInputStream fileInputStream = null;
        
        String fileNames[] = {"星月神话.mp3","我只在乎你.mp3"};
        
        //设置byte数组，每次往输出流中传入8K的内容
        byte by[] = new byte[1024*8];
        try
        {
            fileOutputStream = new FileOutputStream("合并.mp3");
            for(int i=0;i<2;i++)
            {
                int count = 0;
                fileInputStream = new FileInputStream(fileNames[i]);
                //跳过前面3M的歌曲内容
                fileInputStream.skip(1024*1024*3);
                while(fileInputStream.read(by) != -1)
                {                    
                    fileOutputStream.write(by);
                    count++;
                    System.out.println(count);
                    
                    //要截取中间2MB的内容，每次输入8k的内容，所以输入的次数是1024*2/8
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
                //输出完成后关闭输入输出流
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