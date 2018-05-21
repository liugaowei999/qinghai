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
import com.cttic.csms.modules.reports.entity.SettStatReport;
import com.cttic.csms.modules.reports.dao.SettStatReportDao;

/**
 * 结算报表展示Service
 * @author wanglk
 * @version 2016-12-21
 */
@Service
@Transactional(readOnly = true)
public class SettStatReportService extends CrudService<SettStatReportDao, SettStatReport> {
	@Autowired
	private SettStatReportDao settStatReportDao;
	public SettStatReport get(String id) {
		return super.get(id);
	}
	
	public List<SettStatReport> findList(SettStatReport settStatReport) {
		settStatReport.getSqlMap().put("dsf", dataScopeFilter(settStatReport.getCurrentUser(), "o", ""));
		return super.findList(settStatReport);
	}
	
	public Page<SettStatReport> findPage(Page<SettStatReport> page, SettStatReport settStatReport) {
		String settType = settStatReport.getSettType();
		if(settType!=null&&!settType.equals("")){
			if(!settType.equals("01")){
				settStatReport.getSqlMap().put("dsf", dataScopeFilter(settStatReport.getCurrentUser(), "o", ""));
			}
		}else{
			settStatReport.getSqlMap().put("dsf", dataScopeFilter(settStatReport.getCurrentUser(), "o", ""));
		}
		
		
		return super.findPage(page, settStatReport);
	}
	
	@Transactional(readOnly = false)
	public void save(SettStatReport settStatReport) {
		super.save(settStatReport);
	}
	
	@Transactional(readOnly = false)
	public void delete(SettStatReport settStatReport) {
		super.delete(settStatReport);
	}

	public List<SettStatReport> orgCodeViewChart(SettStatReport settStatReport) {
		String settType = settStatReport.getSettType();
		if(settType!=null&&!settType.equals("")){
			if(!settType.equals("01")){
				settStatReport.getSqlMap().put("dsf", dataScopeFilter(settStatReport.getCurrentUser(), "o", ""));
			}
		}else{
			settStatReport.getSqlMap().put("dsf", dataScopeFilter(settStatReport.getCurrentUser(), "o", ""));
		}
		return settStatReportDao.orgCodeViewChart(settStatReport);
	}

	public List<SettStatReport> settTypeViewChart(SettStatReport settStatReport) {
		String settType = settStatReport.getSettType();
		if(settType!=null&&!settType.equals("")){
			if(!settType.equals("01")){
				settStatReport.getSqlMap().put("dsf", dataScopeFilter(settStatReport.getCurrentUser(), "o", ""));
			}
		}else{
			settStatReport.getSqlMap().put("dsf", dataScopeFilter(settStatReport.getCurrentUser(), "o", ""));
		}
		return settStatReportDao.settTypeViewChart(settStatReport);
	}
	
	public List<SettStatReport> stMViewChart(SettStatReport settStatReport) {
		String settType = settStatReport.getSettType();
		if(settType!=null&&!settType.equals("")){
			if(!settType.equals("01")){
				settStatReport.getSqlMap().put("dsf", dataScopeFilter(settStatReport.getCurrentUser(), "o", ""));
			}
		}else{
			settStatReport.getSqlMap().put("dsf", dataScopeFilter(settStatReport.getCurrentUser(), "o", ""));
		}
		return settStatReportDao.stMViewChart(settStatReport);
	}

	public List<SettStatReport> ocMViewChart(SettStatReport settStatReport) {
		String settType = settStatReport.getSettType();
		if(settType!=null&&!settType.equals("")){
			if(!settType.equals("01")){
				settStatReport.getSqlMap().put("dsf", dataScopeFilter(settStatReport.getCurrentUser(), "o", ""));
			}
		}else{
			settStatReport.getSqlMap().put("dsf", dataScopeFilter(settStatReport.getCurrentUser(), "o", ""));
		}
		return settStatReportDao.ocMViewChart(settStatReport);
	}

	public List<SettStatReport> orgCodeSumViewChart(SettStatReport settStatReport) {
		String settType = settStatReport.getSettType();
		if(settType!=null&&!settType.equals("")){
			if(!settType.equals("01")){
				settStatReport.getSqlMap().put("dsf", dataScopeFilter(settStatReport.getCurrentUser(), "o", ""));
			}
		}else{
			settStatReport.getSqlMap().put("dsf", dataScopeFilter(settStatReport.getCurrentUser(), "o", ""));
		}
		return settStatReportDao.orgCodeSumViewChart(settStatReport);
	}

	public List<HashMap<String, String>> findSettTypeList(SettStatReport settStatReport) {
		String settType = settStatReport.getSettType();
		if(settType!=null&&!settType.equals("")){
			if(!settType.equals("01")){
				settStatReport.getSqlMap().put("dsf", dataScopeFilter(settStatReport.getCurrentUser(), "o", ""));
			}
		}else{
			settStatReport.getSqlMap().put("dsf", dataScopeFilter(settStatReport.getCurrentUser(), "o", ""));
		}
		return settStatReportDao.findSettTypeList(settStatReport);
	}

	public List<HashMap<String, String>> findOrgCodeList(SettStatReport settStatReport) {
		String settType = settStatReport.getSettType();
		if(settType!=null&&!settType.equals("")){
			if(!settType.equals("01")){
				settStatReport.getSqlMap().put("dsf", dataScopeFilter(settStatReport.getCurrentUser(), "o", ""));
			}
		}else{
			settStatReport.getSqlMap().put("dsf", dataScopeFilter(settStatReport.getCurrentUser(), "o", ""));
		}
		return settStatReportDao.findOrgCodeList(settStatReport);
	}

	public SettStatReport settStatReportInProvSum(SettStatReport settStatReport){
		settStatReport.getSqlMap().put("dsf", dataScopeFilter(settStatReport.getCurrentUser(), "o", ""));
		return settStatReportDao.settStatReportInProvSum(settStatReport);
	}

	public SettStatReport settStatReportOutProvSum(SettStatReport settStatReport) {
		// TODO Auto-generated method stub
		return settStatReportDao.settStatReportOutProvSum(settStatReport);
	}

	
}