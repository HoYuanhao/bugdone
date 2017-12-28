package com.qcit.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.qcit.model.ItemsListVo;
import com.qcit.model.ItemsPo;
import com.qcit.model.ProjectVo;
import com.qcit.model.SimpleProblemVo;

public interface ItemsService {
	public List<ItemsListVo> getItemsList(int id,String ishidden,HttpServletRequest request);
	
	public List<ItemsListVo> getItemsListPage(int id,String ishidden,int start,int end,HttpServletRequest request);
	
	public int setItemsPicPath(String name,String description,String picpath,int creater,int owner);
	
	public String getItemsCreateDate(int id);
	
	
	public void changeHiddenState(int id,int hidden);
	
	public void changeExistState(int id,int exist);
	
	public int countUserItems(int id,String ishidden);
	
	public ProjectVo showProject(int id,int user_id);
	
	public List<SimpleProblemVo> showActionProblem(int itemid);
	
	public List<SimpleProblemVo> showMyProblem(int itemid,int uid);
	
	public List<SimpleProblemVo> showAllProblem(int itemid);
	
	public ItemsPo getItemsPo(int itemid);
	
	public void addNumberService(int pid,int uid,int isadmin );
	
	public void updateNewItems(int itemsid,String name,String description);
	
	public List<SimpleProblemVo> showProblemToMe(int itemid,int uid);
	
	public List<SimpleProblemVo> showMyHandlerProblem(int itemid,int uid);
}
