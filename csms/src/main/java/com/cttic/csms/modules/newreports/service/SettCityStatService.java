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
import com.cttic.csms.modules.newreports.entity.SettCityStat;
import com.cttic.csms.modules.newreports.dao.SettCityStatDao;

/**
 * 月结算报表Service
 * @author aryo
 * @version 2017-03-07
 */
@Service
@Transactional(readOnly = true)
public class SettCityStatService extends CrudService<SettCityStatDao, SettCityStat> {

	@Autowired
	private SettCityStatDao settCityStatDao;
	public SettCityStat get(String id) {
		return super.get(id);
	}
	
	public List<SettCityStat> findList(SettCityStat settCityStat) {
		settCityStat.getSqlMap().put("dsf", dataScopeFilter(settCityStat.getCurrentUser(), "o", ""));
		return super.findList(settCityStat);
	}
	public List<SettCityStat> cityCodeCityViewChart(SettCityStat settCityStat){
		settCityStat.getSqlMap().put("dsf", dataScopeFilter(settCityStat.getCurrentUser(), "o", ""));
		return settCityStatDao.cityCodeCityViewChart(settCityStat);
	}
	
	public Page<SettCityStat> findPage(Page<SettCityStat> page, SettCityStat settCityStat) {
		settCityStat.getSqlMap().put("dsf", dataScopeFilter(settCityStat.getCurrentUser(), "o", ""));
		return super.findPage(page, settCityStat);
	}
	
	@Transactional(readOnly = false)
	public void save(SettCityStat settCityStat) {
		super.save(settCityStat);
	}
	
	@Transactional(readOnly = false)
	public void delete(SettCityStat settCityStat) {
		super.delete(settCityStat);
	}

	public List<SettCityStat> findAllList() {
		// TODO Auto-generated method stub
		return settCityStatDao.findAllList();
	}
	
}