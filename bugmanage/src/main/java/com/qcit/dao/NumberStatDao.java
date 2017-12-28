package com.qcit.dao;

import org.apache.ibatis.annotations.Param;

import com.qcit.model.IndexNumberStat;

public interface NumberStatDao {
public IndexNumberStat getIndexNumberStat(@Param("id")int uid);
	
}
