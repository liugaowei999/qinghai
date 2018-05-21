/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.cash.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cttic.csms.modules.cash.entity.SettBpDetail;

/**
 * 同步备付金账户金额DAO接口
 * @author wanglk
 * @version 2016-11-26
 */
@MyBatisDao
public interface SettBpDetailDao extends CrudDao<SettBpDetail> {

	List<SettBpDetail> findListForSync(SettBpDetail settBpDetail);
	
	
	long findSumForPay(@Param("settBpDetail") SettBpDetail settBpDetail, @Param("beginSettDate")String beginSettDate, @Param("endSettDate")String endSettDate);
	
}