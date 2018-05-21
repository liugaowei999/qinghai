/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.dao;

import com.cttic.csms.modules.settlementfront.entity.BpsFiletransLog;
import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

/**
 * 外围系统接口传输信息记录DAO接口
 * @author aryo
 * @version 2016-12-23
 */
@MyBatisDao
public interface BpsFiletransLogDao extends CrudDao<BpsFiletransLog> {
	
}