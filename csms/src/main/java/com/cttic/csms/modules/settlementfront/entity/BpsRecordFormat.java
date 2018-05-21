/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 清单记录格式定义Entity
 * @author aryo
 * @version 2016-12-03
 */
public class BpsRecordFormat extends DataEntity<BpsRecordFormat> {
	
	private static final long serialVersionUID = 1L;
	private String drType;		// dr_type
	private String filedName;		// filed_name
	private Long filedIndex;		// filed_index
	private Long valueType;		// 1:int32  |  2:int64  |  3:float  |  4:double  |  5:char  |  6:string
	private Long seq;		// seq
	private String note;		// note
	private String dictId;		// dict_id
	private String operId;		// note
	private Date operTime;		// dict_id
	
	public BpsRecordFormat() {
		super();
	}

	public BpsRecordFormat(String id){
		super(id);
	}

	@Length(min=0, max=20, message="dr_type长度必须介于 0 和 20 之间")
	public String getDrType() {
		return drType;
	}

	public void setDrType(String drType) {
		this.drType = drType;
	}
	
	@Length(min=0, max=32, message="filed_name长度必须介于 0 和 32 之间")
	public String getFiledName() {
		return filedName;
	}

	public void setFiledName(String filedName) {
		this.filedName = filedName;
	}
	
	public Long getFiledIndex() {
		return filedIndex;
	}

	public void setFiledIndex(Long filedIndex) {
		this.filedIndex = filedIndex;
	}
	
	public Long getValueType() {
		return valueType;
	}

	public void setValueType(Long valueType) {
		this.valueType = valueType;
	}
	
	public Long getSeq() {
		return seq;
	}

	public void setSeq(Long seq) {
		this.seq = seq;
	}
	
	@Length(min=0, max=128, message="note长度必须介于 0 和 128 之间")
	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
	
	@Length(min=0, max=32, message="dict_id长度必须介于 0 和 32 之间")
	public String getDictId() {
		return dictId;
	}

	public void setDictId(String dictId) {
		this.dictId = dictId;
	}

	public String getOperId() {
		return operId;
	}

	public void setOperId(String operId) {
		this.operId = operId;
	}

	public Date getOperTime() {
		return operTime;
	}

	public void setOperTime(Date operTime) {
		this.operTime = operTime;
	}
	
	
	
}