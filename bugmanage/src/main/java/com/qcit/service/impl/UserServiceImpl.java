package com.qcit.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qcit.dao.UserDao;
import com.qcit.model.JoinMumber;
import com.qcit.model.SimpleHandlerVo;
import com.qcit.model.User;
import com.qcit.model.UserLoginSimple;
import com.qcit.service.UserService;
import com.qcit.util.ImageCodeUtil;

/*
 * 
 * 用户服务类
 * */
@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserDao userDao;
	@Autowired
	ImageCodeUtil imageCodeUtil;
    private static Logger logger=Logger.getLogger(UserServiceImpl.class);
	/*
	 * 登录成功 result:1 验证码错误 result:2 账号或者密码错误 result:0
	 */
	 @Transactional
	public String login(String email, String password, HttpServletRequest request, String code) {
		User user = userDao.getUserByEmail(email);
		logger.debug("USER ID:"+user.getId());
		HttpSession session = request.getSession();
		String SESSIONCODE = (String) session.getAttribute(imageCodeUtil.getSessionKey());
		if(user!=null){
		if (!code.equalsIgnoreCase(SESSIONCODE)) {
			session.removeAttribute(imageCodeUtil.getSessionKey());
			return "2";
		}
		if (user.getPassword().equals(password)) {
			session.setAttribute("user", user);
			session.setAttribute("id", user.getId());
			session.removeAttribute(imageCodeUtil.getSessionKey());
			return "1";
		}
		}
		return "0";
	}

	/*
	 * 注册成功 result:1 验证码错误 result:2 邮箱已经存在 result:0
	 */
	 @Transactional 
	public String register(String email, String password, String username, HttpServletRequest request, String code) {
		HttpSession session = request.getSession();
		String SESSIONCODE = (String) session.getAttribute(imageCodeUtil.getSessionKey());
		System.out.println(SESSIONCODE);
		if (code.equalsIgnoreCase(SESSIONCODE)) {
			if (this.checkEmailExist(email) != 0) {
				UserLoginSimple usesimple=new UserLoginSimple();
				usesimple.setEmail(email);
				usesimple.setPassword(password);
				usesimple.setUsername(username);
				userDao.setUser(usesimple);
				int id=usesimple.getId();
				User user = new User();
				user.setEmail(email);
				user.setId(id);
				user.setPassword(null);
				user.setUsername(username);
				session.setAttribute("user", user);
				session.removeAttribute(imageCodeUtil.getSessionKey());
				return "1";
			} else {
				session.removeAttribute(imageCodeUtil.getSessionKey());
				return "0";
			}
		} else {
			session.removeAttribute(imageCodeUtil.getSessionKey());
			return "2";
		}

	}

	/*
	 * 
	 * 邮箱已经存在 result:0 邮箱不存在 result:1 未知错误 result:2
	 */
	 @Transactional  
	public int checkEmailExist(String email) {
		int count = userDao.getCountEmail(email);
		if (count > 0) {
			return 0;
		}
		if (count == 0) {
			return 1;
		} else {
			return 2;
		}
	}

	/*
	 * 
	 * 修改成功 result:1 密码错误 result:0 未知错误 result:2 邮箱已经注册 result:3
	 * 
	 */
	 @Transactional 
	public int alterEmail(String email, String password, HttpServletRequest request) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		if (user != null) {
			int id = 0;
			if (user.getPassword().equals(password)) {
				if (this.checkEmailExist(email) != 0) {
					id = user.getId();
					userDao.updateEmailById(email, id);
					user.setEmail(email);
					session.setAttribute("user", user);
					return 1;
				} else {
					return 3;
				}

			} else {
				return 0;
			}
		} else {
			return 2;
		}
	}

	/*
	 * 修改成功 result:1 修改失败 result:0
	 */
	 @Transactional
	public int alterUsername(String username, HttpServletRequest request) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		if (user != null) {
			int id = user.getId();
			userDao.updateUsernameById(username, id);
			user.setEmail(username);
			session.setAttribute("user", user);
			return 1;
		} else {
			return 0;
		}
	}

	/*
	 * 修改成功 result:1 密码错误 result:0 未知错误 result:2
	 */
	 
	 @Transactional
	public int alterPassword(String oldpassword, String newpassword, HttpServletRequest request) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		if (user != null) {
			if (oldpassword.equals(user.getPassword())) {
				int id = user.getId();
				userDao.updatePasswordById(newpassword, id);
				user.setPassword(newpassword);
				session.setAttribute("user", user);
				return 1;
			} else {
				return 0;
			}
		} else {
			return 2;
		}
	}

	/*
	 * 修改成功返回1 失败返回0
	 */
	 @Transactional  
	public int alterPic(String pic, int id) {
		try{
		userDao.updateUserPicById(pic, id);
		return 1;
		}catch(Exception e){
		return 0;
		}
	} 

	 @Transactional  
	public String getUsernameById(int id) {
		
		return userDao.getUserNameById(id);
	}


	@Transactional
	public User getUserByEmail(String email) {
		
		return userDao.getUserBesidePassword(email);
	}
@Transactional
	@Override
	public List<JoinMumber> getJoinedMumber(int itemsid) {
		
		return userDao.getJoinedMumber(itemsid);
	}

@Override
public List<SimpleHandlerVo> getSimpleHandlerVo(int pid) {
	
	return userDao.getSimpleHandlerVo(pid);
}

}
