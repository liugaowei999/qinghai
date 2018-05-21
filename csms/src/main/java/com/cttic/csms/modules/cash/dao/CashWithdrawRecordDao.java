/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.cash.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cttic.csms.modules.cash.entity.CashProvisions;
import com.cttic.csms.modules.cash.entity.CashWithdrawRecord;

/**
 * 备付金提现记录DAO接口
 * @author aryo
 * @version 2016-11-24
 */
@MyBatisDao
public interface CashWithdrawRecordDao extends CrudDao<CashWithdrawRecord> {

	void updateCashProvisions(CashProvisions cashProvisions);

	void updateWithdrawState(CashWithdrawRecord cashWithdrawRecord);
	
}