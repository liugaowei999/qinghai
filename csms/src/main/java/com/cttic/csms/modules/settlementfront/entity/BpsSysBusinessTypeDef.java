/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 清算费率配置Entity
 * @author aryo
 * @version 2016-12-03
 */
public class BpsSysBusinessTypeDef extends DataEntity<BpsSysBusinessTypeDef> {
	
	private static final long serialVersionUID = 1L;
	private String businessType;		// business_type
	private String businessName;		// business_name
	private String remark;		// remark
	private String dealFlag;		// deal_flag
	
	private User user;
	
	public BpsSysBusinessTypeDef() {
		super();
	}

	public BpsSysBusinessTypeDef(String id){
		super(id);
	}

	@Length(min=1, max=32, message="business_type长度必须介于 1 和 32 之间")
	public String getBusinessType() {
		return businessType;
	}

	public void setBusinessType(String businessType) {
		this.businessType = businessType;
	}
	
	@Length(min=0, max=128, message="business_name长度必须介于 0 和 128 之间")
	public String getBusinessName() {
		return businessName;
	}

	public void setBusinessName(String businessName) {
		this.businessName = businessName;
	}
	
	@Length(min=0, max=512, message="remark长度必须介于 0 和 512 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	@Length(min=0, max=1, message="deal_flag长度必须介于 0 和 1 之间")
	public String getDealFlag() {
		return dealFlag;
	}

	public void setDealFlag(String dealFlag) {
		this.dealFlag = dealFlag;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
}