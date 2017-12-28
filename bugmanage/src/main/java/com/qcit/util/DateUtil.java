package com.qcit.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Value;

public class DateUtil {
	private final static String dateFormat="yyyy年MM月dd日 HH:mm:ss";
	
public static String getNowDate(){
	Date date =new Date();
	SimpleDateFormat simpledate =new SimpleDateFormat(dateFormat);
	return simpledate.format(date);
	
}

public static String getNowWholeDate(){
	Date date =new Date();
	SimpleDateFormat simpledate =new SimpleDateFormat(dateFormat);
	return simpledate.format(date);
}
public static String getDateAfterFormat(Date date){
	SimpleDateFormat simpledate =new SimpleDateFormat(dateFormat);
	return simpledate.format(date);
}
}
