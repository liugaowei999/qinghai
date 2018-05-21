package com.cttic.sysframe.timetask.implClass;

import org.quartz.CronScheduleBuilder;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.JobListener;
import org.quartz.Matcher;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.impl.matchers.KeyMatcher;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;

import com.cttic.sysframe.timetask.entity.SysTimetask;
import com.cttic.sysframe.utils.PropertiesUtil;
/**
 * 定时任务启动类
 * @author dener
 * @version 2016-12-8
 */
public class DataBaseSchedulerFactoryBean extends SchedulerFactoryBean {
	
	/**
	 * 读取数据库判断是否开始定时任务
	 */
	public void afterPropertiesSet() throws Exception {

		super.afterPropertiesSet();
		PropertiesUtil properties = new PropertiesUtil("sysframe.properties");
		String instId=properties.readProperty("inst_id");
		String manageTaskCronExpression=properties.readProperty("manage_task_cron_expression");
		
		//增加当前服务实例总体调度定时任务
		Class<?> clazz = Class.forName("com.cttic.sysframe.timetask.implClass.ManageTaskJob");
		SysTimetask timetask = new  SysTimetask();
		timetask.setTaskId("manageTask_"+instId);
		timetask.setTaskDescribe("定时管理任务："+instId);
		timetask.setCronExpression(manageTaskCronExpression);
		timetask.setInstId(instId);
		addJob(timetask,clazz,instId);
		
	    this.getScheduler().start();
	
	}
	private void addJob(SysTimetask timetask, Class cls,String instId) throws SchedulerException{
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
		 jobDetail.getJobDataMap().put("scheduler", this.getScheduler());
		 //增加监听 
		 JobListener listener = new JobImplListener();
		 Matcher<JobKey> matcher = KeyMatcher.keyEquals(jobDetail.getKey());  
		 this.getScheduler().getListenerManager().addJobListener(listener, matcher);      

		 this.getScheduler().scheduleJob(jobDetail,trigger);
	}
}
