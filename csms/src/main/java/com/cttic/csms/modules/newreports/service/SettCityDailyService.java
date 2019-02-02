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
import com.cttic.csms.modules.newreports.entity.SettCityDaily;
import com.cttic.csms.modules.newreports.dao.SettCityDailyDao;

/**
 * 省内日统计报表Service
 * @author aryo
 * @version 2017-03-07
 */
@Service
@Transactional(readOnly = true)
public class SettCityDailyService extends CrudService<SettCityDailyDao, SettCityDaily> {

	@Autowired
	private SettCityDailyDao settCityDailyDao;
	
	public SettCityDaily get(String id) {
		return super.get(id);
	}
	
	public List<SettCityDaily> findList(SettCityDaily settCityDaily) {
		settCityDaily.getSqlMap().put("dsf", dataScopeFilter(settCityDaily.getCurrentUser(), "o", ""));
		return super.findList(settCityDaily);
	}
	
	public Page<SettCityDaily> findPage(Page<SettCityDaily> page, SettCityDaily settCityDaily) {
		settCityDaily.getSqlMap().put("dsf", dataScopeFilter(settCityDaily.getCurrentUser(), "o", ""));
		return super.findPage(page, settCityDaily);
	}
	
	public List<SettCityDaily> issueCityViewChart(SettCityDaily settCityDaily){
		settCityDaily.getSqlMap().put("dsf", dataScopeFilter(settCityDaily.getCurrentUser(), "o", ""));
		return settCityDailyDao.issueCityViewChart(settCityDaily);
	}
	
	public List<SettCityDaily> billCityViewChart(SettCityDaily settCityDaily){
		settCityDaily.getSqlMap().put("dsf", dataScopeFilter(settCityDaily.getCurrentUser(), "o", ""));
		return settCityDailyDao.billCityViewChart(settCityDaily);
	}
	
	public List<SettCityDaily> issueObjectMonthLineChart(SettCityDaily settCityDaily){
		settCityDaily.getSqlMap().put("dsf", dataScopeFilter(settCityDaily.getCurrentUser(), "o", ""));
		return settCityDailyDao.issueObjectMonthLineChart(settCityDaily);
	}
	
	public List<SettCityDaily> billCodeProvLineChart(SettCityDaily settCityDaily){
		settCityDaily.getSqlMap().put("dsf", dataScopeFilter(settCityDaily.getCurrentUser(), "o", ""));
		return settCityDailyDao.billCodeProvLineChart(settCityDaily);
	}
	
	@Transactional(readOnly = false)
	public void save(SettCityDaily settCityDaily) {
		super.save(settCityDaily);
	}
	
	@Transactional(readOnly = false)
	public void delete(SettCityDaily settCityDaily) {
		super.delete(settCityDaily);
	}

	public List<SettCityDaily> findAllList(SettCityDaily settCityDaily) {
		// TODO Auto-generated method stub
		settCityDaily.getSqlMap().put("dsf", dataScopeFilter(settCityDaily.getCurrentUser(), "o", ""));
		return settCityDailyDao.findAllList(settCityDaily);
	}
	//add sum
	public SettCityDaily settCityDailySum(SettCityDaily settCityDaily) {
		settCityDaily.getSqlMap().put("dsf",dataScopeFilter(settCityDaily.getCurrentUser(),"o",""));
		return settCityDailyDao.settCityDailySum(settCityDaily);
	}

	public SettCityDaily settCityMonthlySum(SettCityDaily settCityDaily)
	{
		settCityDaily.getSqlMap().put("dsf", dataScopeFilter(settCityDaily.getCurrentUser(), "o", ""));
		return this.settCityDailyDao.settCityMonthlySum(settCityDaily);
	}

	public List<SettCityDaily> findMonthList(SettCityDaily settCityDaily)
	{
		settCityDaily.getSqlMap().put("dsf", dataScopeFilter(settCityDaily.getCurrentUser(), "o", ""));
		return this.settCityDailyDao.findMonthList(settCityDaily);
	}

	public SettCityDaily settCityDailySumByArea(SettCityDaily settCityDaily) {
		settCityDaily.getSqlMap().put("dsf",dataScopeFilter(settCityDaily.getCurrentUser(),"o",""));
		return settCityDailyDao.settCityDailySumByArea(settCityDaily);
	}


	public Page<SettCityDaily> findPageByArea(Page<SettCityDaily> page, SettCityDaily settCityDaily) {
		settCityDaily.getSqlMap().put("dsf", dataScopeFilter(settCityDaily.getCurrentUser(), "o", ""));
		settCityDaily.setPage(page);
		page.setList(settCityDailyDao.findListByArea(settCityDaily));
		return page;
	}

	public List<SettCityDaily> findAllListByArea(SettCityDaily settCityDaily) {
		return settCityDailyDao.findListByArea(settCityDaily);
	}
}