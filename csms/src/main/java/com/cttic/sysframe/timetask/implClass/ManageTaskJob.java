package com.cttic.sysframe.timetask.implClass;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.quartz.CronScheduleBuilder;
import org.quartz.Job;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.JobKey;
import org.quartz.JobListener;
import org.quartz.Matcher;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.Trigger.TriggerState;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.quartz.impl.matchers.GroupMatcher;
import org.quartz.impl.matchers.KeyMatcher;
import org.springframework.stereotype.Component;

import com.cttic.sysframe.timetask.entity.SysTimetask;
import com.cttic.sysframe.timetask.service.SysTimetaskService;
import com.cttic.sysframe.utils.SysConstants;
import com.thinkgem.jeesite.common.utils.SpringContextHolder;

/**
 * 主定时任务加载数据库定时任务逻辑类
 * @author dener
 * @version 2016-12-8
 */
@Component
public class ManageTaskJob implements Job {	
	@Override
	public void execute(JobExecutionContext context)throws JobExecutionException {
		
//        System.out.println(" ManageTaskJob begin 00000000000000000000000000000000 ...Date : " + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())); 
        SysTimetaskService sysTimetaskService = SpringContextHolder.getBean("sysTimetaskService");
        String instId=context.getJobDetail().getJobDataMap().getString("instId");
        Scheduler scheduler=(Scheduler)context.getJobDetail().getJobDataMap().get("scheduler");
        String msg = "";
        //获取定时任务配置数据 
        SysTimetask taskQry = new SysTimetask();
        taskQry.setInstId(instId);
        List<SysTimetask>  timetaskList=sysTimetaskService.findList(taskQry);
        if(timetaskList!=null && timetaskList.size()>0){
        	for(SysTimetask timetask : timetaskList){
        		
        		try{
	        		/**1.获取定时任务状态***************************************/
	        		TriggerKey triggerKey = new TriggerKey(timetask.getTaskId(),Scheduler.DEFAULT_GROUP);
					TriggerState triggerState=scheduler.getTriggerState(triggerKey);
//					System.out.println(" ManageTaskJob triggerState==== : " + triggerState.name()+"===="+triggerState.toString()); 
	        		
					if(instId.equals(timetask.getInstId())){
						 /**2.按条件对每个定时任务做处理***************************************/
						 if(SysConstants.TIMETASK_EFFECT.EFFECT_Y.equals(timetask.getIsEffect())){
							 /**2.1 需要启动定时任务***************************************/
							 if(SysConstants.TIMETASK_START.START_Y.equals(timetask.getIsStart())){
								 if(TriggerState.NORMAL.toString().equals(triggerState.name())
										 ||TriggerState.COMPLETE.toString().equals(triggerState.name())
										 ||TriggerState.BLOCKED.toString().equals(triggerState.name())){
									//a.定时任务正在正常运行 或 触发器完成，但是任务可能还正在执行中 或线程阻塞状态时  保持现状 
								 }else if(TriggerState.NONE.toString().equals(triggerState.name())){
									//b.定时任务不存在或不会再被执行时，需要新建并启动；
									 try{
										Class<?> clazz = Class.forName(timetask.getImplClass());
										addJob(timetask,clazz,instId,scheduler);
										msg=msg+"【"+timetask.getTaskId()+":"+timetask.getTaskDescribe()+"】启动成功；";
									 }catch(Exception e){
										 e.printStackTrace();
										 msg=msg+"【"+timetask.getTaskId()+":"+timetask.getTaskDescribe()+"】启动失败:"+e.getMessage();
									 }
								 }else if(TriggerState.ERROR.toString().equals(triggerState.name())){
									//c.定时任务出现错误，删除原定时任务，新建并重启；
									 try{
										 JobKey jobKey = JobKey.jobKey(timetask.getTaskId(),Scheduler.DEFAULT_GROUP);
										 scheduler.deleteJob(jobKey);
										 
										 Class<?> clazz = Class.forName(timetask.getImplClass());
										 addJob(timetask,clazz,instId,scheduler);
										 msg=msg+"【"+timetask.getTaskId()+":"+timetask.getTaskDescribe()+"】原任务状态为出错，停止出错任务，重新启动任务成功；";
									 }catch(Exception e){
										 msg=msg+"【"+timetask.getTaskId()+":"+timetask.getTaskDescribe()+"】原任务状态为出错，停止出错任务，重新启动任务失败。"+e.getMessage();
									 }
								 }else if(TriggerState.PAUSED.toString().equals(triggerState.name())){
									//d.重新启动
									 try{
										 scheduler.resumeTrigger(triggerKey);
										 msg=msg+"【"+timetask.getTaskId()+":"+timetask.getTaskDescribe()+"】原任务状态为停止，重新启动任务成功；";
									 }catch(Exception e){
										 msg=msg+"【"+timetask.getTaskId()+":"+timetask.getTaskDescribe()+"】原任务状态为出错，重新启动任务失败。"+e.getMessage();
									 }
								 }
							 }
							 /**2.2 需要停止定时任务***************************************/
							 else if(SysConstants.TIMETASK_START.START_N.equals(timetask.getIsStart())){
								 if(TriggerState.NONE.toString().equals(triggerState.name())
										 ||TriggerState.PAUSED.toString().equals(triggerState.name())){
									 //a.不需要操作
								 }else{
									 //b.停止
									 try{
										 scheduler.pauseTrigger(triggerKey);
										 msg=msg+"【"+timetask.getTaskId()+":"+timetask.getTaskDescribe()+"】原任务状态为"+triggerState.name()+"，停止任务成功。";
									 }catch(Exception e){
										 msg=msg+"【"+timetask.getTaskId()+":"+timetask.getTaskDescribe()+"】原任务状态为"+triggerState.name()+"，停止任务失败。"+e.getMessage();
									 }
								 }
							 }
							 //暂时用不到
							 else if(SysConstants.TIMETASK_START.START_R.equals(timetask.getIsStart())){
								 if(TriggerState.NONE.toString().equals(triggerState.name())){
									 //a.不需要操作
								 }else{
									 //b.停止
									 JobKey jobKey = JobKey.jobKey(timetask.getTaskId(),Scheduler.DEFAULT_GROUP);
									 scheduler.deleteJob(jobKey);
									 //c.新增任务 
									 Class<?> clazz = Class.forName(timetask.getImplClass());
									 addJob(timetask,clazz,instId,scheduler);
									 //d.修改定时任务状态
								 }
							 }
						 }
						 /**3.失效的定时任务***************************************/
						 else if(SysConstants.TIMETASK_EFFECT.EFFECT_N.equals(timetask.getIsEffect())){
							 try{
								 if(!TriggerState.NONE.toString().equals(triggerState.name())){
									 try{
										 JobKey jobKey = JobKey.jobKey(timetask.getTaskId(),Scheduler.DEFAULT_GROUP);
										 scheduler.deleteJob(jobKey); 
										 msg=msg+"【"+timetask.getTaskId()+":"+timetask.getTaskDescribe()+"】原任务状态为"+triggerState.name()+"，停止任务成功。";
									 }catch(Exception e){
										 msg=msg+"【"+timetask.getTaskId()+":"+timetask.getTaskDescribe()+"】原任务状态为"+triggerState.name()+"，停止任务失败。"+e.getMessage();
									 }	 
								 }
							 }catch(Exception e){
								 msg=msg+"【"+timetask.getTaskId()+":"+timetask.getTaskDescribe()+"】原任务状态为"+triggerState.name()+"，停止任务失败。"+e.getMessage();
							 }
						 }
					}else{
						if(!TriggerState.NONE.toString().equals(triggerState.name())){
							try{
								 JobKey jobKey = JobKey.jobKey(timetask.getTaskId(),Scheduler.DEFAULT_GROUP);
								 scheduler.deleteJob(jobKey);
								 msg=msg+"【"+timetask.getTaskId()+":"+timetask.getTaskDescribe()+"】原任务状态为"+triggerState.name()+"，停止任务成功。";
							 }catch(Exception e){
								 msg=msg+"【"+timetask.getTaskId()+":"+timetask.getTaskDescribe()+"】原任务状态为"+triggerState.name()+"，停止任务失败。"+e.getMessage();
							 }
						}
					}
        		}catch(Exception e){
        			e.printStackTrace();
        		}
        	}
        }
        /***10.停止数据库中没有的定时任务*********************************************************/
        try {
			Set<TriggerKey> triggerKeys = scheduler.getTriggerKeys(GroupMatcher.anyTriggerGroup());
	        for (TriggerKey tKey : triggerKeys) {
	        	String tid = tKey.getName();
	        	String mainTaskId="manageTask_"+instId;
	        	TriggerState triggerState=scheduler.getTriggerState(tKey);
	        	
			    if(!mainTaskId.equals(tid)){
			    	if(TriggerState.NORMAL.toString().equals(triggerState.name())
						 ||TriggerState.COMPLETE.toString().equals(triggerState.name())
						 ||TriggerState.BLOCKED.toString().equals(triggerState.name())){
			    	
			        	boolean findFlag =false;
			        	if(timetaskList!=null && timetaskList.size()>0){
			            	for(SysTimetask timetask : timetaskList){
			            		if(tid.equals(timetask.getTaskId())){
			            			findFlag=true;
			            			break;
			            		}
			            	}
			        	}
			        	if(!findFlag){
			        		try{
			        		//需要停止
							 JobKey jobKey = JobKey.jobKey(tid,Scheduler.DEFAULT_GROUP);
							 scheduler.deleteJob(jobKey);
							 msg=msg+"【"+tid+"】原任务状态为"+triggerState.name()+"被删除，原因不应该被当前服务执行。";
			        		}catch(Exception e){
								 msg=msg+"【"+tid+"】原任务状态为"+triggerState.name()+"，删除任务失败。"+e.getMessage();
							 }
			        	}
					}
			    }
            }
		} catch (SchedulerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        if(msg.length()>2000){
        	msg=msg.substring(0, 1900);
        }
      context.getJobDetail().getJobDataMap().put(SysConstants.TIMETASK_BUSI.BUSI_CODE, SysConstants.TIMETASK_BUSI.BUSI_CODE_SUC);
      context.getJobDetail().getJobDataMap().put(SysConstants.TIMETASK_BUSI.BUSI_DESC, msg);
	}
	private void addJob(SysTimetask timetask,Class cls,String instId,Scheduler scheduler) throws SchedulerException{
		 JobDetail jobDetail = JobBuilder.newJob().ofType(cls)
                .withIdentity(timetask.getTaskId(),Scheduler.DEFAULT_GROUP)
                .withDescription(timetask.getTaskDescribe())
                .build();
		 Trigger trigger = TriggerBuilder.newTrigger()
                .withSchedule(CronScheduleBuilder.cronSchedule(timetask.getCronExpression().trim()))  //0/3 * * * * ?
                .forJob(timetask.getTaskId(),Scheduler.DEFAULT_GROUP)
                .withIdentity(timetask.getTaskId())
                .withDescription(timetask.getTaskDescribe())
                .build();
		 
		 jobDetail.getJobDataMap().put("instId", timetask.getInstId());
		 
		 //增加监听 
		 JobListener listener = new JobImplListener();
		 Matcher<JobKey> matcher = KeyMatcher.keyEquals(jobDetail.getKey());  
		 scheduler.getListenerManager().addJobListener(listener, matcher);      

		 scheduler.scheduleJob(jobDetail,trigger);
	}
}
