package com.qcit.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qcit.dao.NumberStatDao;
import com.qcit.model.IndexNumberStat;
import com.qcit.service.NumberStatService;

@Service
public class NumberStatServiceImpl implements NumberStatService{
@Autowired
private NumberStatDao numberDao;
	@Override
	public IndexNumberStat getIndexNumberStat(int id) {
		
		return numberDao.getIndexNumberStat(id);
	}

}
