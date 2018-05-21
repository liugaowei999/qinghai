/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.service;

import java.text.SimpleDateFormat;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cttic.csms.modules.settlementfront.dao.DrBillDetailDao;
import com.cttic.csms.modules.settlementfront.entity.DrBillDetail;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;

/**
 * 省内地市结算详单Service
 * @author aryo
 * @version 2016-12-23
 */
@Service
@Transactional(readOnly = true)
public class DrBillDetailService extends CrudService<DrBillDetailDao, DrBillDetail> {

	private static final String TABLE_NAME_PREFFIX = "dr_bill_detail_";

	@Override
	public DrBillDetail get(DrBillDetail drBillDetail) {
		setDynamicTableName(drBillDetail);
		return super.get(drBillDetail);
	}

	@Override
	public Page<DrBillDetail> findPage(Page<DrBillDetail> page, DrBillDetail drBillDetail) {
		//设置动态表名
		setDynamicTableName(drBillDetail);

		//		drBillDetail.setPage(page);
		//		page.setList(dao.findList(drBillDetail)); //correct
		//		return page;
		drBillDetail.getSqlMap().put("dsf", dataScopeFilter(drBillDetail.getCurrentUser(), "o", ""));
		return super.findPage(page, drBillDetail);
	}

	/**
	 * 设置动态表名
	 * 
	 * @param bpsModuleLog 
	 */
	private void setDynamicTableName(DrBillDetail drBillDetail) {
		String tableName = getDynamicTableName(DrBillDetailService.TABLE_NAME_PREFFIX, drBillDetail);
		drBillDetail.setTableName(tableName);
	}

	/**
	 * 获取动态表名
	 * 
	 * @param tableNamePreffix 表名前缀
	 * @param bpsModuleLog 实体中包含生成动态表名相关的信息
	 * @param pattern
	 * @return
	 */
	private String getDynamicTableName(String tableNamePreffix, DrBillDetail drBillDetail) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMM");
		String strDate = "";
		if (drBillDetail.getIndbTime() == null) {
			strDate = simpleDateFormat.format(System.currentTimeMillis());
		} else {
			strDate = simpleDateFormat.format(drBillDetail.getIndbTime());
		}

		return tableNamePreffix + strDate;
	}

}