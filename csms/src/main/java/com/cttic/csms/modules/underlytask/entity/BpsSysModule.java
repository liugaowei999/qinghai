/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.underlytask.entity;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 对后台任务处理情况进行查询和修改Entity
 * @author ambitious
 * @version 2016-11-12
 */
public class BpsSysModule extends DataEntity<BpsSysModule> {
	
	private static final long serialVersionUID = 1L;
	private Integer moduleId;		// 模块标识
	private String moduleCode;		// 模块编码
	private String moduleName;		// 模块名称
	private String programName;		// 程序名称
	private String note;		// 备注
	
	public BpsSysModule() {
		super();
	}

	public BpsSysModule(String id){
		super(id);
	}

	@NotNull(message="模块标识不能为空")
	public Integer getModuleId() {
		return moduleId;
	}

	public void setModuleId(Integer moduleId) {
		this.moduleId = moduleId;
	}
	
	@Length(min=1, max=32, message="模块编码长度必须介于 1 和 32 之间")
	public String getModuleCode() {
		return moduleCode;
	}

	public void setModuleCode(String moduleCode) {
		this.moduleCode = moduleCode;
	}
	
	@Length(min=1, max=32, message="模块名称长度必须介于 1 和 32 之间")
	public String getModuleName() {
		return moduleName;
	}

	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	
	@Length(min=1, max=128, message="程序名称长度必须介于 1 和 128 之间")
	public String getProgramName() {
		return programName;
	}

	public void setProgramName(String programName) {
		this.programName = programName;
	}
	
	@Length(min=0, max=256, message="备注长度必须介于 0 和 256 之间")
	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
	
	public boolean getIsNewRecord() {
        return isNewRecord || moduleId == null;
    }
	
}