/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.Office;

/**
 * ED差错处理文件Entity
 * @author wanglk
 * @version 2016-12-15
 */
public class SettEd extends DataEntity<SettEd> {
	
	private static final long serialVersionUID = 1L;
	private String sendOrgCode;		// send_org_code
	private String fileName;		// file_name
	private String settDate;		// sett_date
	private String settOrgNo;		// sett_org_no
	private String billOrgNo;		// bill_org_no
	private String billOrgDealDate;		// bill_org_deal_date
	private String tradeRetrievNo;		// trade_retriev_no
	private String adjustType;		// adjust_type
	private String errType;		// err_type
	private String cardNo;		// card_no
	private Integer cardCount;		// card_count
	private Long beforetradeCharge;		// beforetrade_charge
	private String adjustedTradeType;		// adjusted_trade_type
	private Long adjustedTradeCharge;		// adjusted_trade_charge
	private String mcc;		// mcc
	private String channelType;		// channel_type
	private String tradeDate;		// trade_date
	private String tradeTime;		// trade_time
	private String testFlag;		// test_flag
	private String causeCode;		// cause_code
	private String errOriOrgCode;		// err_ori_org_code
	private String issueOrgCode;		// issue_org_code
	private String billOrgId;		// bill_org_id
	private String dealTime;		// deal_time
	private String indbTime;		// indb_time
	private String dealFlag;		// 0-未处理; 1-确认同意; 2-确认不同意;
	private String dealNote;		// 确认处理备注
	
	private Office company; 
	private String tableName;
	private Office sendOrg;
	private Office errOriOrg;
	private Office issueOrg;
	private Office billOrg;
	
	public Office getSendOrg() {
		return sendOrg;
	}

	public void setSendOrg(Office sendOrg) {
		this.sendOrg = sendOrg;
	}

	public Office getErrOriOrg() {
		return errOriOrg;
	}

	public void setErrOriOrg(Office errOriOrg) {
		this.errOriOrg = errOriOrg;
	}

	public Office getIssueOrg() {
		return issueOrg;
	}

	public void setIssueOrg(Office issueOrg) {
		this.issueOrg = issueOrg;
	}

	public Office getBillOrg() {
		return billOrg;
	}

	public void setBillOrg(Office billOrg) {
		this.billOrg = billOrg;
	}

	
	
	public SettEd() {
		super();
	}

	public SettEd(String id){
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

	@Length(min=0, max=11, message="send_org_code长度必须介于 0 和 11 之间")
	public String getSendOrgCode() {
		return sendOrgCode;
	}

	public void setSendOrgCode(String sendOrgCode) {
		this.sendOrgCode = sendOrgCode;
	}
	
	@Length(min=0, max=128, message="file_name长度必须介于 0 和 128 之间")
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	@Length(min=0, max=8, message="sett_date长度必须介于 0 和 8 之间")
	public String getSettDate() {
		return settDate;
	}

	public void setSettDate(String settDate) {
		this.settDate = settDate;
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
	
	@Length(min=0, max=8, message="bill_org_deal_date长度必须介于 0 和 8 之间")
	public String getBillOrgDealDate() {
		return billOrgDealDate;
	}

	public void setBillOrgDealDate(String billOrgDealDate) {
		this.billOrgDealDate = billOrgDealDate;
	}
	
	@Length(min=0, max=12, message="trade_retriev_no长度必须介于 0 和 12 之间")
	public String getTradeRetrievNo() {
		return tradeRetrievNo;
	}

	public void setTradeRetrievNo(String tradeRetrievNo) {
		this.tradeRetrievNo = tradeRetrievNo;
	}
	
	@Length(min=0, max=1, message="adjust_type长度必须介于 0 和 1 之间")
	public String getAdjustType() {
		return adjustType;
	}

	public void setAdjustType(String adjustType) {
		this.adjustType = adjustType;
	}
	
	@Length(min=0, max=4, message="err_type长度必须介于 0 和 4 之间")
	public String getErrType() {
		return errType;
	}

	public void setErrType(String errType) {
		this.errType = errType;
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
	
	@Length(min=0, max=4, message="adjusted_trade_type长度必须介于 0 和 4 之间")
	public String getAdjustedTradeType() {
		return adjustedTradeType;
	}

	public void setAdjustedTradeType(String adjustedTradeType) {
		this.adjustedTradeType = adjustedTradeType;
	}
	
	public Long getAdjustedTradeCharge() {
		return adjustedTradeCharge;
	}

	public void setAdjustedTradeCharge(Long adjustedTradeCharge) {
		this.adjustedTradeCharge = adjustedTradeCharge;
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
	
	@Length(min=0, max=1, message="test_flag长度必须介于 0 和 1 之间")
	public String getTestFlag() {
		return testFlag;
	}

	public void setTestFlag(String testFlag) {
		this.testFlag = testFlag;
	}
	
	@Length(min=0, max=4, message="cause_code长度必须介于 0 和 4 之间")
	public String getCauseCode() {
		return causeCode;
	}

	public void setCauseCode(String causeCode) {
		this.causeCode = causeCode;
	}
	
	@Length(min=0, max=11, message="err_ori_org_code长度必须介于 0 和 11 之间")
	public String getErrOriOrgCode() {
		return errOriOrgCode;
	}

	public void setErrOriOrgCode(String errOriOrgCode) {
		this.errOriOrgCode = errOriOrgCode;
	}
	
	@Length(min=0, max=11, message="issue_org_code长度必须介于 0 和 11 之间")
	public String getIssueOrgCode() {
		return issueOrgCode;
	}

	public void setIssueOrgCode(String issueOrgCode) {
		this.issueOrgCode = issueOrgCode;
	}
	
	@Length(min=0, max=11, message="bill_org_id长度必须介于 0 和 11 之间")
	public String getBillOrgId() {
		return billOrgId;
	}

	public void setBillOrgId(String billOrgId) {
		this.billOrgId = billOrgId;
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
	
	@Length(min=0, max=1, message="0-未处理; 1-确认同意; 2-确认不同意;长度必须介于 0 和 1 之间")
	public String getDealFlag() {
		return dealFlag;
	}

	public void setDealFlag(String dealFlag) {
		this.dealFlag = dealFlag;
	}
	
	@Length(min=0, max=512, message="确认处理备注长度必须介于 0 和 512 之间")
	public String getDealNote() {
		return dealNote;
	}

	public void setDealNote(String dealNote) {
		this.dealNote = dealNote;
	}
	
}