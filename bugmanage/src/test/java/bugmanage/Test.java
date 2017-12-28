package bugmanage;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.io.StringReader;

import com.qcit.enumpackage.Constant;

public class Test {

	public static void main(String[] args) {
	File file=new File("src/test/java/bugmanage/test.txt");
	BufferedReader reader=null;
	String s=null;
	try {
		 reader = new BufferedReader(new FileReader(file));  
         // 一次读入一行，直到读入null为文件结束  
         while ((s = reader.readLine()) != null) {
        	 s="html+=\""+s.replace("\"", "\\\"")+"\";";
           System.out.println(s);
         }  
         reader.close();  
	} catch (FileNotFoundException e) {
		// TODO 自动生成的 catch 块
		e.printStackTrace();
	} catch (IOException e) {
		// TODO 自动生成的 catch 块
		e.printStackTrace();
	}
	

	}

}
