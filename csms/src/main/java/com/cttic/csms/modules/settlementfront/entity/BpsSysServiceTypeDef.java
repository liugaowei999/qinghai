/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 业务类型定义Entity
 * @author aryo
 * @version 2016-12-03
 */
public class BpsSysServiceTypeDef extends DataEntity<BpsSysServiceTypeDef> {
	
	private static final long serialVersionUID = 1L;
	private String serviceType;		// service_type
	private String serviceName;		// service_name
	private String remark;		// remark
	private String dealFlag;		// deal_flag
	
	public BpsSysServiceTypeDef() {
		super();
	}

	public BpsSysServiceTypeDef(String id){
		super(id);
	}

	@Length(min=1, max=32, message="service_type长度必须介于 1 和 32 之间")
	public String getServiceType() {
		return serviceType;
	}

	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}
	
	@Length(min=0, max=128, message="service_name长度必须介于 0 和 128 之间")
	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
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
	
}