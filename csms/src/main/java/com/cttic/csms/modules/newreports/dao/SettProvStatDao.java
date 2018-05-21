/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.newreports.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import java.util.List;

import com.cttic.csms.modules.newreports.entity.SettProvStat;

/**
 * 跨省月结算报表DAO接口
 * @author aryo
 * @version 2017-03-07
 */
@MyBatisDao
public interface SettProvStatDao extends CrudDao<SettProvStat> {

	List<SettProvStat> findAllList();
	List<SettProvStat> provStatSumViewChart(SettProvStat settProvStat);
	List<SettProvStat> allYearLineChart(SettProvStat settProvStat);
	
}