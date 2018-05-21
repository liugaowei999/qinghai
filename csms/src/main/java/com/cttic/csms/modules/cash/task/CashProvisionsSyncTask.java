package com.cttic.csms.modules.cash.task;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import com.cttic.csms.common.constants.DictCash;
import com.cttic.csms.common.utils.CsmsDateUtils;
import com.cttic.csms.modules.cash.entity.CashProvisions;
import com.cttic.csms.modules.cash.entity.SettBpDetail;
import com.cttic.csms.modules.cash.service.CashProvisionsService;
import com.cttic.csms.modules.cash.service.SettAdDetailService;
import com.cttic.csms.modules.cash.service.SettBpDetailService;
import com.cttic.sysframe.timetask.service.SysTimetaskService;
import com.cttic.sysframe.utils.SysConstants;
import com.thinkgem.jeesite.common.utils.SpringContextHolder;
import com.thinkgem.jeesite.modules.sys.entity.Office;

public class CashProvisionsSyncTask  implements Job{
//	@Autowired
//	SettBpDetailService bpDetailService;
//	@Autowired
//	SettAdDetailService adDetailService;
//	@Autowired
//	CashProvisionsService cashProvisionsService;
	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		System.out.println("同步备付金账户余额开始......." + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));  
		try{
    		syncRemaining();
        	//如果周一或每月1号，还需计算上周期应付金额
        	if(CsmsDateUtils.isMonday()){
        		System.out.println("周一，同步应付金额开始......." + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));  
        		syncPay(1);
        	}
        	if(CsmsDateUtils.isMonthOne()){
        		System.out.println("每月1号，同步应付金额开始......." + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));  
        		syncPay(2);
        	}
        	System.out.println("同步备付金账户余额完成......." + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())); 
        	context.getJobDetail().getJobDataMap().put(SysConstants.TIMETASK_BUSI.BUSI_CODE, SysConstants.TIMETASK_BUSI.BUSI_CODE_SUC);
            context.getJobDetail().getJobDataMap().put(SysConstants.TIMETASK_BUSI.BUSI_DESC, "同步备付金账户成功！");
    	}
    	catch(Exception e){
    		String message=e.getMessage();
    		if(message.length()>2000){
    			message=message.substring(0, 1900);
    		}
    		context.getJobDetail().getJobDataMap().put(SysConstants.TIMETASK_BUSI.BUSI_CODE, SysConstants.TIMETASK_BUSI.BUSI_CODE_FAIL);
            context.getJobDetail().getJobDataMap().put(SysConstants.TIMETASK_BUSI.BUSI_DESC, "同步备付金账户失败："+message);
    	}
		    	
	}
	/*public void taskStart() {  
    	System.out.println("同步备付金账户余额开始.......");  
    	syncRemaining();
    	//如果周一或每月1号，还需计算上周期应付金额
    	if(CsmsDateUtils.isMonday()){
    		System.out.println("周一，同步应付金额开始.......");  
    		syncPay(1);
    	}
    	if(CsmsDateUtils.isMonthOne()){
    		System.out.println("每月1号，同步应付金额开始.......");  
    		syncPay(2);
    	}
    	System.out.println("同步备付金账户余额完成......."); 
    }*/
	
	//计算上周期应付
	private void syncPay(int flag){
		//备付金账号列表
		CashProvisions cashProvisions= new CashProvisions();
		CashProvisionsService cashProvisionsService=SpringContextHolder.getBean("cashProvisionsService");
		List<CashProvisions> cashList = cashProvisionsService.findList(cashProvisions);
		for(CashProvisions cash:cashList){
			//周一且周期为按周
			if(flag==1&&cash.getPayPeriod().equals(DictCash.CASH_PAY_PERIOD_WEEK)){
				//取上周一及上周日日期
				String monday=CsmsDateUtils.getWeekDay(1);
				String sunday=CsmsDateUtils.getWeekDay(2);
				updatePay(cash, flag, monday, sunday);
			}
			//1号且周期为按月
			else if(flag==2&&cash.getPayPeriod().equals(DictCash.CASH_PAY_PERIOD_MONTH)){
				//取上1号及月末日日期
				String beginNo=CsmsDateUtils.getMonthDay(1);
				String endNo=CsmsDateUtils.getMonthDay(2);
				updatePay(cash, flag, beginNo, endNo);
			}
		}
	}
	
	//更新应付主要逻辑
	public void updatePay(CashProvisions cash, int flag, String beginDate, String endDate) {
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyyMMdd");
		CashProvisionsService cashProvisionsService=SpringContextHolder.getBean("cashProvisionsService");
		SettBpDetailService bpDetailService = SpringContextHolder.getBean("settBpDetailService");
		//取当前备付金账号组织机构代码
		String cashOrgCode = cash.getCompany().getId();
		//开户日期<=上周期开始日期，则取上周期bp金额，ad差错金额忽略不计
		if(dateFormat.format(cash.getCreateDate()).compareTo(beginDate)<=0){
			//根据清算日期取上周bp金额
			SettBpDetail settBpDetail= new SettBpDetail();
			settBpDetail.setRecvOrgCode(cashOrgCode);
			
			double sum=(double)bpDetailService.findSumForPay(settBpDetail,beginDate,endDate);
			if(sum>0){ 
				//更新应付
				CashProvisions cp= new CashProvisions();
				cp.setId(cash.getId());
				cp.setNeedPay(sum);
				cashProvisionsService.updateAmount(cp);
				//更新可提现金额
				cashProvisionsService.updateAfterPay(cp);
			}
		}
		//上周期开始日期<开户日期<=上周期结束日期，则取上周bp金额/天数*周期天数，ad差错金额忽略不计
		else if(dateFormat.format(cash.getCreateDate()).compareTo(beginDate)>0&&dateFormat.format(cash.getCreateDate()).compareTo(endDate)<=0){
			//根据清算日期取上周bp金额
			SettBpDetail settBpDetail= new SettBpDetail();
			settBpDetail.setRecvOrgCode(cashOrgCode);
			double sum=(double)bpDetailService.findSumForPay(settBpDetail,dateFormat.format(cash.getCreateDate()),endDate);
			if(sum>0){ 
				//计算天数差
				int num=1;
				try {
					num = CsmsDateUtils.getIntervalDays(dateFormat.parse(endDate),cash.getCreateDate());
				} catch (ParseException e) {
					e.printStackTrace();
				}
				//更新应付
				CashProvisions cp= new CashProvisions();
				cp.setId(cash.getId());
				int days;
				if(flag==1){
					days=7;
				}else{
					days=30;
				}
				cp.setNeedPay(sum/num*days);
				cashProvisionsService.updateAmount(cp);
				//更新可提现金额
				cashProvisionsService.updateAfterPay(cp);
			}
		}
		else{
			//大于上周日，则表示本周才开的户，不存在上周期，不更新应付
		}
	}
	
	//计算更新账户余额
	private void syncRemaining() {
		SettBpDetailService bpDetailService = SpringContextHolder.getBean("settBpDetailService");
		CashProvisionsService cashProvisionsService=SpringContextHolder.getBean("cashProvisionsService");
		//取入库时间为今日的bp记录
		SettBpDetail settBpDetail= new SettBpDetail();
		List<SettBpDetail> bpDetails= bpDetailService.findListForSync(settBpDetail);
		for(SettBpDetail bp:bpDetails){
			//根据bp机构代码取备付金表id
			Office company =new Office();
			company.setId(bp.getRecvOrgCode());
			CashProvisions cashProvisions= new CashProvisions();
			cashProvisions.setCompany(company);
			List<CashProvisions> cashList = cashProvisionsService.findList(cashProvisions);
			//根据id更新备付金账户表中记录
			for(CashProvisions cash:cashList){
				double charge=0;
				charge = (double)(bp.getIncomeCharge()-bp.getPayCharge());
				if(charge!=0){
					updateRemaining(cash.getId(), charge);
				}
			}
		}
		
		//规则待定。。。。暂时屏蔽
		//取入库时间为今日的ad记录
		/*SettAdDetail settAdDetail= new SettAdDetail();
		List<SettAdDetail> adDetails= adDetailService.findListForSync(settAdDetail);
		for(SettAdDetail ad:adDetails){
			//根据ad接收机构代码取备付金表id
			Office company =new Office();
			company.setId(ad.getRecvOrgCode());
			CashProvisions cashProvisions= new CashProvisions();
			cashProvisions.setCompany(company);
			List<CashProvisions> cashList = cashProvisionsService.findList(cashProvisions);
			//针对发卡机构
			if(ad.getRecvOrgCode().equals(ad.getIssueOrgCode())){
				//差错手续费，正值为收单机构支付
				if(ad.getErrCharge()>=0){
					//根据id更新备付金账户表中记录
					for(CashProvisions cash:cashList){
						double charge=0;
						charge = (double)ad.getBillCharge();
						updateRemaining(cash.getId(), charge);
					}
				}
				//差错手续费，负值为发卡机构支付
				else{
					//根据id更新备付金账户表中记录
					for(CashProvisions cash:cashList){
						double charge=0;
						charge = (double)((-1)*ad.getIssueCharge());
						updateRemaining(cash.getId(), charge);
					}
				}
			}
			//针对收单机构
			else if(ad.getRecvOrgCode().equals(ad.getBillOrgCode())){
				//差错手续费，负值为发卡机构支付，正值为收单机构支付
				if(ad.getErrCharge()>=0){
					//根据id更新备付金账户表中记录
					for(CashProvisions cash:cashList){
						double charge=0;
						charge = (double)((-1)*ad.getBillCharge());
						updateRemaining(cash.getId(), charge);
					}
				}
				else{
					//根据id更新备付金账户表中记录
					for(CashProvisions cash:cashList){
						double charge=0;
						charge = (double)((-1)*ad.getIssueCharge());
						updateRemaining(cash.getId(), charge);
					}
				}
			}
		}*/
		
	}
	
	//更新账户余额等
	public void updateRemaining(String id, double charge) {
		CashProvisionsService cashProvisionsService=SpringContextHolder.getBean("cashProvisionsService");
		CashProvisions cp= new CashProvisions();
		cp.setId(id);
		cp.setTotalAmount(charge);
		cp.setRemainingSum(charge);
		cp.setWithdrawDeposite(charge);
		cashProvisionsService.updateAmount(cp);
	}


}
