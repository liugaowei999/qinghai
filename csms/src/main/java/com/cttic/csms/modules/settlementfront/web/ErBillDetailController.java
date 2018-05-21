/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.cttic.csms.modules.settlementfront.entity.ErBillDetail;
import com.cttic.csms.modules.settlementfront.service.BpsSysOrgInfoService;
import com.cttic.csms.modules.settlementfront.service.ErBillDetailService;

/**
 * 省内地市结算异常记录Controller
 * @author aryo
 * @version 2016-12-23
 */
@Controller
@RequestMapping(value = "${adminPath}/settlementfront/erBillDetail")
public class ErBillDetailController extends BaseController {

	@Autowired
	private ErBillDetailService erBillDetailService;
	
	@Autowired
	private BpsSysOrgInfoService bpsSysOrgInfoService;
	
	@RequiresPermissions("settlementfront:erBillDetail:view")
	@RequestMapping(value = {"list", ""})
	public String list(ErBillDetail erBillDetail, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ErBillDetail> page = erBillDetailService.findPage(new Page<ErBillDetail>(request, response), erBillDetail); 
		Map<String,String> orgInfoDropDownMap = bpsSysOrgInfoService.getOrgInfoDropDownMap();
		model.addAttribute("orgInfoDropDownMap",orgInfoDropDownMap);
		model.addAttribute("page", page);
		return "modules/settlementfront/erBillDetailList";
	}

	

}