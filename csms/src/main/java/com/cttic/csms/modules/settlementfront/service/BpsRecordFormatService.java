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
import com.cttic.csms.modules.settlementfront.entity.BpsRecordFormat;
import com.cttic.csms.modules.settlementfront.dao.BpsRecordFormatDao;

/**
 * 清单记录格式定义Service
 * @author aryo
 * @version 2016-12-03
 */
@Service
@Transactional(readOnly = true)
public class BpsRecordFormatService extends CrudService<BpsRecordFormatDao, BpsRecordFormat> {
	
	@Autowired
	private BpsRecordFormatDao bpsRecordFormatDao;
	
	public BpsRecordFormat get(String id) {
		return super.get(id);
	}
	
	public List<BpsRecordFormat> findList(BpsRecordFormat bpsRecordFormat) {
		return super.findList(bpsRecordFormat);
	}
	
	public Page<BpsRecordFormat> findPage(Page<BpsRecordFormat> page, BpsRecordFormat bpsRecordFormat) {
		return super.findPage(page, bpsRecordFormat);
	}
	
	@Transactional(readOnly = false)
	public void save(BpsRecordFormat bpsRecordFormat) {
		super.save(bpsRecordFormat);
	}
	
	@Transactional(readOnly = false)
	public void delete(BpsRecordFormat bpsRecordFormat) {
		super.delete(bpsRecordFormat);
	}

	public Map<String,String> getDrTypeDropDownMap() {
		List<HashMap<String,String>> bpsRecordFormatList = bpsRecordFormatDao.findDrTypeList();
		Map<String,String> drTypeDownMap = new HashMap<String,String>();
		for (HashMap<String,String> map : bpsRecordFormatList) {
			drTypeDownMap.put(map.get("drType"), map.get("drType"));
		}
		return drTypeDownMap;
	}
	
}