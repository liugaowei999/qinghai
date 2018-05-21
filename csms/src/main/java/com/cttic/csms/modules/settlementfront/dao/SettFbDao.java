/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cttic.csms.modules.settlementfront.entity.SettFb;

/**
 * FB清算反馈文件详单DAO接口
 * @author wanglk
 * @version 2016-12-05
 */
@MyBatisDao
public interface SettFbDao extends CrudDao<SettFb> {
	
}