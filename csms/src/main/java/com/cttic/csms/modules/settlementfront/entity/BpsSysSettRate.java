/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 清算费率配置Entity
 * @author aryo
 * @version 2016-12-03
 */
public class BpsSysSettRate extends DataEntity<BpsSysSettRate> {
	
	private static final long serialVersionUID = 1L;
	private String businessType;		// -1：所有行业1：交通行业2：其他行业
	private String serviceType;		// 01: 公交车02: 地铁03: 自行车租赁04：出租车-1：所有业务（不区分业务类型）
	private String recvOrgCode;		// 收单方机构代码。-1：不区分收单方，收单分润费率适用于所有收单机构
	private String issueOrgCode;		// 发卡方机构代码。-1：不区分发卡方，发卡分润费率适用于所有发卡机构
	private String chargeRate;		// charge_rate
	private String recvRate;		// recv_rate
	private String issueRate;		// issue_rate
	private Date effDate;		// eff_date
	private Date expDate;		// exp_date
	private String remark;		// remark
	private String dealFlag;		// deal_flag
	private String businessName;
	private String serviceName;
	private String recvOrgName;
	private String issueOrgName;
	
	public BpsSysSettRate() {
		super();
	}

	public BpsSysSettRate(String id){
		super(id);
	}

	@Length(min=1, max=32, message="-1：所有行业1：交通行业2：其他行业长度必须介于 1 和 32 之间")
	public String getBusinessType() {
		return businessType;
	}

	public void setBusinessType(String businessType) {
		this.businessType = businessType;
	}
	
	@Length(min=1, max=8, message="01: 公交车02: 地铁03: 自行车租赁04：出租车-1：所有业务（不区分业务类型）长度必须介于 1 和 8 之间")
	public String getServiceType() {
		return serviceType;
	}

	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}
	
	@Length(min=1, max=32, message="收单方机构代码。-1：不区分收单方，收单分润费率适用于所有收单机构长度必须介于 1 和 32 之间")
	public String getRecvOrgCode() {
		return recvOrgCode;
	}

	public void setRecvOrgCode(String recvOrgCode) {
		this.recvOrgCode = recvOrgCode;
	}
	
	@Length(min=1, max=32, message="发卡方机构代码。-1：不区分发卡方，发卡分润费率适用于所有发卡机构长度必须介于 1 和 32 之间")
	public String getIssueOrgCode() {
		return issueOrgCode;
	}

	public void setIssueOrgCode(String issueOrgCode) {
		this.issueOrgCode = issueOrgCode;
	}
	
	@Length(min=0, max=12, message="charge_rate长度必须介于 0 和 12 之间")
	public String getChargeRate() {
		return chargeRate;
	}

	public void setChargeRate(String chargeRate) {
		this.chargeRate = chargeRate;
	}
	
	@Length(min=0, max=12, message="recv_rate长度必须介于 0 和 12 之间")
	public String getRecvRate() {
		return recvRate;
	}

	public void setRecvRate(String recvRate) {
		this.recvRate = recvRate;
	}
	
	@Length(min=0, max=12, message="issue_rate长度必须介于 0 和 12 之间")
	public String getIssueRate() {
		return issueRate;
	}

	public void setIssueRate(String issueRate) {
		this.issueRate = issueRate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="eff_date不能为空")
	public Date getEffDate() {
		return effDate;
	}

	public void setEffDate(Date effDate) {
		this.effDate = effDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getExpDate() {
		return expDate;
	}

	public void setExpDate(Date expDate) {
		this.expDate = expDate;
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

	public String getBusinessName() {
		return businessName;
	}

	public void setBusinessName(String businessName) {
		this.businessName = businessName;
	}

	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	public String getRecvOrgName() {
		return recvOrgName;
	}

	public void setRecvOrgName(String recvOrgName) {
		this.recvOrgName = recvOrgName;
	}

	public String getIssueOrgName() {
		return issueOrgName;
	}

	public void setIssueOrgName(String issueOrgName) {
		this.issueOrgName = issueOrgName;
	}
	
	
	
}