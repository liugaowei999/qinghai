package com.cttic.csms.modules.underlytask.entity;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 清分结算后台任务状态参数查询Entity
 * @author ambitious
 * @version 2016-11-14
 */
public class BpsSysModuleParam extends DataEntity<BpsSysModuleParam> {
	
	private static final long serialVersionUID = 1L;
	private Integer moduleId;		// 模块标识
	private String sectionCode;		// 参数类别
	private String paramCode;		// 参数编码
	private String paramValue;		// 参数取值
	private String note;		// 备注
	
	private BpsSysModule bpsSysModule; // 模块实体（用于明确标识参数所属模块）
	
	public BpsSysModuleParam() {
		super();
	}

	public BpsSysModuleParam(String id){
		super(id);
	}

	@NotNull(message="模块标识不能为空")
	public Integer getModuleId() {
		return moduleId;
	}

	public void setModuleId(Integer moduleId) {
		this.moduleId = moduleId;
	}
	
	@Length(min=1, max=32, message="参数类别长度必须介于 1 和 32 之间")
	public String getSectionCode() {
		return sectionCode;
	}

	public void setSectionCode(String sectionCode) {
		this.sectionCode = sectionCode;
	}
	
	@Length(min=1, max=32, message="参数编码长度必须介于 1 和 32 之间")
	public String getParamCode() {
		return paramCode;
	}

	public void setParamCode(String paramCode) {
		this.paramCode = paramCode;
	}
	
	@Length(min=1, max=1024, message="参数取值长度必须介于 1 和 1024 之间")
	public String getParamValue() {
		return paramValue;
	}

	public void setParamValue(String paramValue) {
		this.paramValue = paramValue;
	}
	
	@Length(min=0, max=256, message="备注长度必须介于 0 和 256 之间")
	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
	
	// 根据标识或者主键来判断是否是新增纪录
	public boolean getIsNewRecord() {
        return isNewRecord || moduleId == null || sectionCode == null || paramCode == null;
    }
	
	public BpsSysModule getBpsSysModule() {
		return bpsSysModule;
	}

	public void setBpsSysModule(BpsSysModule bpsSysModule) {
		this.bpsSysModule = bpsSysModule;
	}
	
}