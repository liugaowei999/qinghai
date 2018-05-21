/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.newreports.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import java.util.List;

import com.cttic.csms.modules.newreports.entity.SettProvDetail;

/**
 * 跨省结算详单展示DAO接口
 * @author aryo
 * @version 2017-03-07
 */
@MyBatisDao
public interface SettProvDetailDao extends CrudDao<SettProvDetail> {

	List<SettProvDetail> findAllList();
	//add sum 2017/10/10
	SettProvDetail getSum(SettProvDetail settProvDetail);
}