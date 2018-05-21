/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cttic.csms.modules.settlementfront.entity.DrBillDetail;

/**
 * 省内地市结算详单DAO接口
 * @author aryo
 * @version 2016-12-23
 */
@MyBatisDao
public interface DrBillDetailDao extends CrudDao<DrBillDetail> {
	
}