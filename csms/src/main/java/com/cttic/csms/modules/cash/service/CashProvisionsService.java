/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.cash.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cttic.csms.modules.cash.dao.CashProvisionsDao;
import com.cttic.csms.modules.cash.entity.CashProvisions;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 备付金开户Service
 * @author wanglk
 * @version 2016-11-24
 */
@Service
@Transactional(readOnly = true)
public class CashProvisionsService extends CrudService<CashProvisionsDao, CashProvisions> {
	
	@Autowired 
	CashProvisionsDao cashProvisionsDao;
	
	public CashProvisions get(String id) {
		return super.get(id);
	}
	
	public List<CashProvisions> findList(CashProvisions cashProvisions) {
		return super.findList(cashProvisions);
	}
	
	public Page<CashProvisions> findPage(Page<CashProvisions> page, CashProvisions cashProvisions) {
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		cashProvisions.getSqlMap().put("dsf", dataScopeFilter(cashProvisions.getCurrentUser(), "o", "u"));
		return super.findPage(page, cashProvisions);
	}
	
	@Transactional(readOnly = false)
	public void save(CashProvisions cashProvisions) {
		super.save(cashProvisions);
	}
	
	@Transactional(readOnly = false)
	public void delete(CashProvisions cashProvisions) {
		super.delete(cashProvisions);
	}
	
	/**
	 * 根据当前登录用户（组织机构），获取备付金帐号信息
	 * @return
	 */
	public Map<String, String> getByCurLoginUser() {
		CashProvisions cashProvisions = new CashProvisions();
		
		User user = UserUtils.getUser();
		if(user != null && StringUtils.isNotBlank(user.getId())) 
			cashProvisions.setUserId(user.getId());
		
		List<CashProvisions> provisionList = super.findList(cashProvisions);
		Map<String, String> resultMap = new HashMap<String,String>();
		for (CashProvisions provision : provisionList) {
			resultMap.put(provision.getId(), provision.getProvisionsNo());
		}
		//Map<String, String> resultMap = provisionList.stream().collect(Collectors.toMap(CashProvisions::getId, CashProvisions::getProvisionsNo));
		return resultMap;
	}
	
	public void updateAmount(CashProvisions cashProvisions) {
		cashProvisionsDao.updateAmount(cashProvisions);
	}

	public void updateAfterPay(CashProvisions cp) {
		cashProvisionsDao.updateAfterPay(cp);
	}
	
}