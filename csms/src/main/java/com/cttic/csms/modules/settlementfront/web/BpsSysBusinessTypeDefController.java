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
import com.cttic.csms.modules.settlementfront.entity.BpsSysBusinessTypeDef;
import com.cttic.csms.modules.settlementfront.service.BpsSysBusinessTypeDefService;

/**
 * 行业类型配置Controller
 * @author aryo
 * @version 2016-12-03
 */
@Controller
@RequestMapping(value = "${adminPath}/settlementfront/bpsSysBusinessTypeDef")
public class BpsSysBusinessTypeDefController extends BaseController {

	@Autowired
	private BpsSysBusinessTypeDefService bpsSysBusinessTypeDefService;
	
	@ModelAttribute
	public BpsSysBusinessTypeDef get(@RequestParam(required=false) String id) {
		BpsSysBusinessTypeDef entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bpsSysBusinessTypeDefService.get(id);
		}
		if (entity == null){
			entity = new BpsSysBusinessTypeDef();
		}
		return entity;
	}
	
	@RequiresPermissions("settlementfront:bpsSysBusinessTypeDef:view")
	@RequestMapping(value = {"list", ""})
	public String list(BpsSysBusinessTypeDef bpsSysBusinessTypeDef, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BpsSysBusinessTypeDef> page = bpsSysBusinessTypeDefService.findPage(new Page<BpsSysBusinessTypeDef>(request, response), bpsSysBusinessTypeDef); 
		model.addAttribute("businessTypesDropDownMap", bpsSysBusinessTypeDefService.getBusinessTypesDropDownMap());
		//model.addAttribute("businessNameDropDownMap", bpsSysBusinessTypeDefService.getBusinessNameDropDownMap());
		model.addAttribute("page", page);
		return "modules/settlementfront/bpsSysBusinessTypeDefList";
	}

	@RequiresPermissions("settlementfront:bpsSysBusinessTypeDef:view")
	@RequestMapping(value = "form")
	public String form(BpsSysBusinessTypeDef bpsSysBusinessTypeDef, Model model) {
		model.addAttribute("bpsSysBusinessTypeDef", bpsSysBusinessTypeDef);
		return "modules/settlementfront/bpsSysBusinessTypeDefForm";
	}

	@RequiresPermissions("settlementfront:bpsSysBusinessTypeDef:edit")
	@RequestMapping(value = "save")
	public String save(BpsSysBusinessTypeDef bpsSysBusinessTypeDef, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bpsSysBusinessTypeDef)){
			return form(bpsSysBusinessTypeDef, model);
		}
		bpsSysBusinessTypeDefService.save(bpsSysBusinessTypeDef);
		addMessage(redirectAttributes, "保存清算费率成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/bpsSysBusinessTypeDef/?repage";
	}
	
	@RequiresPermissions("settlementfront:bpsSysBusinessTypeDef:edit")
	@RequestMapping(value = "delete")
	public String delete(BpsSysBusinessTypeDef bpsSysBusinessTypeDef, RedirectAttributes redirectAttributes) {
		bpsSysBusinessTypeDefService.delete(bpsSysBusinessTypeDef);
		addMessage(redirectAttributes, "删除清算费率成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/bpsSysBusinessTypeDef/?repage";
	}

}