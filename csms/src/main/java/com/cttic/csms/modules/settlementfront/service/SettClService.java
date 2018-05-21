/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.csms.modules.settlementfront.entity.SettCl;
import com.cttic.csms.modules.settlementfront.dao.SettClDao;

/**
 * CL脱机消费明细详单Service
 * @author wanglk
 * @version 2016-12-05
 */
@Service
@Transactional(readOnly = true)
public class SettClService extends CrudService<SettClDao, SettCl> {

	public SettCl get(SettCl settCl) {
		//设置动态表名
		settCl.setTableName("sett_cl_"+settCl.getSettDate().substring(0, 6));
		return super.get(settCl);
	}
	
	public List<SettCl> findList(SettCl settCl) {
		return super.findList(settCl);
	}
	
	public Page<SettCl> findPage(Page<SettCl> page, SettCl settCl) {
		//设置动态表名
		settCl.setTableName("sett_cl_"+settCl.getSettDate());
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		settCl.getSqlMap().put("dsf", dataScopeFilter(settCl.getCurrentUser(), "o", ""));
		
		settCl.setPage(page);
		page.setList(dao.findList(settCl));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(SettCl settCl) {
		super.save(settCl);
	}
	
	@Transactional(readOnly = false)
	public void delete(SettCl settCl) {
		super.delete(settCl);
	}
	
}