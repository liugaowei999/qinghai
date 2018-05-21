/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.underlytask.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.csms.modules.underlytask.entity.BpsSysModule;
import com.cttic.csms.modules.underlytask.dao.BpsSysModuleDao;

/**
 * 对后台任务处理情况进行查询和修改Service
 * @author ambitious
 * @version 2016-11-12
 */
@Service
@Transactional(readOnly = true)
public class BpsSysModuleService extends CrudService<BpsSysModuleDao, BpsSysModule> {

	public BpsSysModule get(String id) {
		return super.get(id);
	}
	
	public List<BpsSysModule> findList(BpsSysModule bpsSysModule) {
		return super.findList(bpsSysModule);
	}
	
	public Page<BpsSysModule> findPage(Page<BpsSysModule> page, BpsSysModule bpsSysModule) {
		return super.findPage(page, bpsSysModule);
	}
	
	@Transactional(readOnly = false)
	public void save(BpsSysModule bpsSysModule) {
		super.save(bpsSysModule);
		if (bpsSysModule.getIsNewRecord()){
			bpsSysModule.preInsert();
			dao.insert(bpsSysModule);
		}else{
			bpsSysModule.preUpdate();
			dao.update(bpsSysModule);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(BpsSysModule bpsSysModule) {
		super.delete(bpsSysModule);
	}
	
}