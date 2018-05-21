package com.cttic.csms.modules.cash.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import java.util.List;

import com.cttic.csms.modules.cash.entity.CashAdviceInfo;

/**
 * 通知信息DAO接口
 * @author ambitious
 * @version 2016-11-29
 */
@MyBatisDao
public interface CashAdviceInfoDao extends CrudDao<CashAdviceInfo> {

	List<CashAdviceInfo> findInfoByParam(CashAdviceInfo cashAdviceInfo);

	String countNdInfo(CashAdviceInfo cashAdviceInfo);
	
}