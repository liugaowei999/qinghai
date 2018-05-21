/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.sysframe.timetask.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cttic.sysframe.timetask.entity.SysTimetaskLog;

/**
 * 定时任务日志管理DAO接口
 * @author dener
 * @version 2016-12-06
 */
@MyBatisDao
public interface SysTimetaskLogDao extends CrudDao<SysTimetaskLog> {
	
}