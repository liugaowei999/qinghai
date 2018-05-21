/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import java.util.List;

import com.cttic.csms.modules.settlementfront.entity.BpsSysOrgInfo;

/**
 * 入网机构配置DAO接口
 * @author aryo
 * @version 2016-12-03
 */
@MyBatisDao
public interface BpsSysOrgInfoDao extends CrudDao<BpsSysOrgInfo> {

	List<BpsSysOrgInfo> findDropDownMap();
	
}