/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.underlytask.dao;

import com.cttic.csms.modules.underlytask.entity.BpsModuleLog;
import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

/**
 * 对日志表记录进行查询DAO接口
 * @author underlytask
 * @version 2016-11-12
 */
@MyBatisDao
public interface BpsModuleLogDao extends CrudDao<BpsModuleLog> {
	
}