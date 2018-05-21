/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.cash.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import com.cttic.csms.modules.cash.entity.CashProvisions;

/**
 * 备付金开户DAO接口
 * @author wanglk
 * @version 2016-11-24
 */
@MyBatisDao
public interface CashProvisionsDao extends CrudDao<CashProvisions> {
	int updateAmount(CashProvisions cashProvisions);

	int updateAfterPay(CashProvisions cp);
}