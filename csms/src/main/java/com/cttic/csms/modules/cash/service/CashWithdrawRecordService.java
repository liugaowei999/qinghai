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
import com.cttic.csms.modules.cash.entity.CashProvisions;
import com.cttic.csms.modules.cash.entity.CashWithdrawRecord;
import com.cttic.csms.modules.cash.dao.CashWithdrawRecordDao;

/**
 * 备付金提现记录Service
 * @author aryo
 * @version 2016-11-24
 */
@Service
@Transactional(readOnly = true)
public class CashWithdrawRecordService extends CrudService<CashWithdrawRecordDao, CashWithdrawRecord> {

	/**
	 * 持久层对象
	 */
	@Autowired
	protected CashWithdrawRecordDao cashWithdrawRecordDao;
	
	public CashWithdrawRecord get(String id) {
		return super.get(id);
	}
	
	public List<CashWithdrawRecord> findList(CashWithdrawRecord cashWithdrawRecord) {
		return super.findList(cashWithdrawRecord);
	}
	
	public Page<CashWithdrawRecord> findPage(Page<CashWithdrawRecord> page, CashWithdrawRecord cashWithdrawRecord) {
		return super.findPage(page, cashWithdrawRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(CashWithdrawRecord cashWithdrawRecord) {
		super.save(cashWithdrawRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(CashWithdrawRecord cashWithdrawRecord) {
		super.delete(cashWithdrawRecord);
	}

	@Transactional(readOnly = false)
	public void cashWithdrawApplySave(CashWithdrawRecord cashWithdrawRecord, CashProvisions cashProvisions) {
		super.save(cashWithdrawRecord);
		cashProvisions.preUpdate();
		cashWithdrawRecordDao.updateCashProvisions(cashProvisions);
	}

	public void cashWithdrawExamineSave(CashWithdrawRecord cashWithdrawRecord) {
		cashWithdrawRecord.preUpdate();
		cashWithdrawRecordDao.updateWithdrawState(cashWithdrawRecord);
		
	}
	
}