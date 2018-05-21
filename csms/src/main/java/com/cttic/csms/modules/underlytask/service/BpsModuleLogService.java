/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.underlytask.service;

import java.text.SimpleDateFormat;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cttic.csms.modules.underlytask.dao.BpsModuleLogDao;
import com.cttic.csms.modules.underlytask.entity.BpsModuleLog;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;

/**
 * 对日志表记录进行查询Service
 * @author wanglk
 * @version 2016-11-12
 */
@Service
@Transactional(readOnly = true)
public class BpsModuleLogService extends CrudService<BpsModuleLogDao, BpsModuleLog> {
	private static final String TABLE_NAME_PREFFIX = "bps_module_log_";

	public BpsModuleLog get(BpsModuleLog bpsModuleLog) {
		setDynamicTableName(bpsModuleLog);
		return super.get(bpsModuleLog);
	}

	public Page<BpsModuleLog> findPage(Page<BpsModuleLog> page, BpsModuleLog bpsModuleLog) {
		//设置动态表名
		setDynamicTableName(bpsModuleLog);
		
		bpsModuleLog.setPage(page);
		page.setList(dao.findList(bpsModuleLog)); //correct
		
		return page;
		
	}
	
	/**
	 * 设置动态表名
	 * 
	 * @param bpsModuleLog 
	 */
	private void setDynamicTableName(BpsModuleLog bpsModuleLog) {
		String tableName = getDynamicTableName(BpsModuleLogService.TABLE_NAME_PREFFIX, bpsModuleLog);
		bpsModuleLog.setTableName(tableName); 
	}
	
	/**
	 * 获取动态表名
	 * 
	 * @param tableNamePreffix 表名前缀
	 * @param bpsModuleLog 实体中包含生成动态表名相关的信息
	 * @param pattern
	 * @return
	 */
	private String getDynamicTableName(String tableNamePreffix, BpsModuleLog bpsModuleLog) {
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyyMM");
		String strDate = "";
		if(bpsModuleLog.getBeginDealTime()==null){
			strDate = simpleDateFormat.format(System.currentTimeMillis());
		}
		else{
			strDate = simpleDateFormat.format(bpsModuleLog.getBeginDealTime());
		}
		
		return tableNamePreffix + strDate;
	}
	
}