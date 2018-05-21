/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.dao;

import java.util.Map;

import com.cttic.csms.modules.settlementfront.entity.SettProcStat;
import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

/**
 * 前台出账DAO接口
 * @author zhouhong
 * @version 2017-05-03
 */
@MyBatisDao
public interface SettProcStatDao extends CrudDao<SettProcStat> {
	public void executeProc(Map paramMap);
}