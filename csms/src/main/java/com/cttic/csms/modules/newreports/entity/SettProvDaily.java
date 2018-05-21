/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.newreports.entity;

import java.text.DecimalFormat;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 跨省日统计报表Entity
 * @author aryo
 * @version 2017-03-07
 */
public class SettProvDaily extends DataEntity<SettProvDaily> {
	
	private static final long serialVersionUID = 1L;
	private String settDate;		// sett_date
	private String settObject;		// sett_object
	private String settRole;		// sett_role
	private Double tradeCharge;		// trade_charge
	private Double serviceCharge;		// service_charge
	private Double issueCharge;		// issue_charge
	private Double billCharge;		// bill_charge
	private Double centerCharge;		// center_charge
	private Integer times;		// times
	private Double settCharge;		// sett_charge
	private String beginSettDate;
	private String endSettDate;
	
	private DecimalFormat df=new DecimalFormat("##############.#################");
	
	public SettProvDaily() {
		super();
	}

	public SettProvDaily(String id){
		super(id);
	}

	@Length(min=0, max=8, message="sett_date长度必须介于 0 和 8 之间")
	@ExcelField(title="结算日期", align=2, sort=1)
	public String getSettDate() {
		return settDate;
	}

	public void setSettDate(String settDate) {
		this.settDate = settDate;
	}
	
	@Length(min=0, max=64, message="sett_object长度必须介于 0 和 64 之间")
	@ExcelField(title="结算对象", align=2, sort=2)
	public String getSettObject() {
		return settObject;
	}

	public void setSettObject(String settObject) {
		this.settObject = settObject;
	}
	
	@Length(min=0, max=32, message="sett_role长度必须介于 0 和 32 之间")
	@ExcelField(title="结算角色", align=2, sort=3)
	public String getSettRole() {
		return settRole;
	}

	public void setSettRole(String settRole) {
		this.settRole = settRole;
	}
	
	@ExcelField(title="消费金额(元)", align=2, sort=4)
	public String getTradeCharge() {
		df.setGroupingUsed(false); 
		return df.format(tradeCharge);
	}

	public void setTradeCharge(Double tradeCharge) {
		this.tradeCharge = tradeCharge;
	}
	
	@ExcelField(title="手续费(元)", align=2, sort=5)
	public String getServiceCharge() {
		df.setGroupingUsed(false); 
		return df.format(serviceCharge);
	}

	public void setServiceCharge(Double serviceCharge) {
		this.serviceCharge = serviceCharge;
	}
	
	@ExcelField(title="发卡分润(元)", align=2, sort=6)
	public String getIssueCharge() {
		df.setGroupingUsed(false); 
		return df.format(issueCharge);
	}

	public void setIssueCharge(Double issueCharge) {
		this.issueCharge = issueCharge;
	}
	
	@ExcelField(title="收单分润(元)", align=2, sort=7)
	public String getBillCharge() {
		df.setGroupingUsed(false); 
		return df.format(billCharge);
	}

	public void setBillCharge(Double billCharge) {
		this.billCharge = billCharge;
	}
	
	@ExcelField(title="清算中心分润(元)", align=2, sort=8)
	public String getCenterCharge() {
		df.setGroupingUsed(false); 
		return df.format(centerCharge);
	}

	public void setCenterCharge(Double centerCharge) {
		this.centerCharge = centerCharge;
	}
	
	@ExcelField(title="次数", align=2, sort=9)
	public Integer getTimes() {
		return times;
	}

	public void setTimes(Integer times) {
		this.times = times;
	}
	
	@ExcelField(title="结算金额(元)", align=2, sort=10)
	public String getSettCharge() {
		df.setGroupingUsed(false); 
		return df.format(settCharge);
	}

	public void setSettCharge(Double settCharge) {
		this.settCharge = settCharge;
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