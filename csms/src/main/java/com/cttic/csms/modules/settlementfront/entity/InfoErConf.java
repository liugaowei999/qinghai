/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * ER错误代码下发配置文件Entity
 * @author ambitious
 * @version 2016-12-03
 */
public class InfoErConf extends DataEntity<InfoErConf> {
	
	private static final long serialVersionUID = 1L;
	private String downDate;		// 下发日期
	private String fileName;		// 文件名称
	private String errCode;		// 错误代码
	private String errInfo;		// 错误代码描述
	private String dealTime;		// 处理时间
	private String indbTime;		// 入库时间
	
	public InfoErConf() {
		super();
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
	
	@Length(min=0, max=6, message="错误代码长度必须介于 0 和 6 之间")
	public String getErrCode() {
		return errCode;
	}

	public void setErrCode(String errCode) {
		this.errCode = errCode;
	}
	
	@Length(min=0, max=40, message="错误代码描述长度必须介于 0 和 40 之间")
	public String getErrInfo() {
		return errInfo;
	}

	public void setErrInfo(String errInfo) {
		this.errInfo = errInfo;
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