package com.cttic.sysframe.timetask.implClass;

import java.util.Date;

import org.apache.log4j.Logger;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.JobListener;

import com.cttic.sysframe.timetask.entity.SysTimetaskLog;
import com.cttic.sysframe.timetask.service.SysTimetaskLogService;
import com.cttic.sysframe.utils.SysConstants;
import com.thinkgem.jeesite.common.utils.SpringContextHolder;

/**
 * 定时任务监听类
 * @author dener
 * @version 2016-12-8
 */
public class JobImplListener implements JobListener {

	private static Logger _log = Logger.getLogger(JobImplListener.class);
	
	private String name="defaultListenerName";
	public void setName(String name) {
		this.name = name;
	}
	public String getName() {
		return this.name;
	}
 
	public void jobToBeExecuted(JobExecutionContext inContext) {
		setName(inContext.getJobDetail().getKey().getName());
		SysTimetaskLogService timetaskLogService = SpringContextHolder.getBean("sysTimetaskLogService");
		SysTimetaskLog timetaskLog = new SysTimetaskLog();
		timetaskLog.setTaskId(inContext.getJobDetail().getKey().getName());
		timetaskLog.setTaskDescribe(inContext.getJobDetail().getDescription());
		timetaskLog.setInstId(inContext.getJobDetail().getJobDataMap().getString("instId"));
		timetaskLog.setRunRemarks("开始执行");
		timetaskLog.setRunState(SysConstants.TIMETASK_RUN_STATE.RUN_BEGIN);
		timetaskLog.setBeginDate(new Date());
		timetaskLogService.save(timetaskLog);
		inContext.getJobDetail().getJobDataMap().put("timetaskLog", timetaskLog);
	}

	public void jobExecutionVetoed(JobExecutionContext inContext) {
	}

	public void jobWasExecuted(JobExecutionContext inContext,
			JobExecutionException inException) {
		SysTimetaskLogService timetaskLogService = SpringContextHolder.getBean("sysTimetaskLogService");
		SysTimetaskLog timetaskLog = (SysTimetaskLog)inContext.getJobDetail().getJobDataMap().get("timetaskLog");
		timetaskLog.setRunRemarks("执行完成");
		timetaskLog.setRunState(SysConstants.TIMETASK_RUN_STATE.RUN_END);
		timetaskLog.setEndDate(new Date());
		timetaskLog.setBusiState(inContext.getJobDetail().getJobDataMap().getString(SysConstants.TIMETASK_BUSI.BUSI_CODE));
	    String msg =inContext.getJobDetail().getJobDataMap().getString(SysConstants.TIMETASK_BUSI.BUSI_DESC);
        if(msg.length()>2000){
        	msg=msg.substring(0, 1900);
        }
		timetaskLog.setBusiRemarks(msg);
		timetaskLogService.save(timetaskLog);
	}
}
