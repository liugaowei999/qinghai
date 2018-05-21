/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.csms.modules.settlementfront.entity.SettLd;
import com.cttic.csms.modules.settlementfront.dao.SettLdDao;

/**
 * LD消费已处理文件清单Service
 * @author wanglk
 * @version 2016-12-05
 */
@Service
@Transactional(readOnly = true)
public class SettLdService extends CrudService<SettLdDao, SettLd> {

	public SettLd get(SettLd settLd) {
		//设置动态表名
		settLd.setTableName("sett_ld_"+settLd.getSettDate().substring(0, 6));
		return super.get(settLd);
	}
	
	public List<SettLd> findList(SettLd settLd) {
		return super.findList(settLd);
	}
	
	public Page<SettLd> findPage(Page<SettLd> page, SettLd settLd) {
		//设置动态表名
		settLd.setTableName("sett_ld_"+settLd.getSettDate());
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		settLd.getSqlMap().put("dsf", dataScopeFilter(settLd.getCurrentUser(), "o", ""));
		
		settLd.setPage(page);
		page.setList(dao.findList(settLd));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(SettLd settLd) {
		super.save(settLd);
	}
	
	@Transactional(readOnly = false)
	public void delete(SettLd settLd) {
		super.delete(settLd);
	}
	
}