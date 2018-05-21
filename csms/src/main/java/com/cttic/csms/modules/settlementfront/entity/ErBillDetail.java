/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.entity;

import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 省内地市结算异常记录Entity
 * @author aryo
 * @version 2016-12-23
 */
public class ErBillDetail extends DataEntity<ErBillDetail> {

	private static final long serialVersionUID = 1L;
	private String drType; // dr_type
	private String settDate; // sett_date

	private String tradeCode; // trade_code

	private Double tradeCharge; // trade_charge

	private String transTime; // trans_time
	private String traceNo; // trace_no

	private String recvOrgId; // recv_org_id
	private String sendOrgId; // send_org_id
	private String sellerType; // seller_type

	private String acquirerId; // acquirer_id
	private String acquirerAddr; // acquirer_addr
	private String billOrgCode;
	private String issueOrgCode; // issue_org_code

	private String cardNo; // card_no
	private String terminalId;
	private String tradeDate; // trade_date
	private String tradeTime; // trade_time

	private String roamType; // roam_type

	private Double serviceFee; // service_fee
	private Double issueFee; // issue_fee
	private Double billFee; // bill_fee
	private String sysErrorCode; // sys_error_code
	private String sysErrorMsg; // sys_error_msg
	private String dealTime; // deal_time
	private Date indbTime; // indb_time
	private Double otherFee; // other_fee
	private Double beforetradeChargeDec; // beforetrade_charge_dec
	private String tableName; // 错单表 ER_BILL
	private String fbTableName; // FB表 SETT_FB_
	private String drTableName; // 详单表 DR_BILL
	private String sendOrgName;

	public String getSendOrgName() {
		return sendOrgName;
	}

	public void setSendOrgName(String sendOrgName) {
		this.sendOrgName = sendOrgName;
	}

	public String getDrTableName() {
		return drTableName;
	}

	public void setDrTableName(String drTableName) {
		this.drTableName = drTableName;
	}

	public String getFbTableName() {
		return fbTableName;
	}

	public void setFbTableName(String fbTableName) {
		this.fbTableName = fbTableName;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public ErBillDetail() {
		super();
	}

	public ErBillDetail(String id) {
		super(id);
	}

	public String getDrType() {
		return drType;
	}

	public void setDrType(String drType) {
		this.drType = drType;
	}

	public String getSettDate() {
		return settDate;
	}

	public void setSettDate(String settDate) {
		this.settDate = settDate;
	}

	public String getTradeCode() {
		return tradeCode;
	}

	public void setTradeCode(String tradeCode) {
		this.tradeCode = tradeCode;
	}

	public Double getTradeCharge() {
		return tradeCharge;
	}

	public void setTradeCharge(Double tradeCharge) {
		this.tradeCharge = tradeCharge;
	}

	public void setBeforetradeChargeDec(Double beforetradeChargeDec) {
		this.beforetradeChargeDec = beforetradeChargeDec;
	}

	public String getTransTime() {
		return transTime;
	}

	public void setTransTime(String transTime) {
		this.transTime = transTime;
	}

	public String getTraceNo() {
		return traceNo;
	}

	public void setTraceNo(String traceNo) {
		this.traceNo = traceNo;
	}

	public String getRecvOrgId() {
		return recvOrgId;
	}

	public void setRecvOrgId(String recvOrgId) {
		this.recvOrgId = recvOrgId;
	}

	public String getSendOrgId() {
		return sendOrgId;
	}

	public void setSendOrgId(String sendOrgId) {
		this.sendOrgId = sendOrgId;
	}

	public String getSellerType() {
		return sellerType;
	}

	public void setSellerType(String sellerType) {
		this.sellerType = sellerType;
	}

	public String getAcquirerId() {
		return acquirerId;
	}

	public void setAcquirerId(String acquirerId) {
		this.acquirerId = acquirerId;
	}

	public String getAcquirerAddr() {
		return acquirerAddr;
	}

	public void setAcquirerAddr(String acquirerAddr) {
		this.acquirerAddr = acquirerAddr;
	}

	public String getIssueOrgCode() {
		return issueOrgCode;
	}

	public void setIssueOrgCode(String issueOrgCode) {
		this.issueOrgCode = issueOrgCode;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getTradeDate() {
		return tradeDate;
	}

	public void setTradeDate(String tradeDate) {
		this.tradeDate = tradeDate;
	}

	public String getTradeTime() {
		return tradeTime;
	}

	public void setTradeTime(String tradeTime) {
		this.tradeTime = tradeTime;
	}

	public Double getBeforetradeChargeDec() {
		return beforetradeChargeDec;
	}

	public String getRoamType() {
		return roamType;
	}

	public void setRoamType(String roamType) {
		this.roamType = roamType;
	}

	public Double getServiceFee() {
		return serviceFee;
	}

	public void setServiceFee(Double serviceFee) {
		this.serviceFee = serviceFee;
	}

	public Double getIssueFee() {
		return issueFee;
	}

	public void setIssueFee(Double issueFee) {
		this.issueFee = issueFee;
	}

	public Double getBillFee() {
		return billFee;
	}

	public void setBillFee(Double billFee) {
		this.billFee = billFee;
	}

	public String getSysErrorCode() {
		return sysErrorCode;
	}

	public void setSysErrorCode(String sysErrorCode) {
		this.sysErrorCode = sysErrorCode;
	}

	public String getSysErrorMsg() {
		return sysErrorMsg;
	}

	public void setSysErrorMsg(String sysErrorMsg) {
		this.sysErrorMsg = sysErrorMsg;
	}

	public String getDealTime() {
		return dealTime;
	}

	public void setDealTime(String dealTime) {
		this.dealTime = dealTime;
	}

	public Date getIndbTime() {
		return indbTime;
	}

	public void setIndbTime(Date indbTime) {
		this.indbTime = indbTime;
	}

	public Double getOtherFee() {
		return otherFee;
	}

	public void setOtherFee(Double otherFee) {
		this.otherFee = otherFee;
	}

	public String getTerminalId() {
		return terminalId;
	}

	public void setTerminalId(String terminalId) {
		this.terminalId = terminalId;
	}

	public String getBillOrgCode() {
		return billOrgCode;
	}

	public void setBillOrgCode(String billOrgCode) {
		this.billOrgCode = billOrgCode;
	}

}