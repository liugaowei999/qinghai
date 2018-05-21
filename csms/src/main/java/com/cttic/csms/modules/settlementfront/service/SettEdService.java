/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.csms.modules.settlementfront.entity.SettCl;
import com.cttic.csms.modules.settlementfront.entity.SettEd;
import com.cttic.csms.modules.settlementfront.dao.SettEdDao;

/**
 * ED差错处理文件Service
 * @author wanglk
 * @version 2016-12-15
 */
@Service
@Transactional(readOnly = true)
public class SettEdService extends CrudService<SettEdDao, SettEd> {
 
	public SettEd get(String id) {
		return super.get(id);
	}
	
	public SettEd get(SettEd settEd) {
		//设置动态表名
		settEd.setTableName("sett_ed_"+settEd.getSettDate().substring(0, 6));
		return super.get(settEd);
	}
	
	public List<SettEd> findList(SettEd settEd) {
		return super.findList(settEd);
	}
	
	public Page<SettEd> findPage(Page<SettEd> page, SettEd settEd) {
		//设置动态表名
		settEd.setTableName("sett_ed_"+settEd.getSettDate().substring(0, 6));
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		settEd.getSqlMap().put("dsf", dataScopeFilter(settEd.getCurrentUser(), "o", ""));
		
		settEd.setPage(page);
		page.setList(dao.findList(settEd));
		return page;
		
	}
	
	@Transactional(readOnly = false)
	public void save(SettEd settEd) {
		//设置动态表名
		settEd.setTableName("sett_ed_"+settEd.getSettDate().substring(0, 6));
		super.save(settEd);
	}
	
	@Transactional(readOnly = false)
	public void delete(SettEd settEd) {
		super.delete(settEd);
	}
	
}