/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 入网机构配置Entity
 * @author aryo
 * @version 2016-12-03
 */
public class BpsSysOrgInfo extends DataEntity<BpsSysOrgInfo> {
	
	private static final long serialVersionUID = 1L;
	private String orgCode;		// org_code
	private String orgName;		// org_name
	private String areaType;		// 01：省外02：省内03：公司内
	private String cityCode;		// city_code
	private Date effDate;		// eff_date
	private Date expDate;		// exp_date
	private String remark;		// remark
	private String dealFlag;		// deal_flag
	private String cityName;
	
	public BpsSysOrgInfo() {
		super();
	}

	public BpsSysOrgInfo(String id){
		super(id);
	}

	@Length(min=0, max=11, message="org_code长度必须介于 0 和 11 之间")
	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}
	
	@Length(min=0, max=32, message="org_name长度必须介于 0 和 32 之间")
	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	
	@Length(min=0, max=2, message="01：省外02：省内03：公司内长度必须介于 0 和 2 之间")
	public String getAreaType() {
		return areaType;
	}

	public void setAreaType(String areaType) {
		this.areaType = areaType;
	}
	
	@Length(min=0, max=32, message="city_code长度必须介于 0 和 32 之间")
	public String getCityCode() {
		return cityCode;
	}

	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEffDate() {
		return effDate;
	}

	public void setEffDate(Date effDate) {
		this.effDate = effDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getExpDate() {
		return expDate;
	}

	public void setExpDate(Date expDate) {
		this.expDate = expDate;
	}
	
	@Length(min=0, max=512, message="remark长度必须介于 0 和 512 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	@Length(min=0, max=1, message="deal_flag长度必须介于 0 和 1 之间")
	public String getDealFlag() {
		return dealFlag;
	}

	public void setDealFlag(String dealFlag) {
		this.dealFlag = dealFlag;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	
	
	
}