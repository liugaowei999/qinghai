/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.reports.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import java.util.HashMap;
import java.util.List;

import com.cttic.csms.modules.reports.entity.SettCityStatDetail;

/**
 * 省内结算报表展示DAO接口
 * @author wanglk
 * @version 2016-12-22
 */
@MyBatisDao
public interface SettCityStatDetailDao extends CrudDao<SettCityStatDetail> {

	List<SettCityStatDetail> billCodeViewChart(SettCityStatDetail settCityStatDetail);

	List<SettCityStatDetail> issueCodeViewChart(SettCityStatDetail settCityStatDetail);

	List<SettCityStatDetail> issueCodeLineChart(SettCityStatDetail settCityStatDetail);

	List<SettCityStatDetail> billCodeLineChart(SettCityStatDetail settCityStatDetail);

	List<SettCityStatDetail> billCodeSumViewChart(SettCityStatDetail settCityStatDetail);

	List<HashMap<String, String>> findBillOrgCode(SettCityStatDetail settCityStatDetail);

	List<HashMap<String, String>> findIssueOrgCode(SettCityStatDetail settCityStatDetail);

	SettCityStatDetail settCityStatDetailSum(SettCityStatDetail settCityStatDetail);
	
}