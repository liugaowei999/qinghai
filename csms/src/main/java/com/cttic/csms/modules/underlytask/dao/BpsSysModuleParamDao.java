package com.cttic.csms.modules.underlytask.dao;

import com.cttic.csms.modules.underlytask.entity.BpsSysModuleParam;
import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

/**
 * 对后台任务参数进行查询和修改DAO接口
 * @author ambitious
 * @version 2016-11-12
 */
@MyBatisDao
public interface BpsSysModuleParamDao extends CrudDao<BpsSysModuleParam> {
	
}
