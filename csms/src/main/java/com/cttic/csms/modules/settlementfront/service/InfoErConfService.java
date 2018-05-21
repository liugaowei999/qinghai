/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.csms.modules.settlementfront.entity.InfoErConf;
import com.cttic.csms.modules.settlementfront.dao.InfoErConfDao;

/**
 * ER错误代码下发配置文件Service
 * @author ambitious
 * @version 2016-12-03
 */
@Service
@Transactional(readOnly = true)
public class InfoErConfService extends CrudService<InfoErConfDao, InfoErConf> {

	public InfoErConf get(String id) {
		return super.get(id);
	}
	
	public List<InfoErConf> findList(InfoErConf bpsErConf) {
		return super.findList(bpsErConf);
	}
	
	public Page<InfoErConf> findPage(Page<InfoErConf> page, InfoErConf bpsErConf) {
		return super.findPage(page, bpsErConf);
	}
	
	@Transactional(readOnly = false)
	public void save(InfoErConf bpsErConf) {
		super.save(bpsErConf);
	}
	
	@Transactional(readOnly = false)
	public void delete(InfoErConf bpsErConf) {
		super.delete(bpsErConf);
	}
	
}