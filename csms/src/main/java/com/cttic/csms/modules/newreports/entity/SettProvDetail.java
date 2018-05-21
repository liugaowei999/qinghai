/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.newreports.entity;

import java.text.DecimalFormat;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 跨省结算详单展示Entity
 * @author aryo
 * @version 2017-03-07
 */
public class SettProvDetail extends DataEntity<SettProvDetail> {
	
	private static final long serialVersionUID = 1L;
	private String settDate;		// sett_date
	private String tradeType;		// trade_type
	private String issueOrgCode;		// issue_org_code
	private String billOrgCode;		// bill_org_code
	private String issueOrgName;		// issue_org_code
	private String billOrgName;		// bill_org_code
	private String cardNo;		// card_no
	private String beforeTradeCharge;		// before_trade_charge
	private Double tradeCharge;		// trade_charge
	private String tradeDate;		// trade_date
	private String tradeTime;		// trade_time
	private Double serviceCharge;		// service_charge
	private Double issueCharge;		// issue_charge
	private Double billCharge;		// bill_charge
	private Double centerCharge;		// center_charge
	private Double settCharge;		// sett_charge
	private String beginSettDate;
	private String endSettDate;
	
	private DecimalFormat df=new DecimalFormat("##############.#################");
	
	@Length(min=0, max=8, message="sett_date长度必须介于 0 和 8 之间")
	@ExcelField(title="结算日期", align=2, sort=1)
	public String getSettDate() {
		return settDate;
	}

	public void setSettDate(String settDate) {
		this.settDate = settDate;
	}
	
	@Length(min=0, max=3, message="trade_type长度必须介于 0 和 3 之间")
	@ExcelField(title="交易类型", align=2, sort=2)
	public String getTradeType() {
		return tradeType;
	}

	public void setTradeType(String tradeType) {
		this.tradeType = tradeType;
	}
	
	@Length(min=0, max=11, message="issue_org_code长度必须介于 0 和 11 之间")
	@ExcelField(title="发卡机构名称", align=2, sort=3)
	public String getIssueOrgCode() {
		return issueOrgCode;
	}

	public void setIssueOrgCode(String issueOrgCode) {
		this.issueOrgCode = issueOrgCode;
	}
	
	@Length(min=0, max=11, message="bill_org_code长度必须介于 0 和 11 之间")
	@ExcelField(title="收单机构名称", align=2, sort=4)
	public String getBillOrgCode() {
		return billOrgCode;
	}

	public void setBillOrgCode(String billOrgCode) {
		this.billOrgCode = billOrgCode;
	}
	
	@Length(min=0, max=20, message="card_no长度必须介于 0 和 20 之间")
	@ExcelField(title="卡号", align=2, sort=5)
	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	
	@Length(min=0, max=8, message="before_trade_charge长度必须介于 0 和 8 之间")
	@ExcelField(title="消费前金额(元)", align=2, sort=6)
	public String getBeforeTradeCharge() {
		return beforeTradeCharge;
	}

	public void setBeforeTradeCharge(String beforeTradeCharge) {
		this.beforeTradeCharge = beforeTradeCharge;
	}
	
	@ExcelField(title="消费金额(元)", align=2, sort=7)
	public String getTradeCharge() {
		df.setGroupingUsed(false); 
		return df.format(tradeCharge);
	}

	public void setTradeCharge(Double tradeCharge) {
		this.tradeCharge = tradeCharge;
	}
	
	@Length(min=0, max=8, message="trade_date长度必须介于 0 和 8 之间")
	@ExcelField(title="消费日期", align=2, sort=8)
	public String getTradeDate() {
		return tradeDate;
	}

	public void setTradeDate(String tradeDate) {
		this.tradeDate = tradeDate;
	}
	
	@Length(min=0, max=8, message="trade_time长度必须介于 0 和 8 之间")
	@ExcelField(title="消费时间", align=2, sort=9)
	public String getTradeTime() {
		return tradeTime;
	}

	public void setTradeTime(String tradeTime) {
		this.tradeTime = tradeTime;
	}
	
	@ExcelField(title="手续费(元)", align=2, sort=10)
	public String getServiceCharge() {
		df.setGroupingUsed(false); 
		return df.format(serviceCharge);
	}

	public void setServiceCharge(Double serviceCharge) {
		this.serviceCharge = serviceCharge;
	}
	
	@ExcelField(title="发卡分润(元)", align=2, sort=11)
	public String getIssueCharge() {
		df.setGroupingUsed(false); 
		return df.format(issueCharge);
	}

	public void setIssueCharge(Double issueCharge) {
		this.issueCharge = issueCharge;
	}
	
	@ExcelField(title="收单分润(元)", align=2, sort=12)
	public String getBillCharge() {
		df.setGroupingUsed(false); 
		return df.format(billCharge);
	}

	public void setBillCharge(Double billCharge) {
		this.billCharge = billCharge;
	}
	
	@ExcelField(title="清算中心分润(元)", align=2, sort=13)
	public String getCenterCharge() {
		df.setGroupingUsed(false); 
		return df.format(centerCharge);
	}

	public void setCenterCharge(Double centerCharge) {
		this.centerCharge = centerCharge;
	}
	
	@ExcelField(title="结算金额(元)", align=2, sort=14)
	public String getSettCharge() {
		df.setGroupingUsed(false); 
		return df.format(settCharge);
	}

	public void setSettCharge(Double settCharge) {
		this.settCharge = settCharge;
	}

	//@ExcelField(title="发卡机构名称", align=2, sort=3)
	public String getIssueOrgName() {
		return issueOrgName;
	}

	public void setIssueOrgName(String issueOrgName) {
		this.issueOrgName = issueOrgName;
	}

	//@ExcelField(title="收单机构名称", align=2, sort=4)
	public String getBillOrgName() {
		return billOrgName;
	}

	public void setBillOrgName(String billOrgName) {
		this.billOrgName = billOrgName;
	}

	public String getBeginSettDate() {
		return beginSettDate;
	}

	public void setBeginSettDate(String beginSettDate) {
		this.beginSettDate = beginSettDate;
	}

	public String getEndSettDate() {
		return endSettDate;
	}

	public void setEndSettDate(String endSettDate) {
		this.endSettDate = endSettDate;
	}
	
}