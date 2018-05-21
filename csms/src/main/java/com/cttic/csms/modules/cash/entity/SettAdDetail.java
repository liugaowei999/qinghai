/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.cash.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.Office;

/**
 * 同步备付金账户金额--差错数据Entity
 * @author wanglk
 * @version 2016-11-26
 */
public class SettAdDetail extends DataEntity<SettAdDetail> {
	
	private static final long serialVersionUID = 1L;
	private String settDate;		// sett_date
	private String recvOrgCode;		// recv_org_code
	private String fileName;		// file_name
	private String settChangeNo;		// sett_change_no
	private String oriSettDate;		// ori_sett_date
	private String oriSettOrgNo;		// ori_sett_org_no
	private String oriBillOrgNo;		// ori_bill_org_no
	private String oriBillDealDate;		// ori_bill_deal_date
	private String oriRetrievNo;		// ori_retriev_no
	private String oriTradeType;		// ori_trade_type
	private String adjustType;		// adjust_type
	private String cardNo;		// card_no
	private String issueOrgCode;		// issue_org_code
	private String recvOrgCode1;		// recv_org_code1
	private String billOrgCode;		// bill_org_code
	private String sendOrgId;		// send_org_id
	private String errOriOrgId;		// err_ori_org_id
	private String errConfirmOrgId;		// err_confirm_org_id
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
	private String responseCode;		// response_code
	private String errCode;		// err_code
	private String errInfo;		// err_info
	private Long errCharge;		// err_charge
	private Double settCharge;		// sett_charge
	private Double issueCharge;		// issue_charge
	private Double billCharge;		// bill_charge
	private String dealTime;		// deal_time
	private String indbTime;		// indb_time
	private Office company; 
	private String beginDate;
	private String endDate;
	
	public SettAdDetail() {
		super();
	}

	public SettAdDetail(String id){
		super(id);
	}
	
	public Office getCompany() {
		return company;
	}

	public void setCompany(Office company) {
		this.company = company;
	}

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}
	
	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
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
	
	@Length(min=0, max=12, message="sett_change_no长度必须介于 0 和 12 之间")
	public String getSettChangeNo() {
		return settChangeNo;
	}

	public void setSettChangeNo(String settChangeNo) {
		this.settChangeNo = settChangeNo;
	}
	
	@Length(min=0, max=8, message="ori_sett_date长度必须介于 0 和 8 之间")
	public String getOriSettDate() {
		return oriSettDate;
	}

	public void setOriSettDate(String oriSettDate) {
		this.oriSettDate = oriSettDate;
	}
	
	@Length(min=0, max=12, message="ori_sett_org_no长度必须介于 0 和 12 之间")
	public String getOriSettOrgNo() {
		return oriSettOrgNo;
	}

	public void setOriSettOrgNo(String oriSettOrgNo) {
		this.oriSettOrgNo = oriSettOrgNo;
	}
	
	@Length(min=0, max=12, message="ori_bill_org_no长度必须介于 0 和 12 之间")
	public String getOriBillOrgNo() {
		return oriBillOrgNo;
	}

	public void setOriBillOrgNo(String oriBillOrgNo) {
		this.oriBillOrgNo = oriBillOrgNo;
	}
	
	@Length(min=0, max=8, message="ori_bill_deal_date长度必须介于 0 和 8 之间")
	public String getOriBillDealDate() {
		return oriBillDealDate;
	}

	public void setOriBillDealDate(String oriBillDealDate) {
		this.oriBillDealDate = oriBillDealDate;
	}
	
	@Length(min=0, max=12, message="ori_retriev_no长度必须介于 0 和 12 之间")
	public String getOriRetrievNo() {
		return oriRetrievNo;
	}

	public void setOriRetrievNo(String oriRetrievNo) {
		this.oriRetrievNo = oriRetrievNo;
	}
	
	@Length(min=0, max=4, message="ori_trade_type长度必须介于 0 和 4 之间")
	public String getOriTradeType() {
		return oriTradeType;
	}

	public void setOriTradeType(String oriTradeType) {
		this.oriTradeType = oriTradeType;
	}
	
	@Length(min=0, max=1, message="adjust_type长度必须介于 0 和 1 之间")
	public String getAdjustType() {
		return adjustType;
	}

	public void setAdjustType(String adjustType) {
		this.adjustType = adjustType;
	}
	
	@Length(min=0, max=20, message="card_no长度必须介于 0 和 20 之间")
	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	
	@Length(min=0, max=11, message="issue_org_code长度必须介于 0 和 11 之间")
	public String getIssueOrgCode() {
		return issueOrgCode;
	}

	public void setIssueOrgCode(String issueOrgCode) {
		this.issueOrgCode = issueOrgCode;
	}
	
	@Length(min=0, max=11, message="recv_org_code1长度必须介于 0 和 11 之间")
	public String getRecvOrgCode1() {
		return recvOrgCode1;
	}

	public void setRecvOrgCode1(String recvOrgCode1) {
		this.recvOrgCode1 = recvOrgCode1;
	}
	
	@Length(min=0, max=11, message="bill_org_code长度必须介于 0 和 11 之间")
	public String getBillOrgCode() {
		return billOrgCode;
	}

	public void setBillOrgCode(String billOrgCode) {
		this.billOrgCode = billOrgCode;
	}
	
	@Length(min=0, max=11, message="send_org_id长度必须介于 0 和 11 之间")
	public String getSendOrgId() {
		return sendOrgId;
	}

	public void setSendOrgId(String sendOrgId) {
		this.sendOrgId = sendOrgId;
	}
	
	@Length(min=0, max=11, message="err_ori_org_id长度必须介于 0 和 11 之间")
	public String getErrOriOrgId() {
		return errOriOrgId;
	}

	public void setErrOriOrgId(String errOriOrgId) {
		this.errOriOrgId = errOriOrgId;
	}
	
	@Length(min=0, max=11, message="err_confirm_org_id长度必须介于 0 和 11 之间")
	public String getErrConfirmOrgId() {
		return errConfirmOrgId;
	}

	public void setErrConfirmOrgId(String errConfirmOrgId) {
		this.errConfirmOrgId = errConfirmOrgId;
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
	
	@Length(min=0, max=2, message="response_code长度必须介于 0 和 2 之间")
	public String getResponseCode() {
		return responseCode;
	}

	public void setResponseCode(String responseCode) {
		this.responseCode = responseCode;
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
	
	public Long getErrCharge() {
		return errCharge;
	}

	public void setErrCharge(Long errCharge) {
		this.errCharge = errCharge;
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