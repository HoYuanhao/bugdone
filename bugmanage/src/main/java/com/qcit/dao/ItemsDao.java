package com.qcit.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qcit.model.ItemsListVo;
import com.qcit.model.ItemsPo;
import com.qcit.model.ProblemCount;
import com.qcit.model.ProjectVo;
import com.qcit.model.SimpleProblemVo;

public interface ItemsDao {
	public List<ItemsListVo> getItemsListVo(@Param("id")int id,@Param("ishidden")String ishidden);
	
	public List<ItemsListVo> getItemsListVoPage(@Param("id")int id,@Param("ishidden")String ishidden,@Param("start")int start,@Param("end")int end);
	
	public List<ProblemCount> getMyProblemNumberByUid(@Param("pid")int pid,@Param("uid") int uid);
	
	public List<ProblemCount> getNeedSolveProblemNumberByUid(@Param("pid")int pid,@Param("uid") int uid);
	
	public int setItems(ItemsPo itemspo);
	
	public Date getItemsDate(@Param("id") int id);
	
	public void updateItemsHidden(@Param("id")int id,@Param("hidden")int hidden);
	
	public void updateItemsExist(@Param("id")int id,@Param("exist")int exist);
	
	public String getProjectPicPathById(@Param("id")int id);
	
	public int getItemsListVoCount(@Param("id")int id,@Param("ishidden")String ishidden);
	
	public ProjectVo getProjectStatisticsById(@Param("id")int id,@Param("user_id")int user_id);
	
	public List<SimpleProblemVo> getProblemByItemIdAndIsActiveProblem(@Param("id")int itemid);

    public ItemsPo getItems(@Param("id")int itemid);
   
	public List<SimpleProblemVo> getProblemByItemIdAll(@Param("id")int itemid);
    
	public void setParticipant(@Param("pid")int pid,@Param("uid")int uid,@Param("isadmin")int isadmin);
	
	public void updateItems(@Param("id")int id,@Param("name")String name,@Param("description") String description);
	
	public List<SimpleProblemVo> getProblemByItemIdAndIsMyProblem(@Param("id")int itemid,@Param("uid") int uid);
	
	public List<SimpleProblemVo> getProblemToMeByItemsIdAndUserId(@Param("id")int itemid,@Param("uid") int uid);
	
	public List<SimpleProblemVo> getMyHandlerProblemByItemsIdAndUserId(@Param("id")int itemid,@Param("uid") int uid);
	
}
