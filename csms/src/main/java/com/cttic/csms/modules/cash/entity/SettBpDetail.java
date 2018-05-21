/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.cash.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.Office;

/**
 * 同步备付金账户金额Entity
 * @author wanglk
 * @version 2016-11-26
 */
public class SettBpDetail extends DataEntity<SettBpDetail> {
	
	private static final long serialVersionUID = 1L;
	private String settDate;		// sett_date
	private String recvOrgCode;		// recv_org_code
	private String fileName;		// file_name
	private Long incomeCharge;		// income_charge
	private Long payCharge;		// pay_charge
	private Long testIncomeCharge;		// test_income_charge
	private Long testPayCharge;		// test_pay_charge
	private Long depositChangeCharge;		// deposit_change_charge
	private String chargeSign;		// charge_sign
	private String dealTime;		// deal_time
	private String indbTime;		// indb_time
	private Office company;
	private String beginDate;
	private String endDate;
	
	public SettBpDetail() {
		super();
	}

	public SettBpDetail(String id){
		super(id);
	}
	
	public Office getCompany() {
		return company;
	}

	public void setCompany(Office company) {
		this.company = company;
	}
	
	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}
	
	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
	@Length(min=0, max=8, message="sett_date长度必须介于 0 和 8 之间")
	public String getSettDate() {
		return settDate;
	}

	public void setSettDate(String settDate) {
		this.settDate = settDate;
	}
	
	@Length(min=0, max=11, message="recv_org_code长度必须介于 0 和 11 之间")
	public String getRecvOrgCode() {
		return recvOrgCode;
	}

	public void setRecvOrgCode(String recvOrgCode) {
		this.recvOrgCode = recvOrgCode;
	}
	
	@Length(min=0, max=128, message="file_name长度必须介于 0 和 128 之间")
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public Long getIncomeCharge() {
		return incomeCharge;
	}

	public void setIncomeCharge(Long incomeCharge) {
		this.incomeCharge = incomeCharge;
	}
	
	public Long getPayCharge() {
		return payCharge;
	}

	public void setPayCharge(Long payCharge) {
		this.payCharge = payCharge;
	}
	
	public Long getTestIncomeCharge() {
		return testIncomeCharge;
	}

	public void setTestIncomeCharge(Long testIncomeCharge) {
		this.testIncomeCharge = testIncomeCharge;
	}
	
	public Long getTestPayCharge() {
		return testPayCharge;
	}

	public void setTestPayCharge(Long testPayCharge) {
		this.testPayCharge = testPayCharge;
	}
	
	public Long getDepositChangeCharge() {
		return depositChangeCharge;
	}

	public void setDepositChangeCharge(Long depositChangeCharge) {
		this.depositChangeCharge = depositChangeCharge;
	}
	
	@Length(min=0, max=10, message="charge_sign长度必须介于 0 和 10 之间")
	public String getChargeSign() {
		return chargeSign;
	}

	public void setChargeSign(String chargeSign) {
		this.chargeSign = chargeSign;
	}
	
	@Length(min=0, max=14, message="deal_time长度必须介于 0 和 14 之间")
	public String getDealTime() {
		return dealTime;
	}

	public void setDealTime(String dealTime) {
		this.dealTime = dealTime;
	}
	
	@Length(min=0, max=14, message="indb_time长度必须介于 0 和 14 之间")
	public String getIndbTime() {
		return indbTime;
	}

	public void setIndbTime(String indbTime) {
		this.indbTime = indbTime;
	}
	
}