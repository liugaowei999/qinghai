/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.underlytask.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cttic.csms.modules.underlytask.entity.BpsSysModule;

/**
 * 对后台任务处理情况进行查询和修改DAO接口
 * @author ambitious
 * @version 2016-11-12
 */
@MyBatisDao
public interface BpsSysModuleDao extends CrudDao<BpsSysModule> {
	
}