package com.cttic.csms.modules.cash.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cttic.csms.common.constants.DictCash;
import com.cttic.csms.modules.cash.dao.CashPayRecordDao;
import com.cttic.csms.modules.cash.entity.CashPayRecord;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 备付金缴存相关功能Service
 * @author ambitious
 * @version 2016-11-24
 */
@Service
@Transactional(readOnly = true)
public class CashPayRecordService extends CrudService<CashPayRecordDao, CashPayRecord> {

	public CashPayRecord get(String id) {
		return super.get(id);
	}
	
	public List<CashPayRecord> findList(CashPayRecord cashPayRecord) {
		// 若当前用户是管理员，查询所有
		if (UserUtils.getUser().isAdmin()){
			cashPayRecord.setOfficeName(null);
		}
		return super.findList(cashPayRecord);
	}
	
	public Page<CashPayRecord> findPage(Page<CashPayRecord> page, CashPayRecord cashPayRecord) {
//		// 若当前用户是管理员，查询所有
//		if (UserUtils.getUser().isAdmin()){
//			cashPayRecord.setOfficeName(null);
//		}
		return super.findPage(page, cashPayRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(CashPayRecord cashPayRecord) {
		if(StringUtils.isBlank(cashPayRecord.getOfficeName())) {
			cashPayRecord.setOfficeName(UserUtils.getCurOfficeName());
		}
		super.save(cashPayRecord);
	}
	
	/**
	 * 缴存逻辑处理
	 * @param cashPayRecord
	 */
	public boolean payProcess(CashPayRecord cashPayRecord) {
		//调用银行接口
		boolean invokeFlagSuccess = invokeBankInterface(cashPayRecord);
		//若调用银行接口没响应，直接返回失败标记
		if(!invokeFlagSuccess) {
			cashPayRecord.setPayState(DictCash.CASH_PAY_STATUS_FAIL);
			return false;
		}
		//保存缴费记录
		save(cashPayRecord);
		return true;
	}
	
	/**
	 * 调用银行接口
	 * @param cashPayRecord
	 */
	private boolean invokeBankInterface(CashPayRecord cashPayRecord) {
		// 1.按照与银行约定的格式，拼装报文
		// 2.发送报文
		// 3.返回调用状态
		return true;
	}
	
	@Transactional(readOnly = false)
	public void delete(CashPayRecord cashPayRecord) {
		super.delete(cashPayRecord);
	}
	
}