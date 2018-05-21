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
import com.cttic.csms.modules.settlementfront.entity.DrBillDetail;
import com.cttic.csms.modules.settlementfront.service.BpsSysOrgInfoService;
import com.cttic.csms.modules.settlementfront.service.DrBillDetailService;

/**
 * 省内地市结算详单Controller
 * @author aryo
 * @version 2016-12-23
 */
@Controller
@RequestMapping(value = "${adminPath}/settlementfront/drBillDetail")
public class DrBillDetailController extends BaseController {

	@Autowired
	private DrBillDetailService drBillDetailService;
	@Autowired
	private BpsSysOrgInfoService bpsSysOrgInfoService;
	@ModelAttribute
	public DrBillDetail get(@RequestParam(required=false) String id) {
		DrBillDetail entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = drBillDetailService.get(id);
		}
		if (entity == null){
			entity = new DrBillDetail();
		}
		return entity;
	}
	
	@RequiresPermissions("settlementfront:drBillDetail:view")
	@RequestMapping(value = {"list", ""})
	public String list(DrBillDetail drBillDetail, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DrBillDetail> page = drBillDetailService.findPage(new Page<DrBillDetail>(request, response), drBillDetail); 
		Map<String,String> orgInfoDropDownMap = bpsSysOrgInfoService.getOrgInfoDropDownMap();
		model.addAttribute("orgInfoDropDownMap",orgInfoDropDownMap);
		model.addAttribute("page", page);
		return "modules/settlementfront/drBillDetailList";
	}

	@RequiresPermissions("settlementfront:drBillDetail:view")
	@RequestMapping(value = "form")
	public String form(DrBillDetail drBillDetail, Model model) {
		model.addAttribute("drBillDetail", drBillDetail);
		return "modules/settlementfront/drBillDetailForm";
	}

	@RequiresPermissions("settlementfront:drBillDetail:edit")
	@RequestMapping(value = "save")
	public String save(DrBillDetail drBillDetail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, drBillDetail)){
			return form(drBillDetail, model);
		}
		drBillDetailService.save(drBillDetail);
		addMessage(redirectAttributes, "保存省内地市结算详单成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/drBillDetail/?repage";
	}
	
	@RequiresPermissions("settlementfront:drBillDetail:edit")
	@RequestMapping(value = "delete")
	public String delete(DrBillDetail drBillDetail, RedirectAttributes redirectAttributes) {
		drBillDetailService.delete(drBillDetail);
		addMessage(redirectAttributes, "删除省内地市结算详单成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/drBillDetail/?repage";
	}

}