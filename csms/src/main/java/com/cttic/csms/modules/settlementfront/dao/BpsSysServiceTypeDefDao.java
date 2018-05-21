/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cttic.csms.modules.settlementfront.entity.BpsSysServiceTypeDef;

/**
 * 业务类型定义DAO接口
 * @author aryo
 * @version 2016-12-03
 */
@MyBatisDao
public interface BpsSysServiceTypeDefDao extends CrudDao<BpsSysServiceTypeDef> {
	
}