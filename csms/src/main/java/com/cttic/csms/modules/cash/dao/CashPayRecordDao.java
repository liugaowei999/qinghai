package com.cttic.csms.modules.cash.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cttic.csms.modules.cash.entity.CashPayRecord;

/**
 * 备付金缴存相关功能DAO接口
 * @author ambitious
 * @version 2016-11-24
 */
@MyBatisDao
public interface CashPayRecordDao extends CrudDao<CashPayRecord> {
	
}