/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.cash.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 备付金缴存周期变更Entity
 * @author aryo
 * @version 2016-11-25
 */
public class CashPayPeriodRecord extends DataEntity<CashPayPeriodRecord> {
	
	private static final long serialVersionUID = 1L;
	private String periodId;            // 记录ID
	private String provisionsId;		// 备付金帐号
	private String oriPayPeriod;		// 原缴存周期
	private String curPayPeriod;		// 现缴存周期
	private String modifyStatus;		// 审批状态
	private Double neePayMoney;		// 需缴存金额
	private String payPeriodFlag;		// 是否缴存
	private String examineStatus;
	private String provisionsNo;
	private String periodStatus;// 审核状态
	
	public CashPayPeriodRecord() {
		super();
	}

	public String getPeriodId() {
		return periodId;
	}

	public void setPeriodId(String periodId) {
		this.periodId = periodId;
	}

	@Length(min=1, max=64, message="备付金帐号表编号长度必须介于 1 和 64 之间")
	public String getProvisionsId() {
		return provisionsId;
	}

	public void setProvisionsId(String provisionsId) {
		this.provisionsId = provisionsId;
	}
	
	@Length(min=1, max=1, message="原缴存周期长度必须介于 1 和 1 之间")
	public String getOriPayPeriod() {
		return oriPayPeriod;
	}

	public void setOriPayPeriod(String oriPayPeriod) {
		this.oriPayPeriod = oriPayPeriod;
	}
	
	@Length(min=1, max=1, message="现缴存周期长度必须介于 1 和 1 之间")
	public String getCurPayPeriod() {
		return curPayPeriod;
	}

	public void setCurPayPeriod(String curPayPeriod) {
		this.curPayPeriod = curPayPeriod;
	}
	
	@Length(min=1, max=10, message="审批状态长度必须介于 1 和 10 之间")
	public String getModifyStatus() {
		return modifyStatus;
	}

	public void setModifyStatus(String modifyStatus) {
		this.modifyStatus = modifyStatus;
	}
	
	@Length(min=0, max=32, message="需缴存金额长度必须介于 0 和 32 之间")
	public Double getNeePayMoney() {
		return neePayMoney;
	}

	public void setNeePayMoney(Double neePayMoney) {
		this.neePayMoney = neePayMoney;
	}
	
	@Length(min=1, max=1, message="是否缴存长度必须介于 1 和 1 之间")
	public String getPayPeriodFlag() {
		return payPeriodFlag;
	}

	public void setPayPeriodFlag(String payPeriodFlag) {
		this.payPeriodFlag = payPeriodFlag;
	}
	
	@Length(min=0, max=1, message="审核状态长度必须介于 0 和 1 之间")
	public String getExamineStatus() {
		return examineStatus;
	}

	public void setExamineStatus(String examineStatus) {
		this.examineStatus = examineStatus;
	}

	public String getProvisionsNo() {
		return provisionsNo;
	}

	public void setProvisionsNo(String provisionsNo) {
		this.provisionsNo = provisionsNo;
	}

	public String getPeriodStatus() {
		return periodStatus;
	}

	public void setPeriodStatus(String periodStatus) {
		this.periodStatus = periodStatus;
	}
	
	
	
}