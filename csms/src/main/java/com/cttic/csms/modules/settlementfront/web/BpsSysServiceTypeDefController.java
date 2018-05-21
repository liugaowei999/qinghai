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
import com.cttic.csms.modules.settlementfront.entity.BpsSysServiceTypeDef;
import com.cttic.csms.modules.settlementfront.service.BpsSysServiceTypeDefService;

/**
 * 业务类型定义Controller
 * @author aryo
 * @version 2016-12-03
 */
@Controller
@RequestMapping(value = "${adminPath}/settlementfront/bpsSysServiceTypeDef")
public class BpsSysServiceTypeDefController extends BaseController {

	@Autowired
	private BpsSysServiceTypeDefService bpsSysServiceTypeDefService;
	
	@ModelAttribute
	public BpsSysServiceTypeDef get(@RequestParam(required=false) String id) {
		BpsSysServiceTypeDef entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bpsSysServiceTypeDefService.get(id);
		}
		if (entity == null){
			entity = new BpsSysServiceTypeDef();
		}
		return entity;
	}
	
	@RequiresPermissions("settlementfront:bpsSysServiceTypeDef:view")
	@RequestMapping(value = {"list", ""})
	public String list(BpsSysServiceTypeDef bpsSysServiceTypeDef, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BpsSysServiceTypeDef> page = bpsSysServiceTypeDefService.findPage(new Page<BpsSysServiceTypeDef>(request, response), bpsSysServiceTypeDef); 
		model.addAttribute("serviceTypesDropDownMap", bpsSysServiceTypeDefService.getServiceTypesDropDownMap());
		model.addAttribute("page", page);
		return "modules/settlementfront/bpsSysServiceTypeDefList";
	}

	@RequiresPermissions("settlementfront:bpsSysServiceTypeDef:view")
	@RequestMapping(value = "form")
	public String form(BpsSysServiceTypeDef bpsSysServiceTypeDef, Model model) {
		model.addAttribute("bpsSysServiceTypeDef", bpsSysServiceTypeDef);
		return "modules/settlementfront/bpsSysServiceTypeDefForm";
	}

	@RequiresPermissions("settlementfront:bpsSysServiceTypeDef:edit")
	@RequestMapping(value = "save")
	public String save(BpsSysServiceTypeDef bpsSysServiceTypeDef, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bpsSysServiceTypeDef)){
			return form(bpsSysServiceTypeDef, model);
		}
		bpsSysServiceTypeDefService.save(bpsSysServiceTypeDef);
		addMessage(redirectAttributes, "保存业务类型成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/bpsSysServiceTypeDef/?repage";
	}
	
	@RequiresPermissions("settlementfront:bpsSysServiceTypeDef:edit")
	@RequestMapping(value = "delete")
	public String delete(BpsSysServiceTypeDef bpsSysServiceTypeDef, RedirectAttributes redirectAttributes) {
		bpsSysServiceTypeDefService.delete(bpsSysServiceTypeDef);
		addMessage(redirectAttributes, "删除业务类型成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/bpsSysServiceTypeDef/?repage";
	}

}