/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.csms.modules.settlementfront.entity.SettFb;
import com.cttic.csms.modules.settlementfront.dao.SettFbDao;

/**
 * FB清算反馈文件详单Service
 * @author wanglk
 * @version 2016-12-05
 */
@Service
@Transactional(readOnly = true)
public class SettFbService extends CrudService<SettFbDao, SettFb> {

	public SettFb get(SettFb settFb) {
		//设置动态表名
		settFb.setTableName("sett_fb_"+settFb.getSettDate().substring(0, 6));
		return super.get(settFb);
	}
	
	public List<SettFb> findList(SettFb settFb) {
		return super.findList(settFb);
	}
	
	public Page<SettFb> findPage(Page<SettFb> page, SettFb settFb) {
		//设置动态表名
		settFb.setTableName("sett_fb_"+settFb.getSettDate());
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		settFb.getSqlMap().put("dsf", dataScopeFilter(settFb.getCurrentUser(), "o", ""));
		
		settFb.setPage(page);
		page.setList(dao.findList(settFb));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(SettFb settFb) {
		super.save(settFb);
	}
	
	@Transactional(readOnly = false)
	public void delete(SettFb settFb) {
		super.delete(settFb);
	}
	
}