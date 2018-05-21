package com.cttic.csms.common.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.thinkgem.jeesite.common.utils.DateUtils;

public class CsmsDateUtils extends DateUtils {
	// 计算天数差
	public static int getIntervalDays(Date date1, Date date2) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date1);
		int day1 = cal.get(Calendar.DAY_OF_YEAR);
		cal.setTime(date2);
		int day2 = cal.get(Calendar.DAY_OF_YEAR);
		return Math.abs(day1 - day2 + 1);
	}

	// 判断是否周一
	public static boolean isMonday() {
		Calendar cal = Calendar.getInstance();
		int weekDay = cal.get(Calendar.DAY_OF_WEEK) - 1;
		if (weekDay == 1)
		/*if (weekDay == 3) */
		{
			return true;
		}
		return false;
	}

	// 判断是否每月1号
	public static boolean isMonthOne() {
		Calendar cal = Calendar.getInstance();
		int MonthDay = cal.get(Calendar.DAY_OF_MONTH);
		/*if (MonthDay == 30) */
		if (MonthDay == 1) 
		{
			return true;
		}
		return false;
	}

	// 取上月1号和上月末日期
	public static String getMonthDay(int num) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, -1);
		// 1号
		if (num == 1) {
			cal.set(Calendar.DAY_OF_MONTH, cal.getActualMinimum(Calendar.DAY_OF_MONTH));
		}
		// 月末
		else {
			cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		}

		String monthDay = sdf.format(cal.getTime());
		return monthDay;
	}

	// 取上周一和上周日日期
	public static String getWeekDay(int num) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		// 上周一
		if (num == 1) {
			cal.add(Calendar.DATE, -7);// 上周一
			cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
		}
		// 上周日对应日历中的本周日,日历为SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, and
		// SATURDAY.
		else {
			cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
		}

		String weekDay = sdf.format(cal.getTime());
		return weekDay;
	}
	
	/**
	 * 获取传入时间的周一
	 * 
	 * @param date 若为null，则取当前时间的本周一
	 * @return 返回传入时间当周星期一
	 */
	public static String getMondayOfWeek(Date date) {
		Calendar cal = Calendar.getInstance();
		if(date != null) {
			cal.setTime(date);
		}
		cal.add(Calendar.DAY_OF_MONTH, -1); //解决周日会出现 并到下一周的情况
		cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
		
		return CsmsDateUtils.formatDate(cal.getTime());

	}
	
	/**
	 * 获取传入时间的周二
	 * 
	 * @param date 若为null，则取当前时间的本周二
	 * @return 返回传入时间当周星期二
	 */
	public static String getTuesdayOfWeek(Date date) {
		Calendar cal = Calendar.getInstance();
		if(date != null) {
			cal.setTime(date);
		}
		cal.add(Calendar.DAY_OF_MONTH, -1); //解决周日会出现 并到下一周的情况
		cal.set(Calendar.DAY_OF_WEEK, Calendar.TUESDAY);
		return CsmsDateUtils.formatDate(cal.getTime());

	}
	
	/**
	 * 获取当前月份有多少天
	 * @return
	 */
	public static int getDayNumOfMonth() {
		Calendar cal = Calendar.getInstance();
		return cal.getActualMaximum(Calendar.DATE);
	}
	
}
