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
import com.cttic.csms.modules.newreports.entity.SettProvDaily;
import com.cttic.csms.modules.newreports.dao.SettProvDailyDao;

/**
 * 跨省日统计报表Service
 * @author aryo
 * @version 2017-03-07
 */
@Service
@Transactional(readOnly = true)
public class SettProvDailyService extends CrudService<SettProvDailyDao, SettProvDaily> {

	@Autowired
	private SettProvDailyDao settProvDailyDao;
	
	public SettProvDaily get(String id) {
		return super.get(id);
	}
	
	public List<SettProvDaily> findList(SettProvDaily settProvDaily) {
		return super.findList(settProvDaily);
	}
	
	public List<SettProvDaily> billCodeSumProvViewChart(SettProvDaily settProvDaily){
		return settProvDailyDao.billCodeSumProvViewChart(settProvDaily);
	}
	
	List<SettProvDaily> issueCodeProvViewChart(SettProvDaily settProvDaily){
		return settProvDailyDao.issueCodeProvViewChart(settProvDaily);
	}
	public Page<SettProvDaily> findPage(Page<SettProvDaily> page, SettProvDaily settProvDaily) {
		return super.findPage(page, settProvDaily);
	}
	
	@Transactional(readOnly = false)
	public void save(SettProvDaily settProvDaily) {
		super.save(settProvDaily);
	}
	
	@Transactional(readOnly = false)
	public void delete(SettProvDaily settProvDaily) {
		super.delete(settProvDaily);
	}

	public List<SettProvDaily> findAllList() {
		// TODO Auto-generated method stub
		return settProvDailyDao.findAllList();
	}
	//add sum
	public SettProvDaily settProvDetailSum(SettProvDaily settProvDaily) {
		settProvDaily.getSqlMap().put("dsf",dataScopeFilter(settProvDaily.getCurrentUser(),"o",""));
		return settProvDailyDao.settProvStatDetailSum(settProvDaily);
	}
	
}