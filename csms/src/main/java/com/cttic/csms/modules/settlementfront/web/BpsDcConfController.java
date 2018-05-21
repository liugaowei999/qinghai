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
import com.cttic.csms.modules.settlementfront.entity.BpsDcConf;
import com.cttic.csms.modules.settlementfront.service.BpsDcConfService;

/**
 * DC下发黑名单配置文件Controller
 * @author ambitious
 * @version 2016-12-03
 */
@Controller
@RequestMapping(value = "${adminPath}/settlementfront/bpsDcConf")
public class BpsDcConfController extends BaseController {

	@Autowired
	private BpsDcConfService bpsDcConfService;
	
	@ModelAttribute
	public BpsDcConf get(@RequestParam(required=false) String id) {
		BpsDcConf entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bpsDcConfService.get(id);
		}
		if (entity == null){
			entity = new BpsDcConf();
		}
		return entity;
	}
	
	@RequiresPermissions("settlementfront:bpsDcConf:view")
	@RequestMapping(value = {"list", ""})
	public String list(BpsDcConf bpsDcConf, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BpsDcConf> page = bpsDcConfService.findPage(new Page<BpsDcConf>(request, response), bpsDcConf); 
		model.addAttribute("page", page);
		return "modules/settlementfront/bpsDcConfList";
	}

	@RequiresPermissions("settlementfront:bpsDcConf:view")
	@RequestMapping(value = "form")
	public String form(BpsDcConf bpsDcConf, Model model) {
		model.addAttribute("bpsDcConf", bpsDcConf);
		return "modules/settlementfront/bpsDcConfForm";
	}

	@RequiresPermissions("settlementfront:bpsDcConf:edit")
	@RequestMapping(value = "save")
	public String save(BpsDcConf bpsDcConf, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bpsDcConf)){
			return form(bpsDcConf, model);
		}
		bpsDcConfService.save(bpsDcConf);
		addMessage(redirectAttributes, "保存DC下发黑名单成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/bpsDcConf/?repage";
	}
	
	@RequiresPermissions("settlementfront:bpsDcConf:edit")
	@RequestMapping(value = "delete")
	public String delete(BpsDcConf bpsDcConf, RedirectAttributes redirectAttributes) {
		bpsDcConfService.delete(bpsDcConf);
		addMessage(redirectAttributes, "删除DC下发黑名单成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/bpsDcConf/?repage";
	}

}