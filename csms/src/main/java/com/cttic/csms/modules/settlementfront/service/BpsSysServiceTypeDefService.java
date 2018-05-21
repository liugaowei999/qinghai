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
import com.cttic.csms.modules.settlementfront.entity.BpsSysServiceTypeDef;
import com.cttic.csms.modules.settlementfront.dao.BpsSysServiceTypeDefDao;

/**
 * 业务类型定义Service
 * @author aryo
 * @version 2016-12-03
 */
@Service
@Transactional(readOnly = true)
public class BpsSysServiceTypeDefService extends CrudService<BpsSysServiceTypeDefDao, BpsSysServiceTypeDef> {

	public BpsSysServiceTypeDef get(String id) {
		return super.get(id);
	}
	
	public List<BpsSysServiceTypeDef> findList(BpsSysServiceTypeDef bpsSysServiceTypeDef) {
		return super.findList(bpsSysServiceTypeDef);
	}
	
	public Page<BpsSysServiceTypeDef> findPage(Page<BpsSysServiceTypeDef> page, BpsSysServiceTypeDef bpsSysServiceTypeDef) {
		return super.findPage(page, bpsSysServiceTypeDef);
	}
	
	@Transactional(readOnly = false)
	public void save(BpsSysServiceTypeDef bpsSysServiceTypeDef) {
		super.save(bpsSysServiceTypeDef);
	}
	
	@Transactional(readOnly = false)
	public void delete(BpsSysServiceTypeDef bpsSysServiceTypeDef) {
		super.delete(bpsSysServiceTypeDef);
	}

	public Map<String,String> getServiceTypeDropDownMap() {
		BpsSysServiceTypeDef bpsSysServiceTypeDef = new BpsSysServiceTypeDef();
		List<BpsSysServiceTypeDef> bpsSysServiceTypeDefList = super.findList(bpsSysServiceTypeDef);
		Map<String,String> serviceTypeDropDownMap = new HashMap<String,String>();
		for (BpsSysServiceTypeDef serviceType : bpsSysServiceTypeDefList) {
			serviceTypeDropDownMap.put(serviceType.getServiceType(), serviceType.getServiceName());
		}
		return serviceTypeDropDownMap;
	}
	
	public Map<String,String> getServiceTypesDropDownMap() {
		BpsSysServiceTypeDef bpsSysServiceTypeDef = new BpsSysServiceTypeDef();
		List<BpsSysServiceTypeDef> bpsSysServiceTypeDefList = super.findList(bpsSysServiceTypeDef);
		Map<String,String> serviceTypesDropDownMap = new HashMap<String,String>();
		for (BpsSysServiceTypeDef serviceType : bpsSysServiceTypeDefList) {
			serviceTypesDropDownMap.put(serviceType.getId(),serviceType.getServiceType());
		}
		return serviceTypesDropDownMap;
	}
	
}