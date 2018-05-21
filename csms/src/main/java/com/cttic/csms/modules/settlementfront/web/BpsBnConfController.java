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
import com.cttic.csms.modules.settlementfront.entity.BpsBnConf;
import com.cttic.csms.modules.settlementfront.service.BpsBnConfService;

/**
 * 对BN白名单进行配置Controller
 * @author ambitious
 * @version 2016-12-03
 */
@Controller
@RequestMapping(value = "${adminPath}/settlementfront/bpsBnConf")
public class BpsBnConfController extends BaseController {

	@Autowired
	private BpsBnConfService bpsBnConfService;
	
	@ModelAttribute
	public BpsBnConf get(@RequestParam(required=false) String id) {
		BpsBnConf entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bpsBnConfService.get(id);
		}
		if (entity == null){
			entity = new BpsBnConf();
		}
		return entity;
	}
	
	@RequiresPermissions("settlementfront:bpsBnConf:view")
	@RequestMapping(value = {"list", ""})
	public String list(BpsBnConf bpsBnConf, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BpsBnConf> page = bpsBnConfService.findPage(new Page<BpsBnConf>(request, response), bpsBnConf); 
		model.addAttribute("page", page);
		return "modules/settlementfront/bpsBnConfList";
	}

	@RequiresPermissions("settlementfront:bpsBnConf:view")
	@RequestMapping(value = "form")
	public String form(BpsBnConf bpsBnConf, Model model) {
		model.addAttribute("bpsBnConf", bpsBnConf);
		return "modules/settlementfront/bpsBnConfForm";
	}

	@RequiresPermissions("settlementfront:bpsBnConf:edit")
	@RequestMapping(value = "save")
	public String save(BpsBnConf bpsBnConf, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bpsBnConf)){
			return form(bpsBnConf, model);
		}
		bpsBnConfService.save(bpsBnConf);
		addMessage(redirectAttributes, "保存BN白名单成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/bpsBnConf/?repage";
	}
	
	@RequiresPermissions("settlementfront:bpsBnConf:edit")
	@RequestMapping(value = "delete")
	public String delete(BpsBnConf bpsBnConf, RedirectAttributes redirectAttributes) {
		bpsBnConfService.delete(bpsBnConf);
		addMessage(redirectAttributes, "删除BN白名单成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/bpsBnConf/?repage";
	}

}