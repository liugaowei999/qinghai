/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.entity;

import org.hibernate.validator.constraints.Length;

import com.cttic.csms.modules.underlytask.entity.BpsSysModule;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 前台出账Entity
 * @author zhouhong
 * @version 2017-05-03
 */
public class SettProcStat extends DataEntity<SettProcStat> {
	
	private static final long serialVersionUID = 1L;
	private Integer moduleId;		// module_id
	private String moduleCode;		// module_code
	private String moduleName;		// module_name
	private String programName;		// program_name
	private String settDate;		// sett_date
	private String status;		// status
	private String startTime;		// start_time
	private String endTime;		// end_time
	private String note;		// note
	private BpsSysModule bpsSysModule;
	
	public SettProcStat() {
		super();
	}

	public SettProcStat(String id){
		super(id);
	}

	public Integer getModuleId() {
		return moduleId;
	}

	public void setModuleId(Integer moduleId) {
		this.moduleId = moduleId;
	}
	
	@Length(min=0, max=32, message="module_code长度必须介于 0 和 32 之间")
	public String getModuleCode() {
		return moduleCode;
	}

	public void setModuleCode(String moduleCode) {
		this.moduleCode = moduleCode;
	}
	
	@Length(min=0, max=32, message="module_name长度必须介于 0 和 32 之间")
	public String getModuleName() {
		return moduleName;
	}

	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	
	@Length(min=0, max=128, message="program_name长度必须介于 0 和 128 之间")
	public String getProgramName() {
		return programName;
	}

	public void setProgramName(String programName) {
		this.programName = programName;
	}
	
	@Length(min=0, max=8, message="sett_date长度必须介于 0 和 8 之间")
	public String getSettDate() {
		return settDate;
	}

	public void setSettDate(String settDate) {
		this.settDate = settDate;
	}
	
	@Length(min=0, max=32, message="status长度必须介于 0 和 32 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=14, message="start_time长度必须介于 0 和 14 之间")
	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	
	@Length(min=0, max=14, message="end_time长度必须介于 0 和 14 之间")
	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	
	@Length(min=0, max=256, message="note长度必须介于 0 和 256 之间")
	public String getNote() {
		return note;
	}

	public void setBpsSysModule(BpsSysModule bpsSysModule) {
		this.bpsSysModule = bpsSysModule;
	}
	
	public BpsSysModule getBpsSysModule() {
		return bpsSysModule;
	}

	public void setNote(String note) {
		this.note = note;
	}
	
}