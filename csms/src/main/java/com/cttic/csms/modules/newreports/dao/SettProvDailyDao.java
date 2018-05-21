/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.newreports.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import java.util.List;

import com.cttic.csms.modules.newreports.entity.SettProvDaily;

/**
 * 跨省日统计报表DAO接口
 * @author aryo
 * @version 2017-03-07
 */
@MyBatisDao
public interface SettProvDailyDao extends CrudDao<SettProvDaily> {

	List<SettProvDaily> findAllList();
	List<SettProvDaily> billCodeSumProvViewChart(SettProvDaily settProvDaily);
	List<SettProvDaily> issueCodeProvViewChart(SettProvDaily settProvDaily);
	//add sum 2017/10/10
	SettProvDaily settProvStatDetailSum(SettProvDaily settProvDaily);
}