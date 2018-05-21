/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.Office;

/**
 * FB清算反馈文件详单Entity
 * @author wanglk
 * @version 2016-12-05
 */
public class SettFb extends DataEntity<SettFb> {
	
	private static final long serialVersionUID = 1L;
	private String settDate;		// 清算日期
	private String recvOrgCode;		// 接收机构代码
	private String fileName;		// 文件名称
	private String settOrgNo;		// 清分结算机构流水号
	private String billOrgNo;		// 收单机构流水号
	private String billDealDate;		// 收单机构受理日期
	private String retrievNo;		// 检索参考号
	private String tradeType;		// 交易类型
	private String recvOrgId;		// 接收清算机构标识
	private String issueCompanyCode;		// 发卡地通卡公司代码
	private String billOrgId;		// 收单机构标识码
	private String sendOrgId;		// 发送机构代码
	private String mcc;		// MCC
	private String channelType;		// 渠道类型
	private String cardNo;		// 卡号
	private Integer cardCount;		// 卡消费计数器
	private Long beforetradeCharge;		// 消费前卡余额
	private Long tradeCharge;		// 交易金额
	private String tradeDate;		// 交易日期
	private String tradeTime;		// 交易时间
	private String errCode;		// 错误代码
	private String errInfo;		// 错误描述
	private String testFlag;		// 测试标志
	private Double settCharge;		// 手续费
	private Double issueCharge;		// 发卡分润
	private Double billCharge;		// 收单分润
	private String dealTime;		// 处理时间
	private String indbTime;		// 入库时间
	
	private Office company; 
	private String tableName;
	
	public SettFb() {
		super();
	}

	public SettFb(String id){
		super(id);
	}
	
	public Office getCompany() {
		return company;
	}

	public void setCompany(Office company) {
		this.company = company;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	@Length(min=0, max=8, message="清算日期长度必须介于 0 和 8 之间")
	public String getSettDate() {
		return settDate;
	}

	public void setSettDate(String settDate) {
		this.settDate = settDate;
	}
	
	@Length(min=0, max=11, message="接收机构代码长度必须介于 0 和 11 之间")
	public String getRecvOrgCode() {
		return recvOrgCode;
	}

	public void setRecvOrgCode(String recvOrgCode) {
		this.recvOrgCode = recvOrgCode;
	}
	
	@Length(min=0, max=128, message="文件名称长度必须介于 0 和 128 之间")
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	@Length(min=0, max=12, message="清分结算机构流水号长度必须介于 0 和 12 之间")
	public String getSettOrgNo() {
		return settOrgNo;
	}

	public void setSettOrgNo(String settOrgNo) {
		this.settOrgNo = settOrgNo;
	}
	
	@Length(min=0, max=12, message="收单机构流水号长度必须介于 0 和 12 之间")
	public String getBillOrgNo() {
		return billOrgNo;
	}

	public void setBillOrgNo(String billOrgNo) {
		this.billOrgNo = billOrgNo;
	}
	
	@Length(min=0, max=8, message="收单机构受理日期长度必须介于 0 和 8 之间")
	public String getBillDealDate() {
		return billDealDate;
	}

	public void setBillDealDate(String billDealDate) {
		this.billDealDate = billDealDate;
	}
	
	@Length(min=0, max=12, message="检索参考号长度必须介于 0 和 12 之间")
	public String getRetrievNo() {
		return retrievNo;
	}

	public void setRetrievNo(String retrievNo) {
		this.retrievNo = retrievNo;
	}
	
	@Length(min=0, max=4, message="交易类型长度必须介于 0 和 4 之间")
	public String getTradeType() {
		return tradeType;
	}

	public void setTradeType(String tradeType) {
		this.tradeType = tradeType;
	}
	
	@Length(min=0, max=11, message="接收清算机构标识长度必须介于 0 和 11 之间")
	public String getRecvOrgId() {
		return recvOrgId;
	}

	public void setRecvOrgId(String recvOrgId) {
		this.recvOrgId = recvOrgId;
	}
	
	@Length(min=0, max=11, message="发卡地通卡公司代码长度必须介于 0 和 11 之间")
	public String getIssueCompanyCode() {
		return issueCompanyCode;
	}

	public void setIssueCompanyCode(String issueCompanyCode) {
		this.issueCompanyCode = issueCompanyCode;
	}
	
	@Length(min=0, max=11, message="收单机构标识码长度必须介于 0 和 11 之间")
	public String getBillOrgId() {
		return billOrgId;
	}

	public void setBillOrgId(String billOrgId) {
		this.billOrgId = billOrgId;
	}
	
	@Length(min=0, max=11, message="发送机构代码长度必须介于 0 和 11 之间")
	public String getSendOrgId() {
		return sendOrgId;
	}

	public void setSendOrgId(String sendOrgId) {
		this.sendOrgId = sendOrgId;
	}
	
	@Length(min=0, max=4, message="MCC长度必须介于 0 和 4 之间")
	public String getMcc() {
		return mcc;
	}

	public void setMcc(String mcc) {
		this.mcc = mcc;
	}
	
	@Length(min=0, max=2, message="渠道类型长度必须介于 0 和 2 之间")
	public String getChannelType() {
		return channelType;
	}

	public void setChannelType(String channelType) {
		this.channelType = channelType;
	}
	
	@Length(min=0, max=20, message="卡号长度必须介于 0 和 20 之间")
	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	
	public Integer getCardCount() {
		return cardCount;
	}

	public void setCardCount(Integer cardCount) {
		this.cardCount = cardCount;
	}
	
	public Long getBeforetradeCharge() {
		return beforetradeCharge;
	}

	public void setBeforetradeCharge(Long beforetradeCharge) {
		this.beforetradeCharge = beforetradeCharge;
	}
	
	public Long getTradeCharge() {
		return tradeCharge;
	}

	public void setTradeCharge(Long tradeCharge) {
		this.tradeCharge = tradeCharge;
	}
	
	@Length(min=0, max=8, message="交易日期长度必须介于 0 和 8 之间")
	public String getTradeDate() {
		return tradeDate;
	}

	public void setTradeDate(String tradeDate) {
		this.tradeDate = tradeDate;
	}
	
	@Length(min=0, max=6, message="交易时间长度必须介于 0 和 6 之间")
	public String getTradeTime() {
		return tradeTime;
	}

	public void setTradeTime(String tradeTime) {
		this.tradeTime = tradeTime;
	}
	
	@Length(min=0, max=6, message="错误代码长度必须介于 0 和 6 之间")
	public String getErrCode() {
		return errCode;
	}

	public void setErrCode(String errCode) {
		this.errCode = errCode;
	}
	
	@Length(min=0, max=40, message="错误描述长度必须介于 0 和 40 之间")
	public String getErrInfo() {
		return errInfo;
	}

	public void setErrInfo(String errInfo) {
		this.errInfo = errInfo;
	}
	
	@Length(min=0, max=1, message="测试标志长度必须介于 0 和 1 之间")
	public String getTestFlag() {
		return testFlag;
	}

	public void setTestFlag(String testFlag) {
		this.testFlag = testFlag;
	}
	
	public Double getSettCharge() {
		return settCharge;
	}

	public void setSettCharge(Double settCharge) {
		this.settCharge = settCharge;
	}
	
	public Double getIssueCharge() {
		return issueCharge;
	}

	public void setIssueCharge(Double issueCharge) {
		this.issueCharge = issueCharge;
	}
	
	public Double getBillCharge() {
		return billCharge;
	}

	public void setBillCharge(Double billCharge) {
		this.billCharge = billCharge;
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