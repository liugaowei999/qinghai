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
 * 省内结算报表展示Entity
 * @author wanglk
 * @version 2016-12-22
 */
public class SettCityStatDetail extends DataEntity<SettCityStatDetail> {
	
	private static final long serialVersionUID = 1L;
	private String settDate;		// 结算日期
	private String settOrgCode;		// 结算对象
	private Integer settDirection;		// 结算方向
	private String settDirectionName;  //结算方向名称
	private Integer roleType;		// 角色
	private String issueCode;		// 发卡机构代码
	private String issueOrgName;		// 发卡机构名称
	private String billCode;		// 收单机构代码
	private String billOrgName;		// 收单机构名称
	private Double tradeCharge;		// 交易金额
	private Double serviceFee;		// 手续费
	private Double issueCharge;		// 发卡分润
	private Double billCharge;		// 收单分润
	private Double centerCharge;		// 清算中心分润
	private Double settCharge;		// 结算费用
	private String beginSettDate;		// 开始 结算日期
	private String endSettDate;		// 结束 结算日期
	private String actualIssueCode;        //实际发卡机构代码
	private String actualIssueName;     //实际发卡机构名称
	private Double times;          //发卡次数
	private Office company; 
	
	private DecimalFormat df=new DecimalFormat("##############.#################");
	
	public SettCityStatDetail() {
		super();
	}

	public SettCityStatDetail(String id){
		super(id);
	}
	@ExcelField(title="结算对象", align=2, sort=2, value="company.name")
	public Office getCompany() {
		return company;
	}

	public void setCompany(Office company) {
		this.company = company;
	}
	
	@Length(min=0, max=8, message="结算日期长度必须介于 0 和 8 之间")
	@ExcelField(title="结算日期", align=2, sort=1)
	public String getSettDate() {
		return settDate;
	}

	public void setSettDate(String settDate) {
		this.settDate = settDate;
	}
	
	@Length(min=0, max=32, message="结算对象长度必须介于 0 和 32 之间")
	public String getSettOrgCode() {
		return settOrgCode;
	}

	public void setSettOrgCode(String settOrgCode) {
		this.settOrgCode = settOrgCode;
	}
	@ExcelField(title="结算方向", align=2, sort=3, dictType="sett_direction")
	public Integer getSettDirection() {
		return settDirection;
	}
	
	public void setSettDirection(Integer settDirection) {
		this.settDirection = settDirection;
	}
	@ExcelField(title="角色", align=2, sort=4, dictType="sett_role_type")
	public Integer getRoleType() {
		return roleType;
	}
	
	public void setRoleType(Integer roleType) {
		this.roleType = roleType;
	}
	
	@Length(min=0, max=32, message="发卡机构代码长度必须介于 0 和 32 之间")
	public String getIssueCode() {
		return issueCode;
	}

	public void setIssueCode(String issueCode) {
		this.issueCode = issueCode;
	}
	
	@Length(min=0, max=64, message="发卡机构名称长度必须介于 0 和 64 之间")
	@ExcelField(title="发卡机构名称", align=2, sort=5)
	public String getIssueOrgName() {
		return issueOrgName;
	}

	public void setIssueOrgName(String issueOrgName) {
		this.issueOrgName = issueOrgName;
	}
	
	@Length(min=0, max=32, message="收单机构代码长度必须介于 0 和 32 之间")
	public String getBillCode() {
		return billCode;
	}

	public void setBillCode(String billCode) {
		this.billCode = billCode;
	}
	
	@Length(min=0, max=64, message="收单机构名称长度必须介于 0 和 64 之间")
	@ExcelField(title="收单机构名称", align=2, sort=6)
	public String getBillOrgName() {
		return billOrgName;
	}

	public void setBillOrgName(String billOrgName) {
		this.billOrgName = billOrgName;
	}
	@ExcelField(title="交易金额(元)", align=2, sort=7)
	public String getTradeCharge() {
		df.setGroupingUsed(false); 
		return df.format(tradeCharge);
	}

	public void setTradeCharge(Double tradeCharge) {
		this.tradeCharge = tradeCharge;
	}
	@ExcelField(title="手续费(元)", align=2, sort=8)
	public String getServiceFee() {
		df.setGroupingUsed(false); 
		return df.format(serviceFee);
	}
	
	public void setServiceFee(Double serviceFee) {
		this.serviceFee = serviceFee;
	}
	@ExcelField(title="发卡元润(元)", align=2, sort=9)
	public String getIssueCharge() {
		df.setGroupingUsed(false); 
		return df.format(issueCharge);
	}
	
	public void setIssueCharge(Double issueCharge) {
		this.issueCharge = issueCharge;
	}
	@ExcelField(title="收单分润(元)", align=2, sort=10)
	public String getBillCharge() {
		df.setGroupingUsed(false); 
		return df.format(billCharge);
	}

	public void setBillCharge(Double billCharge) {
		this.billCharge = billCharge;
	}
	@ExcelField(title="结算中心分润(元)", align=2, sort=11)
	public String getCenterCharge() {
		df.setGroupingUsed(false); 
		return df.format(centerCharge);
	}

	public void setCenterCharge(Double centerCharge) {
		this.centerCharge = centerCharge;
	}
	@ExcelField(title="结算费用(元)", align=2, sort=12)
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
	
	public String getActualIssueCode() {
		return actualIssueCode;
	}

	public void setActualIssueCode(String actualIssueCode) {
		this.actualIssueCode = actualIssueCode;
	}

	
	public String getActualIssueName() {
		return actualIssueName;
	}

	public void setActualIssueName(String actualIssueName) {
		this.actualIssueName = actualIssueName;
	}

	public Double getTimes() {
		return times;
	}

	public void setTimes(Double times) {
		this.times = times;
	}

	public String getSettDirectionName() {
		return settDirectionName;
	}

	public void setSettDirectionName(String settDirectionName) {
		this.settDirectionName = settDirectionName;
	}

	
	
		
}