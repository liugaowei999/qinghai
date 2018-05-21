/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.entity;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 外围系统接口传输信息记录Entity
 * @author aryo
 * @version 2016-12-23
 */
public class BpsFiletransLog extends DataEntity<BpsFiletransLog> {
	
	private static final long serialVersionUID = 1L;
	private Integer moduleId;		// 模块ID
	private String fileName;		// 文件名
	private Integer fileSize;		// 原始文件大小， 单位字节
	private Integer isSucess;		// 是否成功
	private Date processTime;		// 上传或下载时间 yyyymmddhh24miss
	private Integer isup;		// 1: 上传 0：下载
	private Integer transSize;		// 已传输的文件内容大小， 单位字节
	private String remark;		// 备注
	private String tableName;
	
	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public BpsFiletransLog() {
		super();
	}

	public BpsFiletransLog(String id){
		super(id);
	}

	@NotNull(message="模块ID不能为空")
	public Integer getModuleId() {
		return moduleId;
	}

	public void setModuleId(Integer moduleId) {
		this.moduleId = moduleId;
	}
	
	@Length(min=1, max=256, message="文件名长度必须介于 1 和 256 之间")
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	@NotNull(message="原始文件大小， 单位字节不能为空")
	public Integer getFileSize() {
		return fileSize;
	}

	public void setFileSize(Integer fileSize) {
		this.fileSize = fileSize;
	}
	
	@NotNull(message="是否成功不能为空")
	public Integer getIsSucess() {
		return isSucess;
	}

	public void setIsSucess(Integer isSucess) {
		this.isSucess = isSucess;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="上传或下载时间 yyyymmddhh24miss不能为空")
	public Date getProcessTime() {
		return processTime;
	}

	public void setProcessTime(Date processTime) {
		this.processTime = processTime;
	}
	
	@NotNull(message="1: 上传 0：下载不能为空")
	public Integer getIsup() {
		return isup;
	}

	public void setIsup(Integer isup) {
		this.isup = isup;
	}
	
	@NotNull(message="已传输的文件内容大小， 单位字节不能为空")
	public Integer getTransSize() {
		return transSize;
	}

	public void setTransSize(Integer transSize) {
		this.transSize = transSize;
	}
	
	@Length(min=0, max=256, message="备注长度必须介于 0 和 256 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}