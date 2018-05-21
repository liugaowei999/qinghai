/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.Office;

/**
 * CL脱机消费明细详单Entity
 * @author wanglk
 * @version 2016-12-05
 */
public class SettCl extends DataEntity<SettCl> {
	
	private static final long serialVersionUID = 1L;
	private String settDate;		// sett_date
	private String recvOrgCode;		// recv_org_code
	private String fileName;		// file_name
	private String settOrgNo;		// sett_org_no
	private String billOrgNo;		// bill_org_no
	private String billDealDate;		// bill_deal_date
	private String retrievNo;		// retriev_no
	private String tradeType;		// trade_type
	private String billOrgId;		// bill_org_id
	private String billOrgCode;		// bill_org_code
	private String issueCompanyCode;		// issue_company_code
	private String recvOrgCode1;		// recv_org_code1
	private String sendOrgId;		// send_org_id
	private String mcc;		// mcc
	private String channelType;		// channel_type
	private String cardNo;		// card_no
	private Integer cardCount;		// card_count
	private Long beforetradeCharge;		// beforetrade_charge
	private Long tradeCharge;		// trade_charge
	private String tradeDate;		// trade_date
	private String tradeTime;		// trade_time
	private String balanceType;		// balance_type
	private String algorithmId;		// algorithm_id
	private String errCode;		// err_code
	private String errInfo;		// err_info
	private String testFlag;		// test_flag
	private Double settCharge;		// sett_charge
	private Double issueCharge;		// issue_charge
	private Double billCharge;		// bill_charge
	private String reserved;		// reserved
	private String tlvData;		// tlv_data
	private String dealTime;		// deal_time
	private String indbTime;		// indb_time
	
	private Office company; 
	private String tableName;
	
	
	public SettCl() {
		super();
	}

	public SettCl(String id){
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
	
	@Length(min=0, max=12, message="sett_org_no长度必须介于 0 和 12 之间")
	public String getSettOrgNo() {
		return settOrgNo;
	}

	public void setSettOrgNo(String settOrgNo) {
		this.settOrgNo = settOrgNo;
	}
	
	@Length(min=0, max=12, message="bill_org_no长度必须介于 0 和 12 之间")
	public String getBillOrgNo() {
		return billOrgNo;
	}

	public void setBillOrgNo(String billOrgNo) {
		this.billOrgNo = billOrgNo;
	}
	
	@Length(min=0, max=8, message="bill_deal_date长度必须介于 0 和 8 之间")
	public String getBillDealDate() {
		return billDealDate;
	}

	public void setBillDealDate(String billDealDate) {
		this.billDealDate = billDealDate;
	}
	
	@Length(min=0, max=12, message="retriev_no长度必须介于 0 和 12 之间")
	public String getRetrievNo() {
		return retrievNo;
	}

	public void setRetrievNo(String retrievNo) {
		this.retrievNo = retrievNo;
	}
	
	@Length(min=0, max=4, message="trade_type长度必须介于 0 和 4 之间")
	public String getTradeType() {
		return tradeType;
	}

	public void setTradeType(String tradeType) {
		this.tradeType = tradeType;
	}
	
	@Length(min=0, max=11, message="bill_org_id长度必须介于 0 和 11 之间")
	public String getBillOrgId() {
		return billOrgId;
	}

	public void setBillOrgId(String billOrgId) {
		this.billOrgId = billOrgId;
	}
	
	@Length(min=0, max=11, message="bill_org_code长度必须介于 0 和 11 之间")
	public String getBillOrgCode() {
		return billOrgCode;
	}

	public void setBillOrgCode(String billOrgCode) {
		this.billOrgCode = billOrgCode;
	}
	
	@Length(min=0, max=11, message="issue_company_code长度必须介于 0 和 11 之间")
	public String getIssueCompanyCode() {
		return issueCompanyCode;
	}

	public void setIssueCompanyCode(String issueCompanyCode) {
		this.issueCompanyCode = issueCompanyCode;
	}
	
	@Length(min=0, max=11, message="recv_org_code1长度必须介于 0 和 11 之间")
	public String getRecvOrgCode1() {
		return recvOrgCode1;
	}

	public void setRecvOrgCode1(String recvOrgCode1) {
		this.recvOrgCode1 = recvOrgCode1;
	}
	
	@Length(min=0, max=11, message="send_org_id长度必须介于 0 和 11 之间")
	public String getSendOrgId() {
		return sendOrgId;
	}

	public void setSendOrgId(String sendOrgId) {
		this.sendOrgId = sendOrgId;
	}
	
	@Length(min=0, max=4, message="mcc长度必须介于 0 和 4 之间")
	public String getMcc() {
		return mcc;
	}

	public void setMcc(String mcc) {
		this.mcc = mcc;
	}
	
	@Length(min=0, max=2, message="channel_type长度必须介于 0 和 2 之间")
	public String getChannelType() {
		return channelType;
	}

	public void setChannelType(String channelType) {
		this.channelType = channelType;
	}
	
	@Length(min=0, max=20, message="card_no长度必须介于 0 和 20 之间")
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
	
	@Length(min=0, max=8, message="trade_date长度必须介于 0 和 8 之间")
	public String getTradeDate() {
		return tradeDate;
	}

	public void setTradeDate(String tradeDate) {
		this.tradeDate = tradeDate;
	}
	
	@Length(min=0, max=6, message="trade_time长度必须介于 0 和 6 之间")
	public String getTradeTime() {
		return tradeTime;
	}

	public void setTradeTime(String tradeTime) {
		this.tradeTime = tradeTime;
	}
	
	@Length(min=0, max=1, message="balance_type长度必须介于 0 和 1 之间")
	public String getBalanceType() {
		return balanceType;
	}

	public void setBalanceType(String balanceType) {
		this.balanceType = balanceType;
	}
	
	@Length(min=0, max=2, message="algorithm_id长度必须介于 0 和 2 之间")
	public String getAlgorithmId() {
		return algorithmId;
	}

	public void setAlgorithmId(String algorithmId) {
		this.algorithmId = algorithmId;
	}
	
	@Length(min=0, max=6, message="err_code长度必须介于 0 和 6 之间")
	public String getErrCode() {
		return errCode;
	}

	public void setErrCode(String errCode) {
		this.errCode = errCode;
	}
	
	@Length(min=0, max=40, message="err_info长度必须介于 0 和 40 之间")
	public String getErrInfo() {
		return errInfo;
	}

	public void setErrInfo(String errInfo) {
		this.errInfo = errInfo;
	}
	
	@Length(min=0, max=1, message="test_flag长度必须介于 0 和 1 之间")
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
	
	@Length(min=0, max=28, message="reserved长度必须介于 0 和 28 之间")
	public String getReserved() {
		return reserved;
	}

	public void setReserved(String reserved) {
		this.reserved = reserved;
	}
	
	@Length(min=0, max=1024, message="tlv_data长度必须介于 0 和 1024 之间")
	public String getTlvData() {
		return tlvData;
	}

	public void setTlvData(String tlvData) {
		this.tlvData = tlvData;
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