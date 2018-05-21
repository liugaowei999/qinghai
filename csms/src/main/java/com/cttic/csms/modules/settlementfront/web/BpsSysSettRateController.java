/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.web;

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
import com.cttic.csms.modules.settlementfront.entity.BpsSysSettRate;
import com.cttic.csms.modules.settlementfront.service.BpsSysBusinessTypeDefService;
import com.cttic.csms.modules.settlementfront.service.BpsSysOrgInfoService;
import com.cttic.csms.modules.settlementfront.service.BpsSysServiceTypeDefService;
import com.cttic.csms.modules.settlementfront.service.BpsSysSettRateService;

/**
 * 清算费率Controller
 * @author aryo
 * @version 2016-12-03
 */
@Controller
@RequestMapping(value = "${adminPath}/settlementfront/bpsSysSettRate")
public class BpsSysSettRateController extends BaseController {

	@Autowired
	private BpsSysSettRateService bpsSysSettRateService;
	@Autowired
	private BpsSysOrgInfoService bpsSysOrgInfoService;
	@Autowired
	private BpsSysBusinessTypeDefService bpsSysBusinessTypeDefService;
	@Autowired
	private BpsSysServiceTypeDefService bpsSysServiceTypeDefService;
	
	@ModelAttribute
	public BpsSysSettRate get(@RequestParam(required=false) String id) {
		BpsSysSettRate entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bpsSysSettRateService.get(id);
		}
		if (entity == null){
			entity = new BpsSysSettRate();
		}
		return entity;
	}
	
	@RequiresPermissions("settlementfront:bpsSysSettRate:view")
	@RequestMapping(value = {"list", ""})
	public String list(BpsSysSettRate bpsSysSettRate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BpsSysSettRate> page = bpsSysSettRateService.findPage(new Page<BpsSysSettRate>(request, response), bpsSysSettRate);
		model.addAttribute("orgNameDropDownMap", bpsSysOrgInfoService.getOrgNameDropDownMap());
		model.addAttribute("businessTypeDropDownMap", bpsSysBusinessTypeDefService.getBusinessTypeDropDownMap());
		model.addAttribute("serviceTypeDropDownMap", bpsSysServiceTypeDefService.getServiceTypeDropDownMap());
		model.addAttribute("page", page);
		return "modules/settlementfront/bpsSysSettRateList";
	}

	@RequiresPermissions("settlementfront:bpsSysSettRate:view")
	@RequestMapping(value = "form")
	public String form(BpsSysSettRate bpsSysSettRate, Model model) {
		model.addAttribute("orgNameDropDownMap", bpsSysOrgInfoService.getOrgNameDropDownMap());
		model.addAttribute("businessTypeDropDownMap", bpsSysBusinessTypeDefService.getBusinessTypeDropDownMap());
		model.addAttribute("serviceTypeDropDownMap", bpsSysServiceTypeDefService.getServiceTypeDropDownMap());
		model.addAttribute("bpsSysSettRate", bpsSysSettRate);
		return "modules/settlementfront/bpsSysSettRateForm";
	}

	@RequiresPermissions("settlementfront:bpsSysSettRate:edit")
	@RequestMapping(value = "save")
	public String save(BpsSysSettRate bpsSysSettRate, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bpsSysSettRate)){
			return form(bpsSysSettRate, model);
		}
		bpsSysSettRateService.save(bpsSysSettRate);
		addMessage(redirectAttributes, "保存清算费率成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/bpsSysSettRate/?repage";
	}
	
	@RequiresPermissions("settlementfront:bpsSysSettRate:edit")
	@RequestMapping(value = "delete")
	public String delete(BpsSysSettRate bpsSysSettRate, RedirectAttributes redirectAttributes) {
		bpsSysSettRateService.delete(bpsSysSettRate);
		addMessage(redirectAttributes, "删除清算费率成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/bpsSysSettRate/?repage";
	}

}