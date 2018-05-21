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
import com.cttic.csms.modules.settlementfront.entity.InfoErConf;
import com.cttic.csms.modules.settlementfront.service.InfoErConfService;

/**
 * ER错误代码下发配置文件Controller
 * @author ambitious
 * @version 2016-12-03
 */
@Controller
@RequestMapping(value = "${adminPath}/settlementfront/infoErConf")
public class InfoErConfController extends BaseController {

	@Autowired
	private InfoErConfService infoErConfService;
	
	@ModelAttribute
	public InfoErConf get(@RequestParam(required=false) String id) {
		InfoErConf entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = infoErConfService.get(id);
		}
		if (entity == null){
			entity = new InfoErConf();
		}
		return entity;
	}
	
	@RequiresPermissions("settlementfront:infoErConf:view")
	@RequestMapping(value = {"list", ""})
	public String list(InfoErConf infoErConf, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<InfoErConf> page = infoErConfService.findPage(new Page<InfoErConf>(request, response), infoErConf); 
		model.addAttribute("page", page);
		return "modules/settlementfront/infoErConfList";
	}

	@RequiresPermissions("settlementfront:infoErConf:view")
	@RequestMapping(value = "form")
	public String form(InfoErConf infoErConf, Model model,String id) {
		infoErConf = infoErConfService.get(id);
		model.addAttribute("infoErConf", infoErConf);
		return "modules/settlementfront/infoErConfForm";
	}

	@RequiresPermissions("settlementfront:infoErConf:edit")
	@RequestMapping(value = "save")
	public String save(InfoErConf infoErConf, Model model, RedirectAttributes redirectAttributes,String id) {
		if (!beanValidator(model, infoErConf)){
			return form(infoErConf, model,id);
		}
		infoErConfService.save(infoErConf);
		addMessage(redirectAttributes, "保存ER错误代码下发配置文件成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/infoErConf/?repage";
	}
	
	@RequiresPermissions("settlementfront:infoErConf:edit")
	@RequestMapping(value = "delete")
	public String delete(InfoErConf infoErConf, RedirectAttributes redirectAttributes) {
		infoErConfService.delete(infoErConf);
		addMessage(redirectAttributes, "删除ER错误代码下发配置文件成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/infoErConf/?repage";
	}

}