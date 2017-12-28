package com.qcit.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.qcit.model.JoinMumber;
import com.qcit.model.SimpleHandlerVo;
import com.qcit.model.User;

public interface UserService { 
	public String login(String email, String password, HttpServletRequest request, String code);

	public String register(String email, String password, String username, HttpServletRequest request, String code);

	public int checkEmailExist(String email);

	public int alterEmail(String email, String password, HttpServletRequest request);

	public int alterUsername(String username, HttpServletRequest request);

	public int alterPassword (String oldpassword, String newpassword, HttpServletRequest request);
	
	public int alterPic(String pic,int id);
	
	public String getUsernameById(int id);
	
	public User getUserByEmail(String email);
	
	public List<JoinMumber> getJoinedMumber(int itemsid);
	
	public List<SimpleHandlerVo> getSimpleHandlerVo(int pid);
}
