/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.reports.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cttic.csms.modules.reports.entity.SettStatReport;

/**
 * 结算报表展示DAO接口
 * @author wanglk
 * @version 2016-12-21
 */
@MyBatisDao
public interface SettStatReportDao extends CrudDao<SettStatReport> {

	List<SettStatReport> orgCodeViewChart(SettStatReport settStatReport);

	List<SettStatReport> settTypeViewChart(SettStatReport settStatReport);

	List<SettStatReport> stMViewChart(SettStatReport settStatReport);

	List<SettStatReport> ocMViewChart(SettStatReport settStatReport);

	List<SettStatReport> orgCodeSumViewChart(SettStatReport settStatReport);

	List<HashMap<String, String>> findSettTypeList(SettStatReport settStatReport);

	List<HashMap<String, String>> findOrgCodeList(SettStatReport settStatReport);

	SettStatReport settStatReportInProvSum(SettStatReport settStatReport);

	SettStatReport settStatReportOutProvSum(SettStatReport settStatReport);
	
}