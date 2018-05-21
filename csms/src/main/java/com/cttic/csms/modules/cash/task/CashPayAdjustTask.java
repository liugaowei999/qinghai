package com.cttic.csms.modules.cash.task;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.cttic.csms.common.constants.DictCash;
import com.cttic.csms.common.utils.CsmsDateUtils;
import com.cttic.csms.modules.cash.entity.CashAdviceInfo;
import com.cttic.csms.modules.cash.entity.CashProvisions;
import com.cttic.csms.modules.cash.entity.SettBpDetail;
import com.cttic.csms.modules.cash.service.CashAdviceInfoService;
import com.cttic.csms.modules.cash.service.CashProvisionsService;
import com.cttic.csms.modules.cash.service.SettBpDetailService;
import com.thinkgem.jeesite.common.utils.Collections3;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;

/**
 * 备付金缴存调整任务
 * @author ambitious
 * @version 2016-11-28
 */
@Component("cashPayAdjustTask") 
@Lazy(value=false)
public class CashPayAdjustTask {
	
	protected Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private CashProvisionsService provisionService;
	
	@Autowired
	private CashAdviceInfoService adviceInfoService;
	
	@Autowired
	private SettBpDetailService bpDetailService;
	
	private static final double WEEK_WARN_RATIO = 0.4;
	private static final double MONTH_WARN_RATIO = 0.2;
	
	/**
	 * 若账户余额低于指定预警值，则发送告警通知（每天检查一次）
	 */
	//@Scheduled(cron = "*/5 * * * * ?")
    public void payWarn(){
        logger.info("缴费金额调整后台任务－－－－－－" + CsmsDateUtils.getDateTime());
        // 获取所有的备付金相关信息
        List<CashProvisions> provisionList = provisionService.findList(new CashProvisions());
        if(!Collections3.isEmpty(provisionList)) {
        	for (CashProvisions cashProvision : provisionList) {
        		//账户可用余额
        		double remainingSum = cashProvision.getRemainingSum();
        		//账户总额
				double avaliableTotalAmount = cashProvision.getTotalAmount();
        		
				//默认缴存预警值为20%（按周缴存）
				double warnRatio = 0.2;
				//缴存周期－按周缴存
				if(StringUtils.equals(DictCash.CASH_PAY_PERIOD_MONTH, cashProvision.getPayPeriod())) {
					warnRatio = 0.4;
				}
				
				// 若当前可用余额大于预警值，则任务结束
				if((remainingSum / avaliableTotalAmount) > warnRatio) return;
				
				//缴存截止日期+2天（默认）
				Date payDeadline = DateUtils.addDays(new Date(), 2);
        		if(remainingSum < 0) {
	    			//缴存截止日期＋1天
	    			payDeadline = DateUtils.addDays(new Date(), 1);
	    		}
        		
        		//账户应付清算金额
        		double needPay = avaliableTotalAmount - remainingSum;
        		
        		//构建通知实体
    			CashAdviceInfo adviceInfo = new CashAdviceInfo(cashProvision.getId(), needPay, payDeadline, DictCash.ADVICE_TYPE_URGENCY_PAY_WARN);
    			adviceInfoService.save(adviceInfo);
				
			}
        }
    }
	
	/**
	 * 常规调整（每周三06:00或者每月10日06:00执行）
	 */
	//@Scheduled(cron = "*/15 * * * * ?")
    public void conventionAdjust(){
        logger.info("缴费金额调整后台任务－－常规调整－－－－" + CsmsDateUtils.getDateTime());
        // 获取所有的备付金相关信息
        List<CashProvisions> provisionList = provisionService.findList(new CashProvisions());
        if(!Collections3.isEmpty(provisionList)) {
        	for (CashProvisions cashProvision : provisionList) {
        		//账户应付清算金额
        		double needPay = cashProvision.getNeedPay();
				//缴存截止日期+2天（默认）
				Date payDeadline = DateUtils.addDays(new Date(), 2);
				//构建通知实体
    			CashAdviceInfo adviceInfo = new CashAdviceInfo(cashProvision.getId(), needPay, payDeadline, DictCash.ADVICE_TYPE_CONVENTION);
    			adviceInfoService.save(adviceInfo);
			}
        }
    }
	
	/**
	 * 缴存调整－紧急通知－前两日或一周内可用余额低于预警值（每周三06:00或者每月10日06:00执行）
	 */
	//@Scheduled(cron = "*/30 * * * * ?")
    public void UrgencyWarnAdjust(){
        logger.info("缴费金额调整后台任务－－紧急调整－－前两日或一周内可用余额低于预警值－－－" + CsmsDateUtils.getDateTime());
        // 获取所有的备付金相关信息
        List<CashProvisions> provisionList = provisionService.findList(new CashProvisions());
        if(!Collections3.isEmpty(provisionList)) {
        	for (CashProvisions cashProvision : provisionList) {
        		//账户应付清算金额
        		double needPay = this.getNeedPayForUrgencyWarn(cashProvision);
				//缴存截止日期+2天（默认）
				Date payDeadline = CsmsDateUtils.addDays(new Date(), 2);
				//构建通知实体
    			CashAdviceInfo adviceInfo = new CashAdviceInfo(cashProvision.getId(), needPay, payDeadline, DictCash.ADVICE_TYPE_URGENCY_WARN);
    			adviceInfoService.save(adviceInfo);
			}
        }
    }
	
	/**
	 * 缴存周期前两日或一周低于预警值
	 * @param cashProvision
	 * @return
	 */
	private double getNeedPayForUrgencyWarn(CashProvisions cashProvision) {
		//取当前备付金账号组织机构代码
		String cashOrgCode = cashProvision.getCompany().getId();
		SettBpDetail bpDetail = new SettBpDetail();
		bpDetail.setRecvOrgCode(cashOrgCode);
		double sumForPay, avgPay, needPay = 0;
		
		if(DictCash.CASH_PAY_PERIOD_WEEK.equals(cashProvision.getPayPeriod())) {
			//按周缴存
			//获取每周前两日的应付金额
			sumForPay = bpDetailService.findSumForPay(null, CsmsDateUtils.getMondayOfWeek(null), CsmsDateUtils.getTuesdayOfWeek(null));
			//备付金缴存周期前2日内轧差净额为负值,且其绝对值高于预警值时
			if(sumForPay / cashProvision.getTotalAmount() < WEEK_WARN_RATIO){
				avgPay = sumForPay / 2;
				needPay = avgPay * (CsmsDateUtils.getDayNumOfMonth() - 2);
			}
		} else {
			//按月缴存
			//获取每周前两日的应付金额
			sumForPay = bpDetailService.findSumForPay(null, CsmsDateUtils.getWeekDay(1), CsmsDateUtils.getWeekDay(7));
			//当备付金缴存周期第1周内轧差净额为负值,且其绝对值高于预警值时
			if(sumForPay / cashProvision.getTotalAmount() < MONTH_WARN_RATIO){
				avgPay = sumForPay / 7;
				needPay = avgPay * (CsmsDateUtils.getDayNumOfMonth() - 7);
			}
		}
		return needPay;
	}
	
	/**
	 * 紧急调整－缴存调整－紧急通知－大于3天内的假期调整（假期前2日通知）
	 */
	//@Scheduled(cron = "*/1 * * * * ?")
    public void UrgencyHolidayAdjust(){
        logger.info("缴费金额调整后台任务－－紧急调整－－大于3天内的假期调整（假期前2日通知）－－－" + CsmsDateUtils.getDateTime());
        // 获取所有的备付金相关信息
        List<CashProvisions> provisionList = provisionService.findList(new CashProvisions());
        if(!Collections3.isEmpty(provisionList)) {
        	for (CashProvisions cashProvision : provisionList) {
        		//账户应付清算金额
        		double needPay = 0L;
        		
				//缴存周期－按周缴存
				if(StringUtils.equals(DictCash.CASH_PAY_PERIOD_MONTH, cashProvision.getPayPeriod())) {
					// 按月缴存清算备付金的入网机构2个工作日内补足整月清算备付金金额（账户总额 - 可用余额）
					needPay = cashProvision.getTotalAmount() - cashProvision.getRemainingSum();
				} else if(StringUtils.equals(DictCash.CASH_PAY_PERIOD_WEEK, cashProvision.getPayPeriod())) {
					// 按周缴存清算备付金的入网机构于2个工作日内补足清算备付金金额至2倍（账户总额 - 可用余额）
					needPay = cashProvision.getTotalAmount() * 2 - cashProvision.getRemainingSum();
				}
        		
				//缴存截止日期+2天（默认）
				Date payDeadline = DateUtils.addDays(new Date(), 2);
				//构建通知实体
				CashAdviceInfo adviceInfo = new CashAdviceInfo(cashProvision.getId(), needPay, payDeadline, DictCash.ADVICE_TYPE_URGENCY_HOLIDAY);
				adviceInfoService.save(adviceInfo);
				
			}
        }
    }
	
//	/**
//	 * 备付金调整－按周缴存
//	 * 判断逻辑：首先判断紧急调整情况是否存在
//	 * 若存在，则继续判断是否存在常规调整，若二者同时存在，则获取紧急调整和常规调整金额的最大值为调整金额，发送一个紧急调整通知即可。
//	 * 不存在，则继续判断是否存在常规调整，若存在，则发送调整通知。
//	 * @param cashProvisions
//	 */
//	private void payForWeek(CashProvisions cashProvisions) {
//		double urgencyAdjustMoney = calUrgencyMoney(cashProvisions);
//		double conventionAdjustMoney = calConventionAdjustMoney(cashProvisions);
//		//若调整金额小于等于0，则不需要调整
//		if(urgencyAdjustMoney <=0 && conventionAdjustMoney <= 0) return;
//		
//		if(urgencyAdjustMoney > 0) {
//			//发送紧急调整通知－－金额为二者中的最大值 Math.max(urgencyAdjustMoney, conventionAdjustMoney);主要是为解决常规调整与紧急调整冲突的问题
//			double needPay = Math.max(urgencyAdjustMoney, conventionAdjustMoney);
//			//this.sendMsg(cashProvisions, needPay, avdiceType);
//			return;
//		}
//		
//		if(conventionAdjustMoney > 0) {
//			//发送常规调整通知
//		}
//	}
//	
//	/**
//	 * 获取紧急调整金额
//	 * @param cashProvisions
//	 * @return
//	 */
//	private double calUrgencyMoney(CashProvisions cashProvisions) {
//		double retVal = 0;
//		return retVal;
//	}
//	
//	/**
//	 * 获取常规调整金额
//	 * @param cashProvisions
//	 * @return
//	 */
//	private double calConventionAdjustMoney(CashProvisions cashProvisions) {
//		double retVal = 0;
//		return retVal;
//	}
	
}
