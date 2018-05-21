/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.cash.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.csms.modules.cash.entity.CashPayPeriodRecord;
import com.cttic.csms.modules.cash.entity.CashProvisions;
import com.cttic.csms.modules.cash.dao.CashPayPeriodRecordDao;

/**
 * 备付金缴存周期变更Service
 * @author aryo
 * @version 2016-11-25
 */
@Service
@Transactional(readOnly = true)
public class CashPayPeriodRecordService extends CrudService<CashPayPeriodRecordDao, CashPayPeriodRecord> {
    
	/**
	 * 持久层对象
	 */
	@Autowired
	protected CashPayPeriodRecordDao cashPayPeriodRecordDao;
	
	public CashPayPeriodRecord get(String id) {
		return super.get(id);
	}
	
	public List<CashPayPeriodRecord> findList(CashPayPeriodRecord cashPayPeriodRecord) {
		return super.findList(cashPayPeriodRecord);
	}
	
	public Page<CashPayPeriodRecord> findPage(Page<CashPayPeriodRecord> page, CashPayPeriodRecord cashPayPeriodRecord) {
		return super.findPage(page, cashPayPeriodRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(CashPayPeriodRecord cashPayPeriodRecord) {
		super.save(cashPayPeriodRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(CashPayPeriodRecord cashPayPeriodRecord) {
		super.delete(cashPayPeriodRecord);
	}

	@Transactional(readOnly = false)
	public void update(CashPayPeriodRecord cashPayPeriodRecord) {
		cashPayPeriodRecordDao.update(cashPayPeriodRecord);
		
	}

	public CashPayPeriodRecord findLastSuccessRecord(String provisionsId) {
		
		return cashPayPeriodRecordDao.findLastSuccessRecord(provisionsId);
	}

	public CashProvisions getCashProvisionsByUserId(String userId) {
		// TODO Auto-generated method stub
		return cashPayPeriodRecordDao.getCashProvisionsByUserId(userId);
	}

	
}