/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.csms.modules.settlementfront.entity.BpsUcConf;
import com.cttic.csms.modules.settlementfront.dao.BpsUcConfDao;

/**
 * UC上发黑名单配置文件Service
 * @author ambitious
 * @version 2016-12-03
 */
@Service
@Transactional(readOnly = true)
public class BpsUcConfService extends CrudService<BpsUcConfDao, BpsUcConf> {

	public BpsUcConf get(String id) {
		return super.get(id);
	}
	
	public List<BpsUcConf> findList(BpsUcConf bpsUcConf) {
		return super.findList(bpsUcConf);
	}
	
	public Page<BpsUcConf> findPage(Page<BpsUcConf> page, BpsUcConf bpsUcConf) {
		return super.findPage(page, bpsUcConf);
	}
	
	@Transactional(readOnly = false)
	public void save(BpsUcConf bpsUcConf) {
		super.save(bpsUcConf);
	}
	
	@Transactional(readOnly = false)
	public void delete(BpsUcConf bpsUcConf) {
		super.delete(bpsUcConf);
	}
	
}