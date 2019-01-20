/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.newreports.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import java.util.List;

import com.cttic.csms.modules.newreports.entity.SettCityDaily;

/**
 * 省内日统计报表DAO接口
 * @author aryo
 * @version 2017-03-07
 */
@MyBatisDao
public interface SettCityDailyDao extends CrudDao<SettCityDaily> {

	List<SettCityDaily> findAllList(SettCityDaily settCityDaily);
	List<SettCityDaily> issueCityViewChart(SettCityDaily settCityDaily);	
	List<SettCityDaily> billCityViewChart(SettCityDaily settCityDaily);
	List<SettCityDaily> issueObjectMonthLineChart(SettCityDaily settCityDaily);
	List<SettCityDaily> billCodeProvLineChart(SettCityDaily settCityDaily);
	SettCityDaily settCityDailySum(SettCityDaily settCityDaily);

	List<SettCityDaily> findMonthList(SettCityDaily paramSettCityDaily);
	SettCityDaily settCityMonthlySum(SettCityDaily paramSettCityDaily);
	
}