package com.cttic.csms.modules.cash.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cttic.csms.modules.cash.dao.CashAdviceInfoDao;
import com.cttic.csms.modules.cash.entity.CashAdviceInfo;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 通知信息Service
 * @author ambitious
 * @version 2016-11-29
 */
@Service
@Transactional(readOnly = true)
public class CashAdviceInfoService extends CrudService<CashAdviceInfoDao, CashAdviceInfo> {
	
	/**
	 * 持久层对象
	 */
	@Autowired
	protected CashAdviceInfoDao cashAdviceInfoDao;
	
	public CashAdviceInfo get(String id) {
		return super.get(id);
	}
	
	public List<CashAdviceInfo> findList(CashAdviceInfo cashAdviceInfo) {
		return super.findList(cashAdviceInfo);
	}
	
	public Page<CashAdviceInfo> findPage(Page<CashAdviceInfo> page, CashAdviceInfo cashAdviceInfo) {
		return super.findPage(page, cashAdviceInfo);
	}
	
	@Transactional(readOnly = false)
	public void save(CashAdviceInfo cashAdviceInfo) {
		// 任务的创建者和更新者默认为系统管理员
		User adminUser = UserUtils.get("1");
		cashAdviceInfo.setCreateBy(adminUser);
		cashAdviceInfo.setUpdateBy(adminUser);
		
		super.save(cashAdviceInfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(CashAdviceInfo cashAdviceInfo) {
		super.delete(cashAdviceInfo);
	}

	public List<CashAdviceInfo> findInfoByParam(String provisionsId, String adviceType) {
		CashAdviceInfo cashAdviceInfo = new CashAdviceInfo();
		cashAdviceInfo.setProvisionsId(provisionsId);
		cashAdviceInfo.setAdviceType(adviceType);
		return cashAdviceInfoDao.findInfoByParam(cashAdviceInfo);
	}

	public String countNdInfo(String provisionsId, String dealState, String adviceType) {
		CashAdviceInfo cashAdviceInfo = new CashAdviceInfo();
		cashAdviceInfo.setProvisionsId(provisionsId);
		cashAdviceInfo.setDealState(dealState);
		cashAdviceInfo.setAdviceType(adviceType);
		return cashAdviceInfoDao.countNdInfo(cashAdviceInfo)==null?"0":cashAdviceInfoDao.countNdInfo(cashAdviceInfo);
	}
	
}