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
import com.cttic.csms.modules.settlementfront.entity.BpsUcConf;
import com.cttic.csms.modules.settlementfront.service.BpsUcConfService;

/**
 * UC上发黑名单配置文件Controller
 * @author ambitious
 * @version 2016-12-03
 */
@Controller
@RequestMapping(value = "${adminPath}/settlementfront/bpsUcConf")
public class BpsUcConfController extends BaseController {

	@Autowired
	private BpsUcConfService bpsUcConfService;
	
	@ModelAttribute
	public BpsUcConf get(@RequestParam(required=false) String id) {
		BpsUcConf entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bpsUcConfService.get(id);
		}
		if (entity == null){
			entity = new BpsUcConf();
		}
		return entity;
	}
	
	@RequiresPermissions("settlementfront:bpsUcConf:view")
	@RequestMapping(value = {"list", ""})
	public String list(BpsUcConf bpsUcConf, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BpsUcConf> page = bpsUcConfService.findPage(new Page<BpsUcConf>(request, response), bpsUcConf); 
		model.addAttribute("page", page);
		return "modules/settlementfront/bpsUcConfList";
	}

	@RequiresPermissions("settlementfront:bpsUcConf:view")
	@RequestMapping(value = "form")
	public String form(BpsUcConf bpsUcConf, Model model) {
		model.addAttribute("bpsUcConf", bpsUcConf);
		return "modules/settlementfront/bpsUcConfForm";
	}

	@RequiresPermissions("settlementfront:bpsUcConf:edit")
	@RequestMapping(value = "save")
	public String save(BpsUcConf bpsUcConf, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bpsUcConf)){
			return form(bpsUcConf, model);
		}
		bpsUcConfService.save(bpsUcConf);
		addMessage(redirectAttributes, "保存UC上发黑名单配置文件成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/bpsUcConf/?repage";
	}
	
	@RequiresPermissions("settlementfront:bpsUcConf:edit")
	@RequestMapping(value = "delete")
	public String delete(BpsUcConf bpsUcConf, RedirectAttributes redirectAttributes) {
		bpsUcConfService.delete(bpsUcConf);
		addMessage(redirectAttributes, "删除UC上发黑名单配置文件成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/bpsUcConf/?repage";
	}

}