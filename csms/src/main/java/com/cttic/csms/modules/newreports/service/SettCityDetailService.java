/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.newreports.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cttic.csms.modules.newreports.dao.SettCityDetailDao;
import com.cttic.csms.modules.newreports.entity.SettCityDetail;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;

/**
 * 省内结算详单展示Service
 * @author aryo
 * @version 2017-03-07
 */
@Service
@Transactional(readOnly = true)
public class SettCityDetailService extends CrudService<SettCityDetailDao, SettCityDetail> {

	@Autowired
	private SettCityDetailDao settCityDetailDao;

	@Override
	public SettCityDetail get(String id) {
		return super.get(id);
	}

	@Override
	public List<SettCityDetail> findList(SettCityDetail settCityDetail) {
		//return super.findList(settCityDetail);
		settCityDetail.getSqlMap().put("dsf", dataScopeFilter(settCityDetail.getCurrentUser(), "o", ""));
		return super.findList(settCityDetail);
	}

	@Override
	public Page<SettCityDetail> findPage(Page<SettCityDetail> page, SettCityDetail settCityDetail) {
		//return super.findPage(page, settCityDetail);
		settCityDetail.getSqlMap().put("dsf", dataScopeFilter(settCityDetail.getCurrentUser(), "o", ""));
		return super.findPage(page, settCityDetail);
	}

	@Override
	@Transactional(readOnly = false)
	public void save(SettCityDetail settCityDetail) {
		super.save(settCityDetail);
	}

	@Override
	@Transactional(readOnly = false)
	public void delete(SettCityDetail settCityDetail) {
		super.delete(settCityDetail);
	}

	public List<SettCityDetail> findAllList() {
		// TODO Auto-generated method stub
		return settCityDetailDao.findAllList();
	}

	//add sum 2017/10/10
	public SettCityDetail getSum(SettCityDetail settCityDetail) {
		//return settCityDetailDao.getSum(settCityDetail);
		settCityDetail.getSqlMap().put("dsf", dataScopeFilter(settCityDetail.getCurrentUser(), "o", ""));
		return settCityDetailDao.getSum(settCityDetail);
	}
}