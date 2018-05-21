package com.cttic.csms.modules.cash.entity;

import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 备付金缴存记录－实体
 * @author ambitious
 * @version 2016-11-24
 */
public class CashPayRecord extends DataEntity<CashPayRecord> {
	
	private static final long serialVersionUID = -182888090203011089L;
	
	private CashProvisions cashProvisions; // 备付金帐号实体
	
	private Double payMoney;		// 缴存金额
	private String payState;		// 缴存状态
	private String officeName;		// 所属组织名称
	
	private Date beginDate;	// 开始时间
	private Date endDate;	// 结束时间
	
	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public CashPayRecord() {
		super();
	}

	public CashPayRecord(String id){
		super(id);
	}
	
	public CashProvisions getCashProvisions() {
		return cashProvisions;
	}

	public void setCashProvisions(CashProvisions cashProvisions) {
		this.cashProvisions = cashProvisions;
	}

	@NotNull(message="缴存金额不能为空")
	public Double getPayMoney() {
		return payMoney;
	}

	public void setPayMoney(Double payMoney) {
		this.payMoney = payMoney;
	}
	
	public String getPayState() {
		return payState;
	}

	public void setPayState(String payState) {
		this.payState = payState;
	}
	
	@Length(min=1, max=100, message="所属组织名称长度必须介于 1 和 100 之间")
	public String getOfficeName() {
		return officeName;
	}

	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}
	
}