/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.service;

import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cttic.csms.modules.settlementfront.dao.BpsFiletransLogDao;
import com.cttic.csms.modules.settlementfront.entity.BpsFiletransLog;

/**
 * 外围系统接口传输信息记录Service
 * @author aryo
 * @version 2016-12-23
 */
@Service
@Transactional(readOnly = true)
public class BpsFiletransLogService extends CrudService<BpsFiletransLogDao, BpsFiletransLog> {
	private static final String TABLE_NAME_PREFFIX = "bps_filetrans_log_";
	public BpsFiletransLog get(BpsFiletransLog bpsFiletransLog) {
		setDynamicTableName(bpsFiletransLog);
		return super.get(bpsFiletransLog);
	}
	

	
	public Page<BpsFiletransLog> findPage(Page<BpsFiletransLog> page, BpsFiletransLog bpsFiletransLog) {
		//设置动态表名
				setDynamicTableName(bpsFiletransLog);
				
				bpsFiletransLog.setPage(page);
				page.setList(dao.findList(bpsFiletransLog)); //correct
				
				return page;
	}
	/**
	 * 设置动态表名
	 * 
	 * @param bpsModuleLog 
	 */
	private void setDynamicTableName(BpsFiletransLog bpsFiletransLog) {
		String tableName = getDynamicTableName(BpsFiletransLogService.TABLE_NAME_PREFFIX, bpsFiletransLog);
		bpsFiletransLog.setTableName(tableName); 
	}
	
	/**
	 * 获取动态表名
	 * 
	 * @param tableNamePreffix 表名前缀
	 * @param bpsModuleLog 实体中包含生成动态表名相关的信息
	 * @param pattern
	 * @return
	 */
	private String getDynamicTableName(String tableNamePreffix, BpsFiletransLog bpsFiletransLog) {
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyyMM");
		String strDate = "";
		if(bpsFiletransLog.getProcessTime()==null){
			strDate = simpleDateFormat.format(System.currentTimeMillis());
		}
		else{
			strDate = simpleDateFormat.format(bpsFiletransLog.getProcessTime());
		}
		
		return tableNamePreffix + strDate;
	}
	
	
}