/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.sysframe.timetask.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 定时任务管理功能Entity
 * @author dener
 * @version 2016-12-06
 */
public class SysTimetask extends DataEntity<SysTimetask> {
	
	private static final long serialVersionUID = 1L;
	private String taskId;		// 任务标识
	private String taskDescribe;		// 任务描述
	private String implClass;		// 实现类
	private String cronExpression;		// 执行计划
	private String instId;		// 运行实例
	private String isEffect;		// 是否生效
	private String isStart;		// 是否启动
	
	public SysTimetask() {
		super();
	}

	public SysTimetask(String id){
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
	
	@Length(min=1, max=100, message="实现类长度必须介于 1 和 100 之间")
	public String getImplClass() {
		return implClass;
	}

	public void setImplClass(String implClass) {
		this.implClass = implClass;
	}
	
	@Length(min=1, max=100, message="执行计划长度必须介于 1 和 100 之间")
	public String getCronExpression() {
		return cronExpression;
	}

	public void setCronExpression(String cronExpression) {
		this.cronExpression = cronExpression;
	}
	
	@Length(min=1, max=100, message="运行实例长度必须介于 1 和 100 之间")
	public String getInstId() {
		return instId;
	}

	public void setInstId(String instId) {
		this.instId = instId;
	}
	
	@Length(min=1, max=1, message="是否生效长度必须介于 1 和 1 之间")
	public String getIsEffect() {
		return isEffect;
	}

	public void setIsEffect(String isEffect) {
		this.isEffect = isEffect;
	}
	
	@Length(min=1, max=1, message="是否启动长度必须介于 1 和 1 之间")
	public String getIsStart() {
		return isStart;
	}

	public void setIsStart(String isStart) {
		this.isStart = isStart;
	}
	
}