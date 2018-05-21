package com.cttic.csms.common.constants;

/**
 * 备付金相关常量
 * @author ambitious
 * @version 2016-11-28
 */
public class DictCash {
	/**
	 * 缴存状态（0：正在缴存；1：缴存成功；2：缴存失败；）
	 */
	public static final String CASH_PAY_STATUS_PROCESSING = "0";
	public static final String CASH_PAY_STATUS_SUCCESS = "1";
	public static final String CASH_PAY_STATUS_FAIL = "2";
	
	/**
	 * 缴存周期（1：按月缴存；2：按周缴存；）
	 */
	public static final String CASH_PAY_PERIOD_WEEK = "1";
	public static final String CASH_PAY_PERIOD_MONTH = "2";
	
	/**
	 * 处理状态（0：未处理；1：已处理）
	 */
	public static final String DEAL_STATE_UNDEAL = "0";
	public static final String DEAL_STATE_DEALED = "1";
	
	/**
	 * 通知类型（0：缴存调整－常规通知；1：缴存调整－紧急通知－前两日或一周内可用余额低于预警值；2：缴存调整－紧急通知－大于3天内的假期调整；3：缴存预警－低于指定预警值；）
	 */
	public static final String ADVICE_TYPE_CONVENTION = "0";
	public static final String ADVICE_TYPE_URGENCY_WARN = "1";
	public static final String ADVICE_TYPE_URGENCY_HOLIDAY = "2";
	//每日检查预警值，若低于指定的参数，则发送告警信息
	public static final String ADVICE_TYPE_URGENCY_PAY_WARN = "3";

}
