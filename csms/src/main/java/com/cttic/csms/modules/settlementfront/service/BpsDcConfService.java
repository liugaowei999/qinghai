/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.csms.modules.settlementfront.entity.BpsDcConf;
import com.cttic.csms.modules.settlementfront.dao.BpsDcConfDao;

/**
 * DC下发黑名单配置文件Service
 * @author ambitious
 * @version 2016-12-03
 */
@Service
@Transactional(readOnly = true)
public class BpsDcConfService extends CrudService<BpsDcConfDao, BpsDcConf> {

	public BpsDcConf get(String id) {
		return super.get(id);
	}
	
	public List<BpsDcConf> findList(BpsDcConf bpsDcConf) {
		return super.findList(bpsDcConf);
	}
	
	public Page<BpsDcConf> findPage(Page<BpsDcConf> page, BpsDcConf bpsDcConf) {
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		bpsDcConf.getSqlMap().put("dsf", dataScopeFilter(bpsDcConf.getCurrentUser(), "o", ""));
		return super.findPage(page, bpsDcConf);
	}
	
	@Transactional(readOnly = false)
	public void save(BpsDcConf bpsDcConf) {
		super.save(bpsDcConf);
	}
	
	@Transactional(readOnly = false)
	public void delete(BpsDcConf bpsDcConf) {
		super.delete(bpsDcConf);
	}
	
}