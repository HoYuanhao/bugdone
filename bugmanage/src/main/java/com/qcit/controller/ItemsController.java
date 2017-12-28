package com.qcit.controller;

import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.qcit.enumpackage.Constant;
import com.qcit.model.ItemsListVo;
import com.qcit.model.ItemsPo;
import com.qcit.model.JoinMumber;
import com.qcit.model.ProjectVo;
import com.qcit.model.SimpleProblemVo;
import com.qcit.model.User;
import com.qcit.service.ItemsService;
import com.qcit.service.UserService;
import com.qcit.util.FileUtil;

@Controller
@RequestMapping("items")
public class ItemsController {

	Logger logger = Logger.getLogger(ItemsController.class);
	@Autowired
	ItemsService itemsService;
	@Autowired
	FileUtil fileUtil;
	@Autowired
	UserService userService;

	/**
	 * 显示主页信息接口
	 * 显示登陆后项目主页的信息
	 * @param session
	 * @param id
	 * @param ishidden
	 *            是否隐藏
	 * @return 集合名称 itemslistvo 集合中的元素字段：actionnumber 活动的问题数|problemnumber
	 *         问题总数|name 项目名称|id 项目id|pic 项目图片
	 */
	@RequestMapping(value = "getpage")
	public @ResponseBody String getItemsList(HttpSession session, @RequestParam("id") int id,
			@RequestParam("ishidden") String ishidden,@RequestParam("page")int page,HttpServletRequest request) {
		List<ItemsListVo> list = itemsService.getItemsListPage(id, ishidden,(page-1)*16,page*16,request);
		JSONObject json = new JSONObject();
		json.put("itemslistvo", list);
		return json.toJSONString();

	}

	
	
	/**
	 * 新建项目接口
	 * 必须以post方式提交 
	 * @param name
	 *            项目标题
	 * @param description
	 *            项目描述
	 * @param base64Data
	 *            base64格式的图片 可以为空
	 * @param request
	 * @return result：1 创建有图片的项目成功| result：3 数据格式有误 | result：2 照片为空(成功) items：
	 *         creater：创建人ID creationtime：项目创建时间 description：描述 id：项目id
	 *         itemspic：项目头像路径 name：项目名称 owner：拥有者id
	 */
	@RequestMapping(value = "newitems", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public @ResponseBody String setItems(
			@RequestParam("projectname") String name, 
			@RequestParam("projecttext") String description,
			@RequestParam("itemsid")String item,
		HttpServletRequest request) {
		if(item.equals("")||item.equals("0")){
			Map<String, String> map = new HashMap<String, String>();
			JSONObject json = new JSONObject();
		User user = (User) request.getSession().getAttribute(Constant.user.name());
	  int itemsid = itemsService.setItemsPicPath(name, description, null,user.getId(), user.getId());
       map.put("creater", userService.getUsernameById(user.getId()));
       map.put("creationtime", itemsService.getItemsCreateDate(itemsid));
       map.put("email", user.getEmail());
       map.put("itemsid", String.valueOf(itemsid));
       map.put("result", "1");
       logger.debug("新建项目信息："+map);
		json.putAll(map);
		String jsonString=json.toJSONString();
		System.out.println(jsonString);
		json=null;
		map=null;
		return jsonString;
		}else{
			itemsService.updateNewItems(Integer.valueOf(item), name, description);
			JSONObject json = new JSONObject();
			json.put("result", "0");
			return json.toJSONString();
		}
	}

	
	/**
	 * 改变项目的隐藏状态接口
	 * @param id 项目ID
	 * @param hidden 隐藏状态码  0隐藏 1非隐藏
	 * @return 成功result返回1 失败返回0
	 */
	@RequestMapping("changehidden")
	public @ResponseBody String changeItemsHidden(@RequestParam("id")int id,@RequestParam("hidden")int hidden){
		String result=null;
		try{
		itemsService.changeHiddenState(id, hidden);
		result="1";
		}catch(Exception e){
			result="0";
		}
		JSONObject json =new JSONObject();
		json.put("result", result);
		return json.toJSONString();
		
	}
	
	
	/**
	 * 改变项目存在状态接口
	 * @param id 项目ID
	 * @param exist 存在码 0存在 1不存在
	 * @return 成功result返回1 失败返回0
	 */
	@RequestMapping("changeexist")
	public @ResponseBody String changeItemsExist(@RequestParam("id")int id,@RequestParam("exist")int exist){
		String result=null;
		try{
		itemsService.changeExistState(id, exist);
		result="1";
		}catch(Exception e){
			result="0";
		}
		JSONObject json =new JSONObject();
		json.put("result", result);
		return json.toJSONString();
		
	}

	
	@RequestMapping(value="project2",produces="application/json;charset=UTF-8")
	public @ResponseBody 
	String  project(@RequestParam("id")int id,
			HttpServletRequest request){
		HttpSession session =request.getSession();
		List<SimpleProblemVo> list=itemsService.showActionProblem(id);
		Map<String,Object> map=new HashMap<String,Object>(); 
		map.put("list", list);
		map.put("order", "asc");
		session.setAttribute("project2", list);
		logger.debug("project2:"+map);
		return JSON.toJSONString(map);
		
	}
	@RequestMapping("project1")
	public String project1(@RequestParam("id")int id,
			HttpServletRequest request,
			@RequestParam("actionnumber")int actionnumber,
			@RequestParam("problemnumber")int problemnumber){
		HttpSession session =request.getSession();
		User user=(User) session.getAttribute(Constant.user.name());
		ProjectVo project=itemsService.showProject(id, user.getId());
		request.setAttribute("project", project);
		request.setAttribute("itemsid", id);
		request.setAttribute("actionnumber", actionnumber);
		request.setAttribute("problemnumber", problemnumber);
		request.setAttribute("order", "asc");
		session.setAttribute("project1", project);
		logger.debug("project1:"+project);
		project=null;
		return "project1";
		
	}
	
	
	
	@RequestMapping(value="project3",produces="application/json;charset=UTF-8")
	public 
	@ResponseBody
	String project3(
			@RequestParam("id")int id,
			HttpServletRequest request
			){
		HttpSession session =request.getSession();
		List<SimpleProblemVo> list=itemsService.showAllProblem(id);
		session.setAttribute("project1", list);
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("list", list);
       map.put("result", 1);
   	logger.debug("project3:"+list);
   	logger.debug("project3 result:"+1);
		return JSON.toJSONString(map);
		
	}
	
	@RequestMapping(value="project4",produces="application/json;charset=UTF-8")
	public 
	@ResponseBody
	String project4(
			@RequestParam("id") int id,
			HttpServletRequest request){
		ItemsPo itemspo=itemsService.getItemsPo(id);
		long endTime=itemspo.getCreationtime().getTime();
		long beginTime=System.currentTimeMillis();
		int betweenDay=(int)(beginTime-endTime)/(1000*60*60*24);
		JSONObject json=new JSONObject();
		logger.debug("project4:"+(betweenDay+1));
		json.put("runningtime", betweenDay+1);
		return json.toJSONString();
		
	}
	
	@RequestMapping(value="project5",produces="application/json;charset=UTF-8")
	public 
	@ResponseBody
	String project5(
			@RequestParam("id") int id,
			HttpServletRequest request){
		HttpSession session =request.getSession();
		User user= (User) session.getAttribute(Constant.user.name());
		List<SimpleProblemVo> list=itemsService.showMyProblem(id, user.getId());
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("list", list);
		logger.debug("project5:"+map);
		return JSON.toJSONString(map);	
	}
	
	
	@RequestMapping(value="project6",produces="application/json;charset=UTF-8")
	public 
	@ResponseBody
	String project6(
			@RequestParam("id") int id,
			HttpServletRequest request){
		HttpSession session =request.getSession();
		User user= (User) session.getAttribute(Constant.user.name());
		List<SimpleProblemVo> list=itemsService.showProblemToMe(id, user.getId());
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("list", list);
		logger.debug("project6:"+map);
		return JSON.toJSONString(map);	
	}
	
	
	@RequestMapping(value="project7",produces="application/json;charset=UTF-8")
	public 
	@ResponseBody
	String project7(
			@RequestParam("id") int id,
			HttpServletRequest request){
		HttpSession session =request.getSession();
		User user= (User) session.getAttribute(Constant.user.name());
		List<SimpleProblemVo> list=itemsService.showMyHandlerProblem(id, user.getId()); 
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("list", list);
		logger.debug("project7:"+map);
		return JSON.toJSONString(map);	
	}
	
	@RequestMapping(value="project8",produces="application/json;charset=UTF-8")
	public 
	@ResponseBody
	String project8(
			@RequestParam("id") int id,
			HttpServletRequest request){
//		HttpSession session =request.getSession();
//		User user= (User) session.getAttribute(Constant.user.name());
//		List<SimpleProblemVo> list=itemsService.showMyHandlerProblem(id, user.getId()); 
//		Map<String,Object> map=new HashMap<String, Object>();
//		map.put("list", list);
//		logger.debug("project8:"+map);
//		return JSON.toJSONString(map);	
		JSONObject json=new JSONObject();
		 json.put("result", 1);
		return json.toJSONString();
	}
	
	
	@RequestMapping(value="project9",produces="application/json;charset=UTF-8")
	public 
	@ResponseBody
	String project9(
			@RequestParam("id") int id,
			HttpServletRequest request){
//		HttpSession session =request.getSession();
//		User user= (User) session.getAttribute(Constant.user.name());
//		List<SimpleProblemVo> list=itemsService.showMyHandlerProblem(id, user.getId()); 
//		Map<String,Object> map=new HashMap<String, Object>();
//		map.put("list", list);
//		logger.debug("project8:"+map);
//		return JSON.toJSONString(map);	
		JSONObject json=new JSONObject();
		 json.put("result", 1);
		return json.toJSONString();
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("itemssort")//排序接口
	public String itemssort(@RequestParam("id")int id,HttpServletRequest request,
			@RequestParam("actionnumber")int actionnumber,
			@RequestParam("problemnumber")int problemnumber,
			@RequestParam("type")int type,
			@RequestParam("action")String action,
			@RequestParam("order")String order){
		HttpSession session =request.getSession();
		//project1页面提交的请求
		if(action.equals("p1")){
			//升序
			if(order.equals("asc")){
				request.setAttribute("order", "desc");
			ProjectVo project=(ProjectVo) session.getAttribute("project1");
			List<SimpleProblemVo> list =project.getList();
			//根据编号排序
			if(type==1){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getId()>problem2.getId()){  
			                return 1;  
			            }else if(problem1.getId()==problem2.getId()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据类型排序
			else if(type==2){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getType()>problem2.getType()){  
			                return 1;  
			            }else if(problem1.getType()==problem2.getType()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据状态排序
			else if(type==3){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getState()>problem2.getState()){  
			                return 1;  
			            }else if(problem1.getState()==problem2.getState()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
				//根据优先级排序
			}else if(type==4){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getPriority()>problem2.getPriority()){  
			                return 1;  
			            }else if(problem1.getPriority()==problem2.getPriority()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据指派人排序
			else if(type==5){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;
			        	if(problem2.getHandlerName()==null){
			        		return 1;
			        	}else if(problem1.getHandlerName()==null){
			            	return -1;
			            }
			        	else if(problem2.getHandlerName()!=null&&problem1.getHandlerName()!=null&&problem1.getHandlerName().charAt(0)>problem2.getHandlerName().charAt(0)){  
			                return 1;  
			            }else if(problem2.getHandlerName()!=null&&problem1.getHandlerName()!=null&&problem1.getHandlerName().charAt(0)==problem2.getHandlerName().charAt(0)){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据创建时间排序
			else if(type==6){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getCreatetime().after(problem2.getCreatetime())){  
			                return 1;  
			            }else if(problem1.getCreatetime().before(problem2.getCreatetime())){  
			                return -1;  
			            }else{  
			                return 0;  
			            }  
			        }             
			    });  
			}
			else if(type==7){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getUpdatetime().after(problem2.getUpdatetime())){  
			                return 1;  
			            }else if(problem1.getUpdatetime().before(problem2.getUpdatetime())){  
			                return -1;  
			            }else{  
			                return 0;  
			            }  
			        }             
			    });  
			}
			request.setAttribute("itemsid", id);
			request.setAttribute("actionnumber", actionnumber);
			request.setAttribute("problemnumber", problemnumber);
			request.setAttribute("project", project);
			project=null;
			return "project1";
		}
			//降序
			else{
			request.setAttribute("order", "asc");
			ProjectVo project=(ProjectVo) session.getAttribute("project1");
			List<SimpleProblemVo> list =project.getList();
			//根据编号排序
			if(type==1){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getId()<problem2.getId()){  
			                return 1;  
			            }else if(problem1.getId()==problem2.getId()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据类型排序
			else if(type==2){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getType()<problem2.getType()){  
			                return 1;  
			            }else if(problem1.getType()==problem2.getType()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据状态排序
			else if(type==3){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getState()<problem2.getState()){  
			                return 1;  
			            }else if(problem1.getState()==problem2.getState()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
				//根据优先级排序
			}else if(type==4){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getPriority()<problem2.getPriority()){  
			                return 1;  
			            }else if(problem1.getPriority()==problem2.getPriority()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据指派人排序
			else if(type==5){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;
			        	if(problem2.getHandlerName()==null){
			        		return -1;
			        	}else if(problem1.getHandlerName()==null){
			            	return 1;
			            }
			        	else if(problem2.getHandlerName()!=null&&problem1.getHandlerName()!=null&&problem1.getHandlerName().charAt(0)<problem2.getHandlerName().charAt(0)){  
			                return 1;  
			            }else if(problem2.getHandlerName()!=null&&problem1.getHandlerName()!=null&&problem1.getHandlerName().charAt(0)==problem2.getHandlerName().charAt(0)){  
			                return 0;  
			            }else{  
			                return 1;  
			            }  
			        }             
			    });  
			}
			//根据创建时间排序
			else if(type==6){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getCreatetime().after(problem2.getCreatetime())){  
			                return -1;  
			            }else if(problem1.getCreatetime().before(problem2.getCreatetime())){  
			                return 1;  
			            }else{  
			                return 0;  
			            }  
			        }             
			    });  
			}else if(type==7){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getUpdatetime().after(problem2.getUpdatetime())){  
			                return -1;  
			            }else if(problem1.getUpdatetime().before(problem2.getUpdatetime())){  
			                return 1;  
			            }else{  
			                return 0;  
			            }  
			        }             
			    });  
			}
			request.setAttribute("itemsid", id);
			request.setAttribute("actionnumber", actionnumber);
			request.setAttribute("problemnumber", problemnumber);
			request.setAttribute("project", project);
			project=null;
			return "project1";
			
			
		}
			}
		
		
		//p2
		if(action.equals("p2")){
			//升序
			if(order.equals("asc")){
				request.setAttribute("order", "desc");
				List<SimpleProblemVo> list =(List<SimpleProblemVo>) session.getAttribute("project2");
			
			//根据编号排序
			if(type==1){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getId()>problem2.getId()){  
			                return 1;  
			            }else if(problem1.getId()==problem2.getId()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据类型排序
			else if(type==2){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getType()>problem2.getType()){  
			                return 1;  
			            }else if(problem1.getType()==problem2.getType()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据状态排序
			else if(type==3){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getState()>problem2.getState()){  
			                return 1;  
			            }else if(problem1.getState()==problem2.getState()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
				//根据优先级排序
			}else if(type==4){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getPriority()>problem2.getPriority()){  
			                return 1;  
			            }else if(problem1.getPriority()==problem2.getPriority()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据指派人排序
			else if(type==5){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;
			        	if(problem2.getHandlerName()==null){
			        		return 1;
			        	}else if(problem1.getHandlerName()==null){
			            	return -1;
			            }
			        	else if(problem2.getHandlerName()!=null&&problem1.getHandlerName()!=null&&problem1.getHandlerName().charAt(0)>problem2.getHandlerName().charAt(0)){  
			                return 1;  
			            }else if(problem2.getHandlerName()!=null&&problem1.getHandlerName()!=null&&problem1.getHandlerName().charAt(0)==problem2.getHandlerName().charAt(0)){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据创建时间排序
			else if(type==6){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getCreatetime().after(problem2.getCreatetime())){  
			                return 1;  
			            }else if(problem1.getCreatetime().before(problem2.getCreatetime())){  
			                return -1;  
			            }else{  
			                return 0;  
			            }  
			        }             
			    });  
			}
			else if(type==7){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getUpdatetime().after(problem2.getUpdatetime())){  
			                return 1;  
			            }else if(problem1.getUpdatetime().before(problem2.getUpdatetime())){  
			                return -1;  
			            }else{  
			                return 0;  
			            }  
			        }             
			    });  
			}
			request.setAttribute("itemsid", id);
			request.setAttribute("actionnumber", actionnumber);
			request.setAttribute("problemnumber", problemnumber);
			
			request.setAttribute("list", list);
			list=null;
			return "project2";
		}
			//降序
			else{
			request.setAttribute("order", "asc");
			List<SimpleProblemVo> list =(List<SimpleProblemVo>) session.getAttribute("project2");
			//根据编号排序
			if(type==1){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getId()<problem2.getId()){  
			                return 1;  
			            }else if(problem1.getId()==problem2.getId()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据类型排序
			else if(type==2){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getType()<problem2.getType()){  
			                return 1;  
			            }else if(problem1.getType()==problem2.getType()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据状态排序
			else if(type==3){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getState()<problem2.getState()){  
			                return 1;  
			            }else if(problem1.getState()==problem2.getState()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
				//根据优先级排序
			}else if(type==4){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getPriority()<problem2.getPriority()){  
			                return 1;  
			            }else if(problem1.getPriority()==problem2.getPriority()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据指派人排序
			else if(type==5){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;
			        	if(problem2.getHandlerName()==null){
			        		return -1;
			        	}else if(problem1.getHandlerName()==null){
			            	return 1;
			            }
			        	else if(problem2.getHandlerName()!=null&&problem1.getHandlerName()!=null&&problem1.getHandlerName().charAt(0)<problem2.getHandlerName().charAt(0)){  
			                return 1;  
			            }else if(problem2.getHandlerName()!=null&&problem1.getHandlerName()!=null&&problem1.getHandlerName().charAt(0)==problem2.getHandlerName().charAt(0)){  
			                return 0;  
			            }else{  
			                return 1;  
			            }  
			        }             
			    });  
			}
			//根据创建时间排序
			else if(type==6){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getCreatetime().after(problem2.getCreatetime())){  
			                return -1;  
			            }else if(problem1.getCreatetime().before(problem2.getCreatetime())){  
			                return 1;  
			            }else{  
			                return 0;  
			            }  
			        }             
			    });  
			}else if(type==7){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getUpdatetime().after(problem2.getUpdatetime())){  
			                return -1;  
			            }else if(problem1.getUpdatetime().before(problem2.getUpdatetime())){  
			                return 1;  
			            }else{  
			                return 0;  
			            }  
			        }             
			    });  
			}
			request.setAttribute("itemsid", id);
			request.setAttribute("actionnumber", actionnumber);
			request.setAttribute("problemnumber", problemnumber);
			request.setAttribute("list", list);
			list=null;

		}
			return "project2";
		}
		//p3
		if(action.equals("p3")){
			//升序
			if(order.equals("asc")){
				request.setAttribute("order", "desc");
				List<SimpleProblemVo> list =(List<SimpleProblemVo>) session.getAttribute("project3");
			
			//根据编号排序
			if(type==1){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getId()>problem2.getId()){  
			                return 1;  
			            }else if(problem1.getId()==problem2.getId()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据类型排序
			else if(type==2){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getType()>problem2.getType()){  
			                return 1;  
			            }else if(problem1.getType()==problem2.getType()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据状态排序
			else if(type==3){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getState()>problem2.getState()){  
			                return 1;  
			            }else if(problem1.getState()==problem2.getState()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
				//根据优先级排序
			}else if(type==4){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getPriority()>problem2.getPriority()){  
			                return 1;  
			            }else if(problem1.getPriority()==problem2.getPriority()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据指派人排序
			else if(type==5){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;
			        	if(problem2.getHandlerName()==null){
			        		return 1;
			        	}else if(problem1.getHandlerName()==null){
			            	return -1;
			            }
			        	else if(problem2.getHandlerName()!=null&&problem1.getHandlerName()!=null&&problem1.getHandlerName().charAt(0)>problem2.getHandlerName().charAt(0)){  
			                return 1;  
			            }else if(problem2.getHandlerName()!=null&&problem1.getHandlerName()!=null&&problem1.getHandlerName().charAt(0)==problem2.getHandlerName().charAt(0)){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据创建时间排序
			else if(type==6){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getCreatetime().after(problem2.getCreatetime())){  
			                return 1;  
			            }else if(problem1.getCreatetime().before(problem2.getCreatetime())){  
			                return -1;  
			            }else{  
			                return 0;  
			            }  
			        }             
			    });  
			}
			else if(type==7){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getUpdatetime().after(problem2.getUpdatetime())){  
			                return 1;  
			            }else if(problem1.getUpdatetime().before(problem2.getUpdatetime())){  
			                return -1;  
			            }else{  
			                return 0;  
			            }  
			        }             
			    });  
			}
			request.setAttribute("itemsid", id);
			request.setAttribute("actionnumber", actionnumber);
			request.setAttribute("problemnumber", problemnumber);
			
			request.setAttribute("list", list);
			list=null;
			return "project2";
		}
			//降序
			else{
			request.setAttribute("order", "asc");
			List<SimpleProblemVo> list =(List<SimpleProblemVo>) session.getAttribute("project3");
			//根据编号排序
			if(type==1){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getId()<problem2.getId()){  
			                return 1;  
			            }else if(problem1.getId()==problem2.getId()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据类型排序
			else if(type==2){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getType()<problem2.getType()){  
			                return 1;  
			            }else if(problem1.getType()==problem2.getType()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据状态排序
			else if(type==3){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getState()<problem2.getState()){  
			                return 1;  
			            }else if(problem1.getState()==problem2.getState()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
				//根据优先级排序
			}else if(type==4){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getPriority()<problem2.getPriority()){  
			                return 1;  
			            }else if(problem1.getPriority()==problem2.getPriority()){  
			                return 0;  
			            }else{  
			                return -1;  
			            }  
			        }             
			    });  
			}
			//根据指派人排序
			else if(type==5){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;
			        	if(problem2.getHandlerName()==null){
			        		return -1;
			        	}else if(problem1.getHandlerName()==null){
			            	return 1;
			            }
			        	else if(problem2.getHandlerName()!=null&&problem1.getHandlerName()!=null&&problem1.getHandlerName().charAt(0)<problem2.getHandlerName().charAt(0)){  
			                return 1;  
			            }else if(problem2.getHandlerName()!=null&&problem1.getHandlerName()!=null&&problem1.getHandlerName().charAt(0)==problem2.getHandlerName().charAt(0)){  
			                return 0;  
			            }else{  
			                return 1;  
			            }  
			        }             
			    });  
			}
			//根据创建时间排序
			else if(type==6){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getCreatetime().after(problem2.getCreatetime())){  
			                return -1;  
			            }else if(problem1.getCreatetime().before(problem2.getCreatetime())){  
			                return 1;  
			            }else{  
			                return 0;  
			            }  
			        }             
			    });  
			}else if(type==7){
				Collections.sort(list, new Comparator(){  
			        public int compare(Object o1, Object o2) {  
			        	SimpleProblemVo problem1=(SimpleProblemVo)o1;  
			        	SimpleProblemVo problem2=(SimpleProblemVo)o2;  
			            if(problem1.getUpdatetime().after(problem2.getUpdatetime())){  
			                return -1;  
			            }else if(problem1.getUpdatetime().before(problem2.getUpdatetime())){  
			                return 1;  
			            }else{  
			                return 0;  
			            }  
			        }             
			    });  
			}
			request.setAttribute("itemsid", id);
			request.setAttribute("actionnumber", actionnumber);
			request.setAttribute("problemnumber", problemnumber);
			request.setAttribute("list", list);
			list=null;
			
			
		}
	
			return "project3";
		}
		else {
			System.out.println("#");
			return "#";
		}
				
		
	}
	
	@RequestMapping(value="addmember",produces="application/json;charset=UTF-8")
	public @ResponseBody String  addMember(HttpSession session,@RequestParam("itemsid")int itemsid,
			@RequestParam("email")String join_user_email){
		JSONObject json=new JSONObject();
		User user =userService.getUserByEmail(join_user_email);//根据传入的email查到对应的用户信息
		User user1=(User) session.getAttribute(Constant.user.name());//得到当前登录用户的信息
		List<JoinMumber> list=userService.getJoinedMumber(itemsid);
		boolean flag=false;
		if(user!=null&&user.getEmail()!=null){
			for(JoinMumber jm:list){
				if(jm.getId()==user.getId()){
					flag=true;
					break;
				}
			}
			System.out.println(flag);
			if(flag||user.getId()==user1.getId()){
				json.put("result", "2");
				System.out.println(json.toJSONString());
				return json.toJSONString();
			}else{
				json.put("status", "正常");
				json.put("username", user.getUsername());
				json.put("email", user.getEmail());
					itemsService.addNumberService(itemsid, user.getId(), 0);
					json.put("result", "1");
					System.out.println(json.toJSONString());
					return json.toJSONString();
				
			}
			
		}else{
			json.put("result", "0"); 
			System.out.println(json.toJSONString());
			return json.toJSONString();
		}

		
	}
	
	@RequestMapping(value="getpage",produces="application/json;charset=UTF-8")
	public String Page(HttpSession session,HttpServletRequest request,int page){
		User user=(User) session.getAttribute(Constant.user.name());
		List<ItemsListVo> items=itemsService.getItemsListPage(user.getId(), "1",8*(page-1),page*8,request);
		int count =itemsService.countUserItems(user.getId(), "1");
		JSONObject json=new JSONObject();
		json.put("items", items);
		json.put("pagenumber", count);
		return json.toJSONString();
		
	}
	
}
