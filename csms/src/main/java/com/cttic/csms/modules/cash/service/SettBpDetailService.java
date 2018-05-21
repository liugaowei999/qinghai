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
import com.cttic.csms.modules.cash.entity.SettBpDetail;
import com.cttic.csms.modules.cash.dao.SettBpDetailDao;

/**
 * 同步备付金账户金额Service
 * @author wanglk
 * @version 2016-11-26
 */
@Service
@Transactional(readOnly = true)
public class SettBpDetailService extends CrudService<SettBpDetailDao, SettBpDetail> {
	
	@Autowired
	SettBpDetailDao dao;
	
	public SettBpDetail get(String id) {
		return super.get(id);
	}
	
	public List<SettBpDetail> findList(SettBpDetail settBpDetail) {
		return super.findList(settBpDetail);
	}
	
	public Page<SettBpDetail> findPage(Page<SettBpDetail> page, SettBpDetail settBpDetail) {
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		settBpDetail.getSqlMap().put("dsf", dataScopeFilter(settBpDetail.getCurrentUser(), "o", ""));
		return super.findPage(page, settBpDetail);
	}
	
	
	@Transactional(readOnly = false)
	public void save(SettBpDetail settBpDetail) {
		super.save(settBpDetail);
	}
	
	@Transactional(readOnly = false)
	public void delete(SettBpDetail settBpDetail) {
		super.delete(settBpDetail);
	}

	public List<SettBpDetail> findListForSync(SettBpDetail settBpDetail) {
		return dao.findListForSync(settBpDetail);
	}

	public long findSumForPay(SettBpDetail settBpDetail, String beginSettDate, String endSettDate) {
		return dao.findSumForPay(settBpDetail,beginSettDate,endSettDate);
	}
	
}