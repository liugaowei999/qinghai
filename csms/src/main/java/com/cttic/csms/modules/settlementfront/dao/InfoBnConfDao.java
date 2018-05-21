/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cttic.csms.modules.settlementfront.entity.InfoBnConf;

/**
 * 对BN白名单进行配置DAO接口
 * @author ambitious
 * @version 2016-12-03
 */
@MyBatisDao
public interface InfoBnConfDao extends CrudDao<InfoBnConf> {
	
}