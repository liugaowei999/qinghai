package com.cttic.sysframe.utils;

/**
 * 系统级相关常量
 * @author dener
 * @version 2016-11-28
 */
public class SysConstants {
	/**
	 * 定时任务有效状态
	 */
	public class TIMETASK_EFFECT {
		//定时任务失效状态
		public static final String EFFECT_N = "0";
		//定时任务生效状态
		public static final String EFFECT_Y = "1";
	}
	/**
	 * 定时任务启动状态
	 */
	public class TIMETASK_START {
		//定时任务停止状态
		public static final String START_N = "0";
		//定时任务启动状态
		public static final String START_Y = "1";
		//定时任务重启状态
		public static final String START_R = "2";
	}
	/**
	 * 定时任务执行状态
	 */
	public class TIMETASK_RUN_STATE {
		//定时任务开始执行
		public static final String RUN_BEGIN = "1";
		//定时任务执行完成
		public static final String RUN_END = "2";
	}
	/**
	 * 定时任务业务相关常量
	 */
	public class TIMETASK_BUSI {
		//定时任务业务处理结果编码
		public static final String BUSI_CODE = "BUSI_CODE";
		//定时任务业务处理结果描述
		public static final String BUSI_DESC = "BUSI_DESC";
		//定时任务业务执行成功
		public static final String BUSI_CODE_SUC = "1";
		//定时任务业务执行失败
		public static final String BUSI_CODE_FAIL = "2";
	}
}
