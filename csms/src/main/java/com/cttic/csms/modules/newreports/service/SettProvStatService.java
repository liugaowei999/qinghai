/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.newreports.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.csms.modules.newreports.entity.SettProvStat;
import com.cttic.csms.modules.newreports.dao.SettProvStatDao;

/**
 * 跨省月结算报表Service
 * @author aryo
 * @version 2017-03-07
 */
@Service
@Transactional(readOnly = true)
public class SettProvStatService extends CrudService<SettProvStatDao, SettProvStat> {

	@Autowired
	private SettProvStatDao settProvStatDao;
	
	public SettProvStat get(String id) {
		return super.get(id);
	}
	
	public List<SettProvStat> findList(SettProvStat settProvStat) {
		return super.findList(settProvStat);
	}
	
	public List<SettProvStat> provStatSumViewChart(SettProvStat settProvStat){
		return settProvStatDao.provStatSumViewChart(settProvStat);
	}
	
	public List<SettProvStat> allYearLineChart(SettProvStat settProvStat){
		return settProvStatDao.allYearLineChart(settProvStat);
	}
	
	public Page<SettProvStat> findPage(Page<SettProvStat> page, SettProvStat settProvStat) {
		return super.findPage(page, settProvStat);
	}
	
	@Transactional(readOnly = false)
	public void save(SettProvStat settProvStat) {
		super.save(settProvStat);
	}
	
	@Transactional(readOnly = false)
	public void delete(SettProvStat settProvStat) {
		super.delete(settProvStat);
	}

	public List<SettProvStat> findAllList() {
		// TODO Auto-generated method stub
		return settProvStatDao.findAllList();
	}
	
}