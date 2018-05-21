/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.cash.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.csms.modules.cash.entity.SettAdDetail;
import com.cttic.csms.modules.cash.dao.SettAdDetailDao;

/**
 * 同步备付金账户金额--差错数据Service
 * @author wanglk
 * @version 2016-11-26
 */
@Service
@Transactional(readOnly = true)
public class SettAdDetailService extends CrudService<SettAdDetailDao, SettAdDetail> {
	@Autowired
	private SettAdDetailDao adDetailDao;
	
	public SettAdDetail get(String id) {
		return super.get(id);
	}
	
	public List<SettAdDetail> findList(SettAdDetail settAdDetail) {
		return super.findList(settAdDetail);
	}
	
	public Page<SettAdDetail> findPage(Page<SettAdDetail> page, SettAdDetail settAdDetail) {
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		settAdDetail.getSqlMap().put("dsf", dataScopeFilter(settAdDetail.getCurrentUser(), "o", ""));
		return super.findPage(page, settAdDetail);
	}
	
	@Transactional(readOnly = false)
	public void save(SettAdDetail settAdDetail) {
		super.save(settAdDetail);
	}
	
	@Transactional(readOnly = false)
	public void delete(SettAdDetail settAdDetail) {
		super.delete(settAdDetail);
	}

	public List<SettAdDetail> findListForSync(SettAdDetail settAdDetail) {
		List<SettAdDetail> adDetails = adDetailDao.findListForSync(settAdDetail);
		return adDetails;
	}
	
}