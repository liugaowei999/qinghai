package com.cttic.csms.modules.cash.entity;

import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotNull;
import java.util.Date;

import com.cttic.csms.common.constants.DictCash;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 通知信息Entity
 * @author ambitious
 * @version 2016-11-29
 */
public class CashAdviceInfo extends DataEntity<CashAdviceInfo> {
	
	private static final long serialVersionUID = 1L;
	private String provisionsId;		// 备付金帐号表编号
	private Double needPay;		        // 应缴金额
	private String reason;		        // 缴存原因
	private Date payDeadline;		    // 缴存截止日期
	private String dealState = DictCash.DEAL_STATE_UNDEAL;		// 处理状态（0:未处理，1:已处理）
	private String adviceType;		    // 通知类型（0:告警通知，1:常规调整通知，2:紧急调整通知）
	private String message;             //通知内容
	
	public CashAdviceInfo() {
		super();
	}

	public CashAdviceInfo(String id){
		super(id);
	}

	/**
	 * 根据业务，构造指定的通知信息
	 * @param provisionsId 备付金账户表编号
	 * @param needPay 缴存金额
	 * @param payDeadline 缴存截止日期
	 * @param adviceType 通知类型
	 */
	public CashAdviceInfo(String provisionsId, Double needPay, Date payDeadline, String adviceType) {
		this.provisionsId = provisionsId;
		this.needPay = needPay;
		this.payDeadline = payDeadline;
		this.adviceType = adviceType;
	}

	@Length(min=1, max=64, message="备付金帐号表编号长度必须介于 1 和 64 之间")
	public String getProvisionsId() {
		return provisionsId;
	}

	public void setProvisionsId(String provisionsId) {
		this.provisionsId = provisionsId;
	}
	
	@NotNull(message="缴存金额不能为空")
	public Double getNeedPay() {
		return needPay;
	}

	public void setNeedPay(Double needPay) {
		this.needPay = needPay;
	}
	
	@Length(min=0, max=255, message="缴存状态长度必须介于 0 和 255 之间")
	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getPayDeadline() {
		return payDeadline;
	}

	public void setPayDeadline(Date payDeadline) {
		this.payDeadline = payDeadline;
	}
	
	@Length(min=1, max=1, message="处理状态（0:未处理，1:已处理）长度必须介于 1 和 1 之间")
	public String getDealState() {
		return dealState;
	}

	public void setDealState(String dealState) {
		this.dealState = dealState;
	}
	
	@Length(min=0, max=1, message="通知类型（0:告警通知，1:常规调整通知，2:紧急调整通知）长度必须介于 0 和 1 之间")
	public String getAdviceType() {
		return adviceType;
	}

	public void setAdviceType(String adviceType) {
		this.adviceType = adviceType;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	
	
}