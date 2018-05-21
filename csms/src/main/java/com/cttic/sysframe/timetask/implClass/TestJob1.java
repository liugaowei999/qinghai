package com.cttic.sysframe.timetask.implClass;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cttic.sysframe.utils.SysConstants;

/**
 * 定时任务模版类
 * @author dener
 * @version 2016-12-8
 */
public class TestJob1 implements Job{  
    public void execute(JobExecutionContext context)throws JobExecutionException{
        System.out.println(" testJob1111111111111111111 ...: " + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));   
        if(true){
            context.getJobDetail().getJobDataMap().put(SysConstants.TIMETASK_BUSI.BUSI_CODE, SysConstants.TIMETASK_BUSI.BUSI_CODE_SUC);
            context.getJobDetail().getJobDataMap().put(SysConstants.TIMETASK_BUSI.BUSI_DESC, "具体业务执行情况，不超过1000字");
        }else{
            context.getJobDetail().getJobDataMap().put(SysConstants.TIMETASK_BUSI.BUSI_CODE, SysConstants.TIMETASK_BUSI.BUSI_CODE_FAIL);
            context.getJobDetail().getJobDataMap().put(SysConstants.TIMETASK_BUSI.BUSI_DESC, "具体业务执行情况，不超过1000字");
        }
        
    }
}  