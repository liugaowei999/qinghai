/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.reports.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import java.util.HashMap;
import java.util.List;

import com.cttic.csms.modules.reports.entity.SettProvStatDetail;

/**
 * 跨省结算报表展示DAO接口
 * @author wanglk
 * @version 2016-12-22
 */
@MyBatisDao
public interface SettProvStatDetailDao extends CrudDao<SettProvStatDetail> {

	List<SettProvStatDetail> billCodeProvViewChart(SettProvStatDetail settProvStatDetail);

	List<SettProvStatDetail> issueCodeProvViewChart(SettProvStatDetail settProvStatDetail);

	List<SettProvStatDetail> issueCodeProvLineChart(SettProvStatDetail settProvStatDetail);

	List<SettProvStatDetail> billCodeProvLineChart(SettProvStatDetail settProvStatDetail);

	List<SettProvStatDetail> billCodeSumProvViewChart(SettProvStatDetail settProvStatDetail);

	List<HashMap<String, String>> findBillOrgCode(SettProvStatDetail settProvStatDetail);

	List<HashMap<String, String>> findIssueOrgCode(SettProvStatDetail settProvStatDetail);

	SettProvStatDetail settProvStatDetailSum(SettProvStatDetail settProvStatDetail);
	
}