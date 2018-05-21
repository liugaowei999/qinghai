/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.cash.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 备付金开户Entity
 * @author wanglk
 * @version 2016-11-24
 */
public class CashProvisions extends DataEntity<CashProvisions> {
	
	private static final long serialVersionUID = 1L;
	private String provisionsNo;		// 备付金帐号
	private String bankcardNo;		// 银行卡号
	private String payPeriod;		// 缴存周期
	private Double deposite;		// 押金
	private Double totalAmount;		// 总额
	private Double remainingSum;		// 可用余额
	private Double withdrawDeposite;		// 可提现金额
	private Double needPay;		// 应付清算金额
	private String userId;		// 关联的系统用户
	
	private User user;
	private Office company;
	
	public CashProvisions() {
		super();
	}

	public CashProvisions(String id){
		super(id);
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public Office getCompany() {
		return company;
	}

	public void setCompany(Office company) {
		this.company = company;
	}

	@Length(min=1, max=64, message="备付金帐号长度必须介于 1 和 64 之间")
	public String getProvisionsNo() {
		return provisionsNo;
	}

	public void setProvisionsNo(String provisionsNo) {
		this.provisionsNo = provisionsNo;
	}
	
	@Length(min=1, max=64, message="银行卡号长度必须介于 1 和 64 之间")
	public String getBankcardNo() {
		return bankcardNo;
	}

	public void setBankcardNo(String bankcardNo) {
		this.bankcardNo = bankcardNo;
	}
	
	@Length(min=1, max=1, message="缴存周期长度必须介于 1 和 1 之间")
	public String getPayPeriod() {
		return payPeriod;
	}

	public void setPayPeriod(String payPeriod) {
		this.payPeriod = payPeriod;
	}
	
	public Double getDeposite() {
		return deposite;
	}

	public void setDeposite(Double deposite) {
		this.deposite = deposite;
	}
	
	public Double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(Double totalAmount) {
		this.totalAmount = totalAmount;
	}
	
	public Double getRemainingSum() {
		return remainingSum;
	}

	public void setRemainingSum(Double remainingSum) {
		this.remainingSum = remainingSum;
	}
	
	public Double getWithdrawDeposite() {
		return withdrawDeposite;
	}

	public void setWithdrawDeposite(Double withdrawDeposite) {
		this.withdrawDeposite = withdrawDeposite;
	}
	
	public Double getNeedPay() {
		return needPay;
	}

	public void setNeedPay(Double needPay) {
		this.needPay = needPay;
	}
	
	@Length(min=1, max=64, message="关联的系统用户长度必须介于 1 和 64 之间")
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
 
	
}