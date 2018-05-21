/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.csms.modules.settlementfront.entity.BpsErConf;
import com.cttic.csms.modules.settlementfront.dao.BpsErConfDao;

/**
 * ER错误代码下发配置文件Service
 * @author ambitious
 * @version 2016-12-03
 */
@Service
@Transactional(readOnly = true)
public class BpsErConfService extends CrudService<BpsErConfDao, BpsErConf> {

	public BpsErConf get(String id) {
		return super.get(id);
	}
	
	public List<BpsErConf> findList(BpsErConf bpsErConf) {
		return super.findList(bpsErConf);
	}
	
	public Page<BpsErConf> findPage(Page<BpsErConf> page, BpsErConf bpsErConf) {
		return super.findPage(page, bpsErConf);
	}
	
	@Transactional(readOnly = false)
	public void save(BpsErConf bpsErConf) {
		super.save(bpsErConf);
	}
	
	@Transactional(readOnly = false)
	public void delete(BpsErConf bpsErConf) {
		super.delete(bpsErConf);
	}
	
}