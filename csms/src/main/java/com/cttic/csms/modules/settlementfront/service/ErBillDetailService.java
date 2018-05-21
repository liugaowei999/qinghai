/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.service;

import java.text.SimpleDateFormat;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cttic.csms.modules.settlementfront.dao.ErBillDetailDao;
import com.cttic.csms.modules.settlementfront.entity.ErBillDetail;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;

/**
 * 省内地市结算异常记录Service
 * @author aryo
 * @version 2016-12-23
 */
@Service
@Transactional(readOnly = true)
public class ErBillDetailService extends CrudService<ErBillDetailDao, ErBillDetail> {

	private static final String TABLE_NAME_PREFFIX = "er_bill_detail_";
	private static final String DR_TABLE_NAME_PREFFIX = "dr_bill_detail_";
	private static final String FB_TABLE_NAME_PREFFIX = "sett_fb_";

	@Override
	public ErBillDetail get(ErBillDetail erBillDetail) {
		setDynamicTableName(erBillDetail);
		return super.get(erBillDetail);
	}

	@Override
	public Page<ErBillDetail> findPage(Page<ErBillDetail> page, ErBillDetail erBillDetail) {
		//设置动态表名
		setDynamicTableName(erBillDetail);

		//		erBillDetail.setPage(page);
		//		page.setList(dao.findList(erBillDetail)); //correct
		//		return page;

		erBillDetail.getSqlMap().put("dsf", dataScopeFilter(erBillDetail.getCurrentUser(), "o", ""));
		return super.findPage(page, erBillDetail);

	}

	/**
	 * 设置动态表名
	 * 
	 * @param bpsModuleLog 
	 */
	private void setDynamicTableName(ErBillDetail erBillDetail) {
		String tableName = getDynamicTableName(ErBillDetailService.TABLE_NAME_PREFFIX, erBillDetail);
		erBillDetail.setTableName(tableName);

		String drtableName = getDynamicTableName(ErBillDetailService.DR_TABLE_NAME_PREFFIX, erBillDetail);
		erBillDetail.setDrTableName(drtableName);

		String fbtableName = getDynamicTableName(ErBillDetailService.FB_TABLE_NAME_PREFFIX, erBillDetail);
		erBillDetail.setFbTableName(fbtableName);
	}

	/**
	 * 获取动态表名
	 * 
	 * @param tableNamePreffix 表名前缀
	 * @param bpsModuleLog 实体中包含生成动态表名相关的信息
	 * @param pattern
	 * @return
	 */
	private String getDynamicTableName(String tableNamePreffix, ErBillDetail erBillDetail) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMM");
		String strDate = "";
		if (erBillDetail.getIndbTime() == null) {
			strDate = simpleDateFormat.format(System.currentTimeMillis());
		} else {
			strDate = simpleDateFormat.format(erBillDetail.getIndbTime());
		}

		return tableNamePreffix + strDate;
	}

}