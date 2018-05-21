/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.sysframe.timetask.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.sysframe.timetask.entity.SysTimetaskLog;
import com.cttic.sysframe.timetask.dao.SysTimetaskLogDao;

/**
 * 定时任务日志管理Service
 * @author dener
 * @version 2016-12-06
 */
@Service
@Transactional(readOnly = true)
public class SysTimetaskLogService extends CrudService<SysTimetaskLogDao, SysTimetaskLog> {

	public SysTimetaskLog get(String id) {
		return super.get(id);
	}
	
	public List<SysTimetaskLog> findList(SysTimetaskLog sysTimetaskLog) {
		return super.findList(sysTimetaskLog);
	}
	
	public Page<SysTimetaskLog> findPage(Page<SysTimetaskLog> page, SysTimetaskLog sysTimetaskLog) {
		return super.findPage(page, sysTimetaskLog);
	}
	
	@Transactional(readOnly = false)
	public void save(SysTimetaskLog sysTimetaskLog) {
		super.save(sysTimetaskLog);
	}
	
	@Transactional(readOnly = false)
	public void delete(SysTimetaskLog sysTimetaskLog) {
		super.delete(sysTimetaskLog);
	}
	
}