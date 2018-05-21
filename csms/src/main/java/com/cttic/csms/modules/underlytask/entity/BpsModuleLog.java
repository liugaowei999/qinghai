/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.underlytask.entity;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 对日志表记录进行查询Entity
 * @author underlytask
 * @version 2016-11-12
 */
public class BpsModuleLog extends DataEntity<BpsModuleLog> {
	
	private static final long serialVersionUID = 1L;
	private Integer moduleId;		// 模块id
	private String fileName;		// 文件名
	private String fileType;		// 文件类型
	private Integer fileSize;		// 文件大小
	private Date fileDate;		// 文件日期
	private Date beginDealTime;		// 开始处理时间
	private Date endDealTime;		// 结束处理时间
	private Integer totalCount;		// 话单总数
	private Integer normalCount;		// 正确话单数
	private Integer errorCount;		// 错误话单数
	private Integer dupCount;		// 重复话单数
	private Integer nouseCount;		// 无用话单数
	private Integer changedCount;		// 增减话单数
	private Integer mergeCount;		// 合并话单数
	private Integer splitCount;		// 拆分话单数
	private Integer other1;		// 保留1
	private Integer other2;		// 保留2
	private Integer asnBadblock;		// ASN坏块大小
	private String earlyTime;		// 最早话单时间
	private String lateTime;		// 最晚话单时间
	private String tableName;
	private BpsSysModule bpsSysModule; // 模块实体（用于明确标识参数所属模块）
	
	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	
	public BpsModuleLog() {
		super();
	}

	public BpsModuleLog(String id){
		super(id);
	}

	@NotNull(message="模块id不能为空")
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
	
	@Length(min=1, max=8, message="文件类型长度必须介于 1 和 8 之间")
	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	
	@NotNull(message="文件大小不能为空")
	public Integer getFileSize() {
		return fileSize;
	}

	public void setFileSize(Integer fileSize) {
		this.fileSize = fileSize;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="文件日期不能为空")
	public Date getFileDate() {
		return fileDate;
	}

	public void setFileDate(Date fileDate) {
		this.fileDate = fileDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="开始处理时间不能为空")
	public Date getBeginDealTime() {
		return beginDealTime;
	}

	public void setBeginDealTime(Date beginDealTime) {
		this.beginDealTime = beginDealTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="结束处理时间不能为空")
	public Date getEndDealTime() {
		return endDealTime;
	}

	public void setEndDealTime(Date endDealTime) {
		this.endDealTime = endDealTime;
	}
	
	@NotNull(message="话单总数不能为空")
	public Integer getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}
	
	@NotNull(message="正确话单数不能为空")
	public Integer getNormalCount() {
		return normalCount;
	}

	public void setNormalCount(Integer normalCount) {
		this.normalCount = normalCount;
	}
	
	@NotNull(message="错误话单数不能为空")
	public Integer getErrorCount() {
		return errorCount;
	}

	public void setErrorCount(Integer errorCount) {
		this.errorCount = errorCount;
	}
	
	@NotNull(message="重复话单数不能为空")
	public Integer getDupCount() {
		return dupCount;
	}

	public void setDupCount(Integer dupCount) {
		this.dupCount = dupCount;
	}
	
	@NotNull(message="无用话单数不能为空")
	public Integer getNouseCount() {
		return nouseCount;
	}

	public void setNouseCount(Integer nouseCount) {
		this.nouseCount = nouseCount;
	}
	
	@NotNull(message="增减话单数不能为空")
	public Integer getChangedCount() {
		return changedCount;
	}

	public void setChangedCount(Integer changedCount) {
		this.changedCount = changedCount;
	}
	
	@NotNull(message="合并话单数不能为空")
	public Integer getMergeCount() {
		return mergeCount;
	}

	public void setMergeCount(Integer mergeCount) {
		this.mergeCount = mergeCount;
	}
	
	@NotNull(message="拆分话单数不能为空")
	public Integer getSplitCount() {
		return splitCount;
	}

	public void setSplitCount(Integer splitCount) {
		this.splitCount = splitCount;
	}
	
	@NotNull(message="保留1不能为空")
	public Integer getOther1() {
		return other1;
	}

	public void setOther1(Integer other1) {
		this.other1 = other1;
	}
	
	@NotNull(message="保留2不能为空")
	public Integer getOther2() {
		return other2;
	}

	public void setOther2(Integer other2) {
		this.other2 = other2;
	}
	
	@NotNull(message="ASN坏块大小不能为空")
	public Integer getAsnBadblock() {
		return asnBadblock;
	}

	public void setAsnBadblock(Integer asnBadblock) {
		this.asnBadblock = asnBadblock;
	}
	
	@Length(min=1, max=16, message="最早话单时间长度必须介于 1 和 16 之间")
	public String getEarlyTime() {
		return earlyTime;
	}

	public void setEarlyTime(String earlyTime) {
		this.earlyTime = earlyTime;
	}
	
	@Length(min=1, max=16, message="最晚话单时间长度必须介于 1 和 16 之间")
	public String getLateTime() {
		return lateTime;
	}

	public void setLateTime(String lateTime) {
		this.lateTime = lateTime;
	}
	
	public BpsSysModule getBpsSysModule() {
		return bpsSysModule;
	}

	public void setBpsSysModule(BpsSysModule bpsSysModule) {
		this.bpsSysModule = bpsSysModule;
	}
	
}