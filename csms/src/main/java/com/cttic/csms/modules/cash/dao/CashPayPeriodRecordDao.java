/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.cash.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cttic.csms.modules.cash.entity.CashPayPeriodRecord;
import com.cttic.csms.modules.cash.entity.CashProvisions;

/**
 * 备付金缴存周期变更DAO接口
 * @author aryo
 * @version 2016-11-25
 */
@MyBatisDao
public interface CashPayPeriodRecordDao extends CrudDao<CashPayPeriodRecord> {

	void cancelPeriod(CashPayPeriodRecord cashPayPeriodRecord);

	CashPayPeriodRecord findLastSuccessRecord(String provisionsId);

	CashProvisions getCashProvisionsByUserId(String userId);
	
}