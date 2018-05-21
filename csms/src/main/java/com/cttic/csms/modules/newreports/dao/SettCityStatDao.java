/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.newreports.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import java.util.List;

import com.cttic.csms.modules.newreports.entity.SettCityStat;

/**
 * 月结算报表DAO接口
 * @author aryo
 * @version 2017-03-07
 */
@MyBatisDao
public interface SettCityStatDao extends CrudDao<SettCityStat> {

	List<SettCityStat> findAllList();
	List<SettCityStat> cityCodeCityViewChart(SettCityStat settCityStat);
	
}