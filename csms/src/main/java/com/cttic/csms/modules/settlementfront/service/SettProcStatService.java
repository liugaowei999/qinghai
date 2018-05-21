/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cttic.csms.modules.settlementfront.dao.SettProcStatDao;
import com.cttic.csms.modules.settlementfront.entity.SettProcStat;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;

/**
 * 前台出账Service
 * @author zhouhong
 * @version 2017-05-03
 */
@Service
@Transactional(readOnly = true)
public class SettProcStatService extends CrudService<SettProcStatDao, SettProcStat> {

	@Autowired
	private SettProcStatDao settProcStatDao;

	@Override
	public SettProcStat get(String id) {
		return super.get(id);
	}

	@Override
	public List<SettProcStat> findList(SettProcStat settProcStat) {
		return super.findList(settProcStat);
	}

	@Override
	public Page<SettProcStat> findPage(Page<SettProcStat> page, SettProcStat settProcStat) {
		return super.findPage(page, settProcStat);
	}

	@Override
	@Transactional(readOnly = false)
	public void save(SettProcStat settProcStat) {
		super.save(settProcStat);
	}

	public void executeProc(Map paramMap) {
		settProcStatDao.executeProc(paramMap);
	}

	@Override
	@Transactional(readOnly = false)
	public void delete(SettProcStat settProcStat) {
		super.delete(settProcStat);
	}

}