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
import com.cttic.csms.modules.settlementfront.entity.InfoBnConf;
import com.cttic.csms.modules.settlementfront.service.BpsSysOrgInfoService;
import com.cttic.csms.modules.settlementfront.service.InfoBnConfService;

/**
 * 对BN白名单进行配置Controller
 * @author ambitious
 * @version 2016-12-03
 */
@Controller
@RequestMapping(value = "${adminPath}/settlementfront/infoBnConf")
public class InfoBnConfController extends BaseController {

	@Autowired
	private InfoBnConfService infoBnConfService;
	@Autowired
	private BpsSysOrgInfoService bpsSysOrgInfoService;
	
	@ModelAttribute
	public InfoBnConf get(@RequestParam(required=false) String id) {
		InfoBnConf entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = infoBnConfService.get(id);
		}
		if (entity == null){
			entity = new InfoBnConf();
		}
		return entity;
	}
	
	@RequiresPermissions("settlementfront:infoBnConf:view")
	@RequestMapping(value = {"list", ""})
	public String list(InfoBnConf infoBnConf, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<InfoBnConf> page = infoBnConfService.findPage(new Page<InfoBnConf>(request, response), infoBnConf); 
		Map<String,String> orgInfoDropDownMap = bpsSysOrgInfoService.getOrgInfoDropDownMap();
		model.addAttribute("orgInfoDropDownMap",orgInfoDropDownMap);
		model.addAttribute("page", page);
		return "modules/settlementfront/infoBnConfList";
	}

	@RequiresPermissions("settlementfront:infoBnConf:view")
	@RequestMapping(value = "form")
	public String form(InfoBnConf InfoBnConf, Model model) {
		model.addAttribute("InfoBnConf", InfoBnConf);
		return "modules/settlementfront/infoBnConfForm";
	}

	@RequiresPermissions("settlementfront:infoBnConf:edit")
	@RequestMapping(value = "save")
	public String save(InfoBnConf infoBnConf, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, infoBnConf)){
			return form(infoBnConf, model);
		}
		infoBnConfService.save(infoBnConf);
		addMessage(redirectAttributes, "保存BN白名单成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/InfoBnConf/?repage";
	}
	
	@RequiresPermissions("settlementfront:infoBnConf:edit")
	@RequestMapping(value = "delete")
	public String delete(InfoBnConf infoBnConf, RedirectAttributes redirectAttributes) {
		infoBnConfService.delete(infoBnConf);
		addMessage(redirectAttributes, "删除BN白名单成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/InfoBnConf/?repage";
	}

}