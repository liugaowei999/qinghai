/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.Office;

/**
 * LD消费已处理文件清单Entity
 * @author wanglk
 * @version 2016-12-05
 */
public class SettLd extends DataEntity<SettLd> {
	
	private static final long serialVersionUID = 1L;
	private String settDate;		// 清算日期
	private String recvOrgCode;		// 接收机构代码
	private String fileName;		// 文件名称
	private Long settOrgNo;		// 清分结算机构流水号
	private String fileListName;		// 文件列表名称
	private String errCode;		// 错误代码
	private String errInfo;		// 错误描述
	private String reserved;		// 保留域
	private String dealTime;		// 处理时间
	private String indbTime;		// 入库时间
	
	private Office company; 
	private String tableName;
	
	public SettLd() {
		super();
	}

	public SettLd(String id){
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
	
	public Long getSettOrgNo() {
		return settOrgNo;
	}

	public void setSettOrgNo(Long settOrgNo) {
		this.settOrgNo = settOrgNo;
	}
	
	@Length(min=0, max=50, message="文件列表名称长度必须介于 0 和 50 之间")
	public String getFileListName() {
		return fileListName;
	}

	public void setFileListName(String fileListName) {
		this.fileListName = fileListName;
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
	
	@Length(min=0, max=40, message="保留域长度必须介于 0 和 40 之间")
	public String getReserved() {
		return reserved;
	}

	public void setReserved(String reserved) {
		this.reserved = reserved;
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