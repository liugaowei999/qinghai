/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.csms.modules.settlementfront.entity.BpsSysBusinessTypeDef;
import com.cttic.csms.modules.settlementfront.entity.BpsSysOrgInfo;
import com.cttic.csms.modules.settlementfront.dao.BpsSysBusinessTypeDefDao;

/**
 * 清算费率配置Service
 * @author aryo
 * @version 2016-12-03
 */
@Service
@Transactional(readOnly = true)
public class BpsSysBusinessTypeDefService extends CrudService<BpsSysBusinessTypeDefDao, BpsSysBusinessTypeDef> {

	public BpsSysBusinessTypeDef get(String id) {
		return super.get(id);
	}
	
	public List<BpsSysBusinessTypeDef> findList(BpsSysBusinessTypeDef bpsSysBusinessTypeDef) {
		return super.findList(bpsSysBusinessTypeDef);
	}
	
	public Page<BpsSysBusinessTypeDef> findPage(Page<BpsSysBusinessTypeDef> page, BpsSysBusinessTypeDef bpsSysBusinessTypeDef) {
		return super.findPage(page, bpsSysBusinessTypeDef);
	}
	
	@Transactional(readOnly = false)
	public void save(BpsSysBusinessTypeDef bpsSysBusinessTypeDef) {
		super.save(bpsSysBusinessTypeDef);
	}
	
	@Transactional(readOnly = false)
	public void delete(BpsSysBusinessTypeDef bpsSysBusinessTypeDef) {
		super.delete(bpsSysBusinessTypeDef);
	}

	public Map<String,String> getBusinessTypeDropDownMap(){
		BpsSysBusinessTypeDef bpsSysBusinessTypeDef = new BpsSysBusinessTypeDef();
		List<BpsSysBusinessTypeDef> bpsSysBusinessTypeDefList = super.findList(bpsSysBusinessTypeDef);
		Map<String,String> businessTypeDropDownMap = new HashMap<String,String>();
		for (BpsSysBusinessTypeDef businessType : bpsSysBusinessTypeDefList) {
			businessTypeDropDownMap.put(businessType.getBusinessType(), businessType.getBusinessName());
		}
		return businessTypeDropDownMap;
	}
	public Map<String,String> getBusinessTypesDropDownMap(){
		BpsSysBusinessTypeDef bpsSysBusinessTypeDef = new BpsSysBusinessTypeDef();
		List<BpsSysBusinessTypeDef> bpsSysBusinessTypeDefList = super.findList(bpsSysBusinessTypeDef);
		Map<String,String> businessTypesDropDownMap = new HashMap<String,String>();
		for (BpsSysBusinessTypeDef businessType : bpsSysBusinessTypeDefList) {
			businessTypesDropDownMap.put(businessType.getId(),businessType.getBusinessType());
		}
		return businessTypesDropDownMap;
	}
	public Map<String,String> getBusinessNameDropDownMap(){
		BpsSysBusinessTypeDef bpsSysBusinessTypeDef = new BpsSysBusinessTypeDef();
		List<BpsSysBusinessTypeDef> bpsSysBusinessTypeDefList = super.findList(bpsSysBusinessTypeDef);
		Map<String,String> businessNameDropDownMap = new HashMap<String,String>();
		for (BpsSysBusinessTypeDef businessType : bpsSysBusinessTypeDefList) {
			businessNameDropDownMap.put(businessType.getId(), businessType.getBusinessName());
		}
		return businessNameDropDownMap;
	}
	
}