/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.sysframe.timetask.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 定时任务日志管理Entity
 * @author dener
 * @version 2016-12-06
 */
public class SysTimetaskLog extends DataEntity<SysTimetaskLog> {
	
	private static final long serialVersionUID = 1L;
	private String taskId;		// 任务标识
	private String taskDescribe;		// 任务描述
	private String instId;		// 运行实例
	private Date beginDate;		// 开始时间
	private Date endDate;		// 结束时间
	private String runState;		// 运行状态
	private String runRemarks;		// 运行描述
	private String busiState;		// 业务状态
	private String busiRemarks;		// 业务描述
	
	public SysTimetaskLog() {
		super();
	}

	public SysTimetaskLog(String id){
		super(id);
	}

	@Length(min=1, max=100, message="任务标识长度必须介于 1 和 100 之间")
	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}
	
	@Length(min=1, max=50, message="任务描述长度必须介于 1 和 50 之间")
	public String getTaskDescribe() {
		return taskDescribe;
	}

	public void setTaskDescribe(String taskDescribe) {
		this.taskDescribe = taskDescribe;
	}
	
	@Length(min=1, max=100, message="运行实例长度必须介于 1 和 100 之间")
	public String getInstId() {
		return instId;
	}

	public void setInstId(String instId) {
		this.instId = instId;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	@Length(min=0, max=1, message="运行状态长度必须介于 0 和 1 之间")
	public String getRunState() {
		return runState;
	}

	public void setRunState(String runState) {
		this.runState = runState;
	}
	
	@Length(min=0, max=2000, message="运行描述长度必须介于 0 和 2000 之间")
	public String getRunRemarks() {
		return runRemarks;
	}

	public void setRunRemarks(String runRemarks) {
		this.runRemarks = runRemarks;
	}
	
	@Length(min=0, max=1, message="业务状态长度必须介于 0 和 1 之间")
	public String getBusiState() {
		return busiState;
	}

	public void setBusiState(String busiState) {
		this.busiState = busiState;
	}
	
	@Length(min=0, max=2000, message="业务描述长度必须介于 0 和 2000 之间")
	public String getBusiRemarks() {
		return busiRemarks;
	}

	public void setBusiRemarks(String busiRemarks) {
		this.busiRemarks = busiRemarks;
	}
	
}