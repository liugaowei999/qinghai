/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.newreports.entity;

import java.text.DecimalFormat;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.Office;

/**
 * 跨省月结算报表Entity
 * @author aryo
 * @version 2017-03-07
 */
public class SettProvStat extends DataEntity<SettProvStat> {
	
	private static final long serialVersionUID = 1L;
	private String settCycle;		// sett_cycle
	private String settObject;		// sett_object
	private Double incomeCharge;		// income_charge
	private Double outcomeCharge;		// outcome_charge
	private Double settCharge;		// sett_charge
	
	
	private DecimalFormat df=new DecimalFormat("##############.#################");
	
	public SettProvStat() {
		super();
	}

	public SettProvStat(String id){
		super(id);
	}

	@Length(min=0, max=6, message="sett_cycle长度必须介于 0 和 6 之间")
	@ExcelField(title="结算账期", align=2, sort=1)
	public String getSettCycle() {
		return settCycle;
	}

	public void setSettCycle(String settCycle) {
		this.settCycle = settCycle;
	}
	
	@Length(min=0, max=64, message="sett_object长度必须介于 0 和 64 之间")
	@ExcelField(title="结算对象", align=2, sort=2)
	public String getSettObject() {
		return settObject;
	}

	public void setSettObject(String settObject) {
		this.settObject = settObject;
	}
	
	@ExcelField(title="收入金额(元)", align=2, sort=3)
	public String getIncomeCharge() {
		df.setGroupingUsed(false); 
		return df.format(incomeCharge);
	}

	public void setIncomeCharge(Double incomeCharge) {
		this.incomeCharge = incomeCharge;
	}
	
	@ExcelField(title="支出金额(元)", align=2, sort=4)
	public String getOutcomeCharge() {
		df.setGroupingUsed(false); 
		return df.format(outcomeCharge);
	}

	public void setOutcomeCharge(Double outcomeCharge) {
		this.outcomeCharge = outcomeCharge;
	}
	
	@ExcelField(title="轧差(元)", align=2, sort=5)
	public String getSettCharge() {
		df.setGroupingUsed(false); 
		return df.format(settCharge);
	}

	public void setSettCharge(Double settCharge) {
		this.settCharge = settCharge;
	}

}