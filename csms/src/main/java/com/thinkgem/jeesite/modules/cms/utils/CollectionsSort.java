package com.thinkgem.jeesite.modules.cms.utils;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.lang.reflect.Method;
import java.lang.reflect.InvocationTargetException;

/**
 * 排序工具类
 * @author dener
 * @version 2016-12-8
 */
public class CollectionsSort {

	public class SortList<E> {
		public void Sort(List<E> list, final String method, final String sort) {
			Collections.sort(list, new Comparator() {
				public int compare(Object a, Object b) {
					int ret = 0;
					try {
						Method m1 = ((E) a).getClass().getMethod(method, null);
						Method m2 = ((E) b).getClass().getMethod(method, null);
						if (sort != null && "desc".equals(sort))// 倒序
							ret = m2.invoke(((E) b), null).toString().compareTo(m1.invoke(((E) a), null).toString());
						else// 正序
							ret = m1.invoke(((E) a), null).toString().compareTo(m2.invoke(((E) b), null).toString());
					} catch (NoSuchMethodException ne) {
						System.out.println(ne);
					} catch (IllegalAccessException ie) {
						System.out.println(ie);
					} catch (InvocationTargetException it) {
						System.out.println(it);
					}
					return ret;
				}
			});
		}
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		List<UserInfo> list = new ArrayList<UserInfo>();
//		SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd"); 
//        list.add(new UserInfo(3,"b",formater.parse("1980-12-01"),11));
//        list.add(new UserInfo(1,"c",formater.parse("1980-10-01"),30)); 
//		list.add(new UserInfo(2,"a",formater.parse("1973-10-01"),11)); 
//		System.out.println("-------原来序列-------------------");
//         for(UserInfo user : list){
//        	 System.out.println(user.toString());    
//         }          
//         //调用排序通用类    
//         SortList<UserInfo> sortList = new SortList<UserInfo>();
//        //按userId排序    
//         sortList.Sort(list, "getUserId", "desc");    
//         System.out.println("--------按userId倒序------------------");   
//         for(UserInfo user : list){    
//        	 System.out.println(user.toString());    
//         }
	}

}
