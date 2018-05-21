/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.csms.modules.settlementfront.entity.InfoBnConf;
import com.cttic.csms.modules.settlementfront.dao.InfoBnConfDao;

/**
 * 对BN白名单进行配置Service
 * @author ambitious
 * @version 2016-12-03
 */
@Service
@Transactional(readOnly = true)
public class InfoBnConfService extends CrudService<InfoBnConfDao, InfoBnConf> {

	public InfoBnConf get(String id) {
		return super.get(id);
	}
	
	public List<InfoBnConf> findList(InfoBnConf bpsBnConf) {
		return super.findList(bpsBnConf);
	}
	
	public Page<InfoBnConf> findPage(Page<InfoBnConf> page, InfoBnConf bpsBnConf) {
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		bpsBnConf.getSqlMap().put("dsf", dataScopeFilter(bpsBnConf.getCurrentUser(), "o", ""));
		return super.findPage(page, bpsBnConf);
	}
	
	@Transactional(readOnly = false)
	public void save(InfoBnConf bpsBnConf) {
		super.save(bpsBnConf);
	}
	
	@Transactional(readOnly = false)
	public void delete(InfoBnConf bpsBnConf) {
		super.delete(bpsBnConf);
	}
	
}