package com.cttic.csms.modules.underlytask.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.csms.modules.underlytask.entity.BpsSysModuleParam;
import com.cttic.csms.modules.underlytask.dao.BpsSysModuleParamDao;

/**
 * 清分结算后台任务状态参数查询Service
 * @author ambitious
 * @version 2016-11-14
 */
@Service
@Transactional(readOnly = true)
public class BpsSysModuleParamService extends CrudService<BpsSysModuleParamDao, BpsSysModuleParam> {

	public BpsSysModuleParam get(String id) {
		return super.get(id);
	}
	
	public BpsSysModuleParam getUnionKey(BpsSysModuleParam bpsSysModuleParam) {
		return super.get(bpsSysModuleParam);
	}
	
	public List<BpsSysModuleParam> findList(BpsSysModuleParam bpsSysModuleParam) {
		return super.findList(bpsSysModuleParam);
	}
	
	public Page<BpsSysModuleParam> findPage(Page<BpsSysModuleParam> page, BpsSysModuleParam bpsSysModuleParam) {
		return super.findPage(page, bpsSysModuleParam);
	}
	
	@Transactional(readOnly = false)
	public void save(BpsSysModuleParam bpsSysModuleParam) {
		super.save(bpsSysModuleParam);
	}
	
	@Transactional(readOnly = false)
	public void delete(BpsSysModuleParam bpsSysModuleParam) {
		super.delete(bpsSysModuleParam);
	}
	
}