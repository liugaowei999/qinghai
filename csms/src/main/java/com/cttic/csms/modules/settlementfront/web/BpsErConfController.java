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
import com.cttic.csms.modules.settlementfront.entity.BpsErConf;
import com.cttic.csms.modules.settlementfront.service.BpsErConfService;

/**
 * ER错误代码下发配置文件Controller
 * @author ambitious
 * @version 2016-12-03
 */
@Controller
@RequestMapping(value = "${adminPath}/settlementfront/bpsErConf")
public class BpsErConfController extends BaseController {

	@Autowired
	private BpsErConfService bpsErConfService;
	
	@ModelAttribute
	public BpsErConf get(@RequestParam(required=false) String id) {
		BpsErConf entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bpsErConfService.get(id);
		}
		if (entity == null){
			entity = new BpsErConf();
		}
		return entity;
	}
	
	@RequiresPermissions("settlementfront:bpsErConf:view")
	@RequestMapping(value = {"list", ""})
	public String list(BpsErConf bpsErConf, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BpsErConf> page = bpsErConfService.findPage(new Page<BpsErConf>(request, response), bpsErConf); 
		model.addAttribute("page", page);
		return "modules/settlementfront/bpsErConfList";
	}

	@RequiresPermissions("settlementfront:bpsErConf:view")
	@RequestMapping(value = "form")
	public String form(BpsErConf bpsErConf, Model model) {
		model.addAttribute("bpsErConf", bpsErConf);
		return "modules/settlementfront/bpsErConfForm";
	}

	@RequiresPermissions("settlementfront:bpsErConf:edit")
	@RequestMapping(value = "save")
	public String save(BpsErConf bpsErConf, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bpsErConf)){
			return form(bpsErConf, model);
		}
		bpsErConfService.save(bpsErConf);
		addMessage(redirectAttributes, "保存ER错误代码下发配置文件成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/bpsErConf/?repage";
	}
	
	@RequiresPermissions("settlementfront:bpsErConf:edit")
	@RequestMapping(value = "delete")
	public String delete(BpsErConf bpsErConf, RedirectAttributes redirectAttributes) {
		bpsErConfService.delete(bpsErConf);
		addMessage(redirectAttributes, "删除ER错误代码下发配置文件成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/bpsErConf/?repage";
	}

}