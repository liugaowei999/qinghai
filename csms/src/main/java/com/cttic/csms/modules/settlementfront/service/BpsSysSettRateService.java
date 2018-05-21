/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.csms.modules.settlementfront.entity.BpsSysSettRate;
import com.cttic.csms.modules.settlementfront.dao.BpsSysSettRateDao;

/**
 * 清算费率配置Service
 * @author aryo
 * @version 2016-12-03
 */
@Service
@Transactional(readOnly = true)
public class BpsSysSettRateService extends CrudService<BpsSysSettRateDao, BpsSysSettRate> {

	public BpsSysSettRate get(String id) {
		return super.get(id);
	}
	
	public List<BpsSysSettRate> findList(BpsSysSettRate bpsSysSettRate) {
		return super.findList(bpsSysSettRate);
	}
	
	public Page<BpsSysSettRate> findPage(Page<BpsSysSettRate> page, BpsSysSettRate bpsSysSettRate) {
		return super.findPage(page, bpsSysSettRate);
	}
	
	@Transactional(readOnly = false)
	public void save(BpsSysSettRate bpsSysSettRate) {
		super.save(bpsSysSettRate);
	}
	
	@Transactional(readOnly = false)
	public void delete(BpsSysSettRate bpsSysSettRate) {
		super.delete(bpsSysSettRate);
	}
	
}