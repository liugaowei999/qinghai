/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cttic.csms.modules.settlementfront.entity.BpsUcConf;

/**
 * UC上发黑名单配置文件DAO接口
 * @author ambitious
 * @version 2016-12-03
 */
@MyBatisDao
public interface BpsUcConfDao extends CrudDao<BpsUcConf> {
	
}