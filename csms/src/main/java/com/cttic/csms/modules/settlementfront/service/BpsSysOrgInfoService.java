/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.csms.modules.settlementfront.entity.BpsSysOrgInfo;
import com.cttic.csms.modules.settlementfront.dao.BpsSysOrgInfoDao;

/**
 * 入网机构配置Service
 * @author aryo
 * @version 2016-12-03
 */
@Service
@Transactional(readOnly = true)
public class BpsSysOrgInfoService extends CrudService<BpsSysOrgInfoDao, BpsSysOrgInfo> {

	@Autowired 
	private BpsSysOrgInfoDao bpsSysOrgInfoDao;
	public BpsSysOrgInfo get(String id) {
		return super.get(id);
	}
	
	public List<BpsSysOrgInfo> findList(BpsSysOrgInfo bpsSysOrgInfo) {
		return super.findList(bpsSysOrgInfo);
	}
	
	public Page<BpsSysOrgInfo> findPage(Page<BpsSysOrgInfo> page, BpsSysOrgInfo bpsSysOrgInfo) {
		return super.findPage(page, bpsSysOrgInfo);
	}
	
	@Transactional(readOnly = false)
	public void save(BpsSysOrgInfo bpsSysOrgInfo) {
		super.save(bpsSysOrgInfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(BpsSysOrgInfo bpsSysOrgInfo) {
		super.delete(bpsSysOrgInfo);
	}

	public Map<String,String> getOrgCodeDropDownMap(){
		BpsSysOrgInfo bpsSysOrgInfo = new BpsSysOrgInfo();
		List<BpsSysOrgInfo> bpsSysOrgInfoList = super.findList(bpsSysOrgInfo);
		Map<String,String> orgInfoDropDownMap = new HashMap<String,String>();
		for (BpsSysOrgInfo orgInfo : bpsSysOrgInfoList) {
			orgInfoDropDownMap.put(orgInfo.getId(), orgInfo.getOrgCode());
		}
		return orgInfoDropDownMap;
	}
	
	public Map<String,String> getOrgNameDropDownMap(){
		BpsSysOrgInfo bpsSysOrgInfo = new BpsSysOrgInfo();
		List<BpsSysOrgInfo> bpsSysOrgInfoList = super.findList(bpsSysOrgInfo);
		Map<String,String> orgNameDropDownMap = new HashMap<String,String>();
		for (BpsSysOrgInfo orgInfo : bpsSysOrgInfoList) {
			orgNameDropDownMap.put(orgInfo.getOrgCode(), orgInfo.getOrgName());
		}
		return orgNameDropDownMap;
	}
	
	public Map<String,String> getOrgInfoDropDownMap(){
		BpsSysOrgInfo bpsSysOrgInfo = new BpsSysOrgInfo();
		List<BpsSysOrgInfo> bpsSysOrgInfoList = bpsSysOrgInfoDao.findDropDownMap();
		Map<String,String> orgNameDropDownMap = new HashMap<String,String>();
		for (BpsSysOrgInfo orgInfo : bpsSysOrgInfoList) {
			orgNameDropDownMap.put(orgInfo.getOrgCode(), orgInfo.getOrgName());
		}
		return orgNameDropDownMap;
	}

}