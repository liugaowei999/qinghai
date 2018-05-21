/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.reports.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.csms.modules.reports.entity.SettCityStatDetail;
import com.cttic.csms.modules.reports.dao.SettCityStatDetailDao;

/**
 * 省内结算报表展示Service
 * @author wanglk
 * @version 2016-12-22
 */
@Service
@Transactional(readOnly = true)
public class SettCityStatDetailService extends CrudService<SettCityStatDetailDao, SettCityStatDetail> {
	
	@Autowired
	private SettCityStatDetailDao settCityStatDetailDao;

	public SettCityStatDetail get(String id) {
		return super.get(id);
	}
	
	public List<SettCityStatDetail> findList(SettCityStatDetail settCityStatDetail) {
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
				settCityStatDetail.getSqlMap().put("dsf", dataScopeFilter(settCityStatDetail.getCurrentUser(), "o", ""));
		return super.findList(settCityStatDetail);
	}
	
	public Page<SettCityStatDetail> findPage(Page<SettCityStatDetail> page, SettCityStatDetail settCityStatDetail) {
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		settCityStatDetail.getSqlMap().put("dsf", dataScopeFilter(settCityStatDetail.getCurrentUser(), "o", ""));
		return super.findPage(page, settCityStatDetail);
	}
	
	@Transactional(readOnly = false)
	public void save(SettCityStatDetail settCityStatDetail) {
		super.save(settCityStatDetail);
	}
	
	@Transactional(readOnly = false)
	public void delete(SettCityStatDetail settCityStatDetail) {
		super.delete(settCityStatDetail);
	}

	public List<SettCityStatDetail> billCodeViewChart(SettCityStatDetail settCityStatDetail) {
		settCityStatDetail.getSqlMap().put("dsf", dataScopeFilter(settCityStatDetail.getCurrentUser(), "o", ""));
		return settCityStatDetailDao.billCodeViewChart(settCityStatDetail);
	}

	public List<SettCityStatDetail> issueCodeViewChart(SettCityStatDetail settCityStatDetail) {
		settCityStatDetail.getSqlMap().put("dsf", dataScopeFilter(settCityStatDetail.getCurrentUser(), "o", ""));
		return settCityStatDetailDao.issueCodeViewChart(settCityStatDetail);
	}

	public List<SettCityStatDetail> issueCodeLineChart(SettCityStatDetail settCityStatDetail) {
		settCityStatDetail.getSqlMap().put("dsf", dataScopeFilter(settCityStatDetail.getCurrentUser(), "o", ""));
		return settCityStatDetailDao.issueCodeLineChart(settCityStatDetail);
	}

	public List<SettCityStatDetail> billCodeLineChart(SettCityStatDetail settCityStatDetail) {
		settCityStatDetail.getSqlMap().put("dsf", dataScopeFilter(settCityStatDetail.getCurrentUser(), "o", ""));
		return settCityStatDetailDao.billCodeLineChart(settCityStatDetail);	}

	public List<SettCityStatDetail> billCodeSumViewChart(SettCityStatDetail settCityStatDetail) {
		settCityStatDetail.getSqlMap().put("dsf", dataScopeFilter(settCityStatDetail.getCurrentUser(), "o", ""));
		return settCityStatDetailDao.billCodeSumViewChart(settCityStatDetail);
	}

	public List<HashMap<String, String>> findBillOrgCode(SettCityStatDetail settCityStatDetail) {
		settCityStatDetail.getSqlMap().put("dsf", dataScopeFilter(settCityStatDetail.getCurrentUser(), "o", ""));
		return settCityStatDetailDao.findBillOrgCode(settCityStatDetail);
	}

	public List<HashMap<String, String>> findIssueOrgCode(SettCityStatDetail settCityStatDetail) {
		settCityStatDetail.getSqlMap().put("dsf", dataScopeFilter(settCityStatDetail.getCurrentUser(), "o", ""));
		return settCityStatDetailDao.findIssueOrgCode(settCityStatDetail);
	}

	public SettCityStatDetail settCityStatDetailSum(SettCityStatDetail settCityStatDetail) {
		settCityStatDetail.getSqlMap().put("dsf", dataScopeFilter(settCityStatDetail.getCurrentUser(), "o", ""));
		return settCityStatDetailDao.settCityStatDetailSum(settCityStatDetail);
	}
	
}