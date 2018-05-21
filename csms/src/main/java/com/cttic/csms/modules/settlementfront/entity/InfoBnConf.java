/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.Office;

/**
 * 对BN白名单进行配置Entity
 * @author ambitious
 * @version 2016-12-03
 */
public class InfoBnConf extends DataEntity<InfoBnConf> {
	
	private static final long serialVersionUID = 1L;
	private String downDate;		// 下发日期
	private String fileName;		// 文件名称
	private String issueOrgCode;		// 发卡机构代码
	private String cardBinNo;		// 卡BIN
	private String dealTime;		// 处理时间
	private String indbTime;		// 入库时间
	private Office company; 
	
	public InfoBnConf() {
		super();
	}

	public InfoBnConf(String id){
		super(id);
	}
	
	public Office getCompany() {
		return company;
	}

	public void setCompany(Office company) {
		this.company = company;
	}

	
	@Length(min=0, max=8, message="下发日期长度必须介于 0 和 8 之间")
	public String getDownDate() {
		return downDate;
	}

	public void setDownDate(String downDate) {
		this.downDate = downDate;
	}
	
	@Length(min=0, max=128, message="文件名称长度必须介于 0 和 128 之间")
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	@Length(min=0, max=11, message="发卡机构代码长度必须介于 0 和 11 之间")
	public String getIssueOrgCode() {
		return issueOrgCode;
	}

	public void setIssueOrgCode(String issueOrgCode) {
		this.issueOrgCode = issueOrgCode;
	}
	
	@Length(min=0, max=10, message="卡BIN长度必须介于 0 和 10 之间")
	public String getCardBinNo() {
		return cardBinNo;
	}

	public void setCardBinNo(String cardBinNo) {
		this.cardBinNo = cardBinNo;
	}
	
	@Length(min=0, max=14, message="处理时间长度必须介于 0 和 14 之间")
	public String getDealTime() {
		return dealTime;
	}

	public void setDealTime(String dealTime) {
		this.dealTime = dealTime;
	}
	
	@Length(min=0, max=14, message="入库时间长度必须介于 0 和 14 之间")
	public String getIndbTime() {
		return indbTime;
	}

	public void setIndbTime(String indbTime) {
		this.indbTime = indbTime;
	}
	
}