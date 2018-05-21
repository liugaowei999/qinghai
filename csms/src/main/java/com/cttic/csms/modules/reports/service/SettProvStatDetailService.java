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
import com.cttic.csms.modules.reports.entity.SettProvStatDetail;
import com.cttic.csms.modules.reports.dao.SettProvStatDetailDao;

/**
 * 跨省结算报表展示Service
 * @author wanglk
 * @version 2016-12-22
 */
@Service
@Transactional(readOnly = true)
public class SettProvStatDetailService extends CrudService<SettProvStatDetailDao, SettProvStatDetail> {

	@Autowired
	private SettProvStatDetailDao settProvStatDetailDao;
	public SettProvStatDetail get(String id) {
		return super.get(id);
	}
	
	public List<SettProvStatDetail> findList(SettProvStatDetail settProvStatDetail) {
		return super.findList(settProvStatDetail);
	}
	
	public Page<SettProvStatDetail> findPage(Page<SettProvStatDetail> page, SettProvStatDetail settProvStatDetail) {
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		settProvStatDetail.getSqlMap().put("dsf", dataScopeFilter(settProvStatDetail.getCurrentUser(), "o", ""));
		return super.findPage(page, settProvStatDetail);
	}
	
	@Transactional(readOnly = false)
	public void save(SettProvStatDetail settProvStatDetail) {
		super.save(settProvStatDetail);
	}
	
	@Transactional(readOnly = false)
	public void delete(SettProvStatDetail settProvStatDetail) {
		super.delete(settProvStatDetail);
	}
	
	public List<SettProvStatDetail> billCodeProvViewChart(SettProvStatDetail settProvStatDetail) {
		settProvStatDetail.getSqlMap().put("dsf", dataScopeFilter(settProvStatDetail.getCurrentUser(), "o", ""));
		return settProvStatDetailDao.billCodeProvViewChart(settProvStatDetail);
	}

	public List<SettProvStatDetail> issueCodeProvViewChart(SettProvStatDetail settProvStatDetail) {
		settProvStatDetail.getSqlMap().put("dsf", dataScopeFilter(settProvStatDetail.getCurrentUser(), "o", ""));
		return settProvStatDetailDao.issueCodeProvViewChart(settProvStatDetail);
	}

	public List<SettProvStatDetail> issueCodeProvLineChart(SettProvStatDetail settProvStatDetail) {
		settProvStatDetail.getSqlMap().put("dsf", dataScopeFilter(settProvStatDetail.getCurrentUser(), "o", ""));
		return settProvStatDetailDao.issueCodeProvLineChart(settProvStatDetail);
	}

	public List<SettProvStatDetail> billCodeProvLineChart(SettProvStatDetail settProvStatDetail) {
		settProvStatDetail.getSqlMap().put("dsf", dataScopeFilter(settProvStatDetail.getCurrentUser(), "o", ""));
		return settProvStatDetailDao.billCodeProvLineChart(settProvStatDetail);	}

	public List<SettProvStatDetail> billCodeSumProvViewChart(SettProvStatDetail settProvStatDetail) {
		settProvStatDetail.getSqlMap().put("dsf", dataScopeFilter(settProvStatDetail.getCurrentUser(), "o", ""));
		return settProvStatDetailDao.billCodeSumProvViewChart(settProvStatDetail);
	}

	public List<HashMap<String, String>> findBillOrgCode(SettProvStatDetail settProvStatDetail) {
		settProvStatDetail.getSqlMap().put("dsf", dataScopeFilter(settProvStatDetail.getCurrentUser(), "o", ""));
		return settProvStatDetailDao.findBillOrgCode(settProvStatDetail);
	}

	public List<HashMap<String, String>> findIssueOrgCode(SettProvStatDetail settProvStatDetail) {
		settProvStatDetail.getSqlMap().put("dsf", dataScopeFilter(settProvStatDetail.getCurrentUser(), "o", ""));
		return settProvStatDetailDao.findIssueOrgCode(settProvStatDetail);
	}

	public SettProvStatDetail settProvStatDetailSum(SettProvStatDetail settProvStatDetail) {
		settProvStatDetail.getSqlMap().put("dsf", dataScopeFilter(settProvStatDetail.getCurrentUser(), "o", ""));
		return settProvStatDetailDao.settProvStatDetailSum(settProvStatDetail);
	}
	
}