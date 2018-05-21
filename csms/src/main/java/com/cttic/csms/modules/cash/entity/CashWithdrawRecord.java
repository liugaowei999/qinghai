/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.cash.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 备付金提现记录Entity
 * @author aryo
 * @version 2016-11-24
 */
public class CashWithdrawRecord extends DataEntity<CashWithdrawRecord> {
	
	private static final long serialVersionUID = 1L;
	private String withdrawId;
	private String provisionsId;		// 备付金帐号
	private Double withdrawDeposite;		// 提现金额
	private Double preWithdrawDeposite;		// 提现前金额
	private Double nextWithdrawDeposite;		// 提现后金额
	private String withdrawType;		// 提现类型（0:自动划拨，1:申请提现）
	private String withdrawState;		// 提现状态（0:正在提现，1:已提现，2:提现失败）
	private String provisionsNo;
	private String createName;
	
	public CashWithdrawRecord() {
		super();
	}
	
	public String getWithdrawId() {
		return withdrawId;
	}

	public void setWithdrawId(String withdrawId) {
		this.withdrawId = withdrawId;
	}

	@Length(min=1, max=64, message="备付金帐号表编号长度必须介于 1 和 64 之间")
	public String getProvisionsId() {
		return provisionsId;
	}

	public void setProvisionsId(String provisionsId) {
		this.provisionsId = provisionsId;
	}
	
	public Double getWithdrawDeposite() {
		return withdrawDeposite;
	}

	public void setWithdrawDeposite(Double withdrawDeposite) {
		this.withdrawDeposite = withdrawDeposite;
	}
	
	public Double getPreWithdrawDeposite() {
		return preWithdrawDeposite;
	}

	public void setPreWithdrawDeposite(Double preWithdrawDeposite) {
		this.preWithdrawDeposite = preWithdrawDeposite;
	}
	
	public Double getNextWithdrawDeposite() {
		return nextWithdrawDeposite;
	}

	public void setNextWithdrawDeposite(Double nextWithdrawDeposite) {
		this.nextWithdrawDeposite = nextWithdrawDeposite;
	}
	
	@Length(min=1, max=1, message="提现类型（0:自动划拨，1:申请提现）长度必须介于 1 和 1 之间")
	public String getWithdrawType() {
		return withdrawType;
	}

	public void setWithdrawType(String withdrawType) {
		this.withdrawType = withdrawType;
	}
	
	@Length(min=1, max=1, message="提现状态（0:正在提现，1:已提现，2:提现失败）长度必须介于 1 和 1 之间")
	public String getWithdrawState() {
		return withdrawState;
	}

	public void setWithdrawState(String withdrawState) {
		this.withdrawState = withdrawState;
	}

	public String getProvisionsNo() {
		return provisionsNo;
	}

	public void setProvisionsNo(String provisionsNo) {
		this.provisionsNo = provisionsNo;
	}

	public String getCreateName() {
		return createName;
	}

	public void setCreateName(String createName) {
		this.createName = createName;
	}
	
}