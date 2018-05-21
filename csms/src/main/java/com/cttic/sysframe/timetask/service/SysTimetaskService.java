/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.sysframe.timetask.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.sysframe.timetask.entity.SysTimetask;
import com.cttic.sysframe.timetask.dao.SysTimetaskDao;

/**
 * 定时任务管理功能Service
 * @author dener
 * @version 2016-12-06
 */
@Service
@Transactional(readOnly = true)
public class SysTimetaskService extends CrudService<SysTimetaskDao, SysTimetask> {

	public SysTimetask get(String id) {
		return super.get(id);
	}
	
	public List<SysTimetask> findList(SysTimetask sysTimetask) {
		return super.findList(sysTimetask);
	}
	
	public Page<SysTimetask> findPage(Page<SysTimetask> page, SysTimetask sysTimetask) {
		return super.findPage(page, sysTimetask);
	}
	
	@Transactional(readOnly = false)
	public void save(SysTimetask sysTimetask) {
		super.save(sysTimetask);
	}
	
	@Transactional(readOnly = false)
	public void delete(SysTimetask sysTimetask) {
		super.delete(sysTimetask);
	}
	
}