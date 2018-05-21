/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.cash.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import java.util.List;

import com.cttic.csms.modules.cash.entity.SettAdDetail;

/**
 * 同步备付金账户金额--差错数据DAO接口
 * @author wanglk
 * @version 2016-11-26
 */
@MyBatisDao
public interface SettAdDetailDao extends CrudDao<SettAdDetail> {

	List<SettAdDetail> findListForSync(SettAdDetail settAdDetail);
	
}