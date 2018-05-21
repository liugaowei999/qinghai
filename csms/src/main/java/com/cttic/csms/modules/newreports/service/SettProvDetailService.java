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
import com.cttic.csms.modules.newreports.entity.SettProvDetail;
import com.cttic.csms.modules.newreports.dao.SettProvDetailDao;

/**
 * 跨省结算详单展示Service
 * @author aryo
 * @version 2017-03-07
 */
@Service
@Transactional(readOnly = true)
public class SettProvDetailService extends CrudService<SettProvDetailDao, SettProvDetail> {
	
	@Autowired
	private SettProvDetailDao settProvDetailDao;
	public SettProvDetail get(String id) {
		return super.get(id);
	}
	
	public List<SettProvDetail> findList(SettProvDetail settProvDetail) {
		return super.findList(settProvDetail);
	}
	public List<SettProvDetail> findAllList() {
		return settProvDetailDao.findAllList();
	}
	
	public Page<SettProvDetail> findPage(Page<SettProvDetail> page, SettProvDetail settProvDetail) {
		return super.findPage(page, settProvDetail);
	}
	
	
	@Transactional(readOnly = false)
	public void save(SettProvDetail settProvDetail) {
		super.save(settProvDetail);
	}
	
	@Transactional(readOnly = false)
	public void delete(SettProvDetail settProvDetail) {
		super.delete(settProvDetail);
	}

	//新增取合计
	public SettProvDetail getSum(SettProvDetail settProvDetail) {
		return settProvDetailDao.getSum(settProvDetail);
	}


}