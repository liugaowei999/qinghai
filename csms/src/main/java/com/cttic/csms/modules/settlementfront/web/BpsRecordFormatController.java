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
import com.cttic.csms.modules.settlementfront.entity.BpsRecordFormat;
import com.cttic.csms.modules.settlementfront.service.BpsRecordFormatService;

/**
 * 清单记录格式定义Controller
 * @author aryo
 * @version 2016-12-03
 */
@Controller
@RequestMapping(value = "${adminPath}/settlementfront/bpsRecordFormat")
public class BpsRecordFormatController extends BaseController {

	@Autowired
	private BpsRecordFormatService bpsRecordFormatService;
	
	@ModelAttribute
	public BpsRecordFormat get(@RequestParam(required=false) String id) {
		BpsRecordFormat entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bpsRecordFormatService.get(id);
		}
		if (entity == null){
			entity = new BpsRecordFormat();
		}
		return entity;
	}
	
	@RequiresPermissions("settlementfront:bpsRecordFormat:view")
	@RequestMapping(value = {"list", ""})
	public String list(BpsRecordFormat bpsRecordFormat, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BpsRecordFormat> page = bpsRecordFormatService.findPage(new Page<BpsRecordFormat>(request, response), bpsRecordFormat); 
		model.addAttribute("drTypeDropDownMap", bpsRecordFormatService.getDrTypeDropDownMap());
		model.addAttribute("page", page);
		return "modules/settlementfront/bpsRecordFormatList";
	}

	@RequiresPermissions("settlementfront:bpsRecordFormat:view")
	@RequestMapping(value = "form")
	public String form(BpsRecordFormat bpsRecordFormat, Model model) {
		model.addAttribute("bpsRecordFormat", bpsRecordFormat);
		return "modules/settlementfront/bpsRecordFormatForm";
	}

	@RequiresPermissions("settlementfront:bpsRecordFormat:edit")
	@RequestMapping(value = "save")
	public String save(BpsRecordFormat bpsRecordFormat, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bpsRecordFormat)){
			return form(bpsRecordFormat, model);
		}
		bpsRecordFormatService.save(bpsRecordFormat);
		addMessage(redirectAttributes, "保存清单记录格式定义成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/bpsRecordFormat/?repage";
	}
	
	@RequiresPermissions("settlementfront:bpsRecordFormat:edit")
	@RequestMapping(value = "delete")
	public String delete(BpsRecordFormat bpsRecordFormat, RedirectAttributes redirectAttributes) {
		bpsRecordFormatService.delete(bpsRecordFormat);
		addMessage(redirectAttributes, "删除清单记录格式定义成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/bpsRecordFormat/?repage";
	}

}