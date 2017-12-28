package com.qcit.service.impl;

import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.qcit.dao.ItemsDao;
import com.qcit.dao.UserDao;
import com.qcit.model.ItemsListVo;
import com.qcit.model.ItemsPo;
import com.qcit.model.ProjectVo;
import com.qcit.model.SimpleProblemVo;
import com.qcit.service.ItemsService;
import com.qcit.util.DateUtil;

@Service
public class ItemsServiceImpl implements ItemsService {
	Logger logger =Logger.getLogger(ItemsService.class);
	@Autowired
	ItemsDao itemsDao;
	@Autowired
	UserDao userDao;
	 @Transactional 
	public List<ItemsListVo> getItemsListPage(int id, String ishidden,int start,int end,HttpServletRequest request) {
		List<ItemsListVo> list=itemsDao.getItemsListVoPage(id, ishidden,start,end);
		logger.debug("index页面得到的项目数据:"+list);
		return list;
	}

	 @Transactional 
	public List<ItemsListVo> getItemsList(int id, String ishidden,HttpServletRequest request) {
		List<ItemsListVo> list=itemsDao.getItemsListVo(id, ishidden);
		logger.debug("index页面得到的项目数据:"+list);
		return list;
	}
	 
	 @Transactional
	public int setItemsPicPath(String name, String description, String picpath, int creater, int owner) {
		ItemsPo items = new ItemsPo();
		items.setCreater(String.valueOf(creater));
		items.setOwner(String.valueOf(owner));
		items.setName(name);
		items.setDescription(description);
		items.setItemspic(picpath);
		itemsDao.setItems(items);
		return items.getId();
	}
	 @Transactional
	public String getItemsCreateDate(int id) {
		 Date date=itemsDao.getItemsDate(id);
		 String realdate =DateUtil.getDateAfterFormat(date);
		return realdate;
	}
	 @Transactional  
	public void changeHiddenState(int id, int hidden) {
		itemsDao.updateItemsHidden(id, hidden);
		
	}
	 @Transactional  
	public void changeExistState(int id, int exist) {
		itemsDao.updateItemsExist(id, exist);
		
	}
	 @Transactional  
	public int countUserItems(int id, String ishidden) {
		
		return itemsDao.getItemsListVoCount(id, ishidden);
	}
	 @Transactional  
	public ProjectVo showProject(int id,int user_id) {
		
		return itemsDao.getProjectStatisticsById(id,user_id);
	}
@Transactional
	public List<SimpleProblemVo> showActionProblem(int itemid) {

		return itemsDao.getProblemByItemIdAndIsActiveProblem(itemid);
	}

public List<SimpleProblemVo> showAllProblem(int itemid) {

	return itemsDao.getProblemByItemIdAll(itemid);
}

public ItemsPo getItemsPo(int itemid) {
	
	return itemsDao.getItems(itemid);
}


public void addNumberService(int pid, int uid,  int isadmin) {
	itemsDao.setParticipant(pid, uid, isadmin);
	
}


public void updateNewItems(int itemsid,String name, String description) {
	itemsDao.updateItems(itemsid, name, description);
	
}


public List<SimpleProblemVo> showMyProblem(int itemid, int uid) {
	
	return itemsDao.getProblemByItemIdAndIsMyProblem(itemid, uid);
}


public List<SimpleProblemVo> showProblemToMe(int itemid, int uid) {
	
	return itemsDao.getProblemToMeByItemsIdAndUserId(itemid, uid);
}

@Override
public List<SimpleProblemVo> showMyHandlerProblem(int itemid, int uid) {
	
	return itemsDao.getMyHandlerProblemByItemsIdAndUserId(itemid, uid);
}

}
