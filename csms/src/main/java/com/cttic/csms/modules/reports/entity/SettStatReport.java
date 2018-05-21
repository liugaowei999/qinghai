/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.reports.entity;

import java.text.DecimalFormat;
import java.text.NumberFormat;


import org.hibernate.validator.constraints.Length;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.Office;

/**
 * 结算报表展示Entity
 * @author wanglk
 * @version 2016-12-21
 */
public class SettStatReport extends DataEntity<SettStatReport> {
	
	private static final long serialVersionUID = 1L;
	private String settType;		// 结算类型
	private String settTypeName;   //结算类型名称
	public String getSettTypeName() {
		return settTypeName;
	}

	public void setSettTypeName(String settTypeName) {
		this.settTypeName = settTypeName;
	}

	private String settDate;		// 结算日期
	private String orgCode;		// 机构代码
	private String orgName;		// 机构名称
	private Double incomeCharge;		// 收入金额
	private Double outcomeCharge;		// 支出金额
	private Double offsetBalance;		// 轧差
	private String note;		// 结算说明
	private String beginSettDate;		// 开始 结算日期
	private String endSettDate;		// 结束 结算日期
	private Office company;
	
	private DecimalFormat df=new DecimalFormat("##############.#################");
	
	
	public SettStatReport() {
		super();
	}

	public SettStatReport(String id){
		super(id);
	}
	
	public Office getCompany() {
		return company;
	}

	public void setCompany(Office company) {
		this.company = company;
	}

	@Length(min=1, max=32, message="结算类型长度必须介于 1 和 32 之间")
	@ExcelField(title="结算类型", align=2, sort=2, dictType="sett_type")
	public String getSettType() {
		return settType;
	}

	public void setSettType(String settType) {
		this.settType = settType;
	}
	
	@Length(min=1, max=8, message="结算日期长度必须介于 1 和 8 之间")
	@ExcelField(title="结算日期", align=2, sort=1)
	public String getSettDate() {
		return settDate;
	}

	public void setSettDate(String settDate) {
		this.settDate = settDate;
	}
	
	@Length(min=0, max=32, message="机构代码长度必须介于 0 和 32 之间")
	@ExcelField(title="机构代码", align=2, sort=3)
	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}
	
	@Length(min=0, max=64, message="机构名称长度必须介于 0 和 64 之间")
	@ExcelField(title="机构名称", align=2, sort=4)
	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	
	@ExcelField(title="收入金额(元)", align=2, sort=5)
	public String getIncomeCharge() {
		df.setGroupingUsed(false); 
		return df.format(incomeCharge);
	}

	public void setIncomeCharge(Double incomeCharge) {
		this.incomeCharge = incomeCharge;
	}
	
	@ExcelField(title="支出金额(元)", align=2, sort=6)
	public String getOutcomeCharge() {
		df.setGroupingUsed(false); 
		return df.format(outcomeCharge);
	}

	public void setOutcomeCharge(Double outcomeCharge) {
		this.outcomeCharge = outcomeCharge;
	}
	
	@ExcelField(title="轧差(元)", align=2, sort=7)
	public String getOffsetBalance() {
		df.setGroupingUsed(false); 
		return df.format(offsetBalance);
	}

	public void setOffsetBalance(Double offsetBalance) {
		this.offsetBalance = offsetBalance;
	}
	
	@Length(min=0, max=1024, message="结算说明长度必须介于 0 和 1024 之间")
	@ExcelField(title="结算说明", align=2, sort=8)
	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
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