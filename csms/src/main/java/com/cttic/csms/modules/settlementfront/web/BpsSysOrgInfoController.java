/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.web;

import java.util.HashMap;
import java.util.List;
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
import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.sys.service.AreaService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.cttic.csms.modules.cash.entity.CashProvisions;
import com.cttic.csms.modules.settlementfront.entity.BpsSysOrgInfo;
import com.cttic.csms.modules.settlementfront.service.BpsSysOrgInfoService;

/**
 * 入网机构配置Controller
 * @author aryo
 * @version 2016-12-03
 */
@Controller
@RequestMapping(value = "${adminPath}/settlementfront/bpsSysOrgInfo")
public class BpsSysOrgInfoController extends BaseController {

	@Autowired
	private BpsSysOrgInfoService bpsSysOrgInfoService;
	@Autowired
	private AreaService areaService;
	
	@ModelAttribute
	public BpsSysOrgInfo get(@RequestParam(required=false) String id) {
		BpsSysOrgInfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bpsSysOrgInfoService.get(id);
		}
		if (entity == null){
			entity = new BpsSysOrgInfo();
		}
		return entity;
	}
	
	@RequiresPermissions("settlementfront:bpsSysOrgInfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(BpsSysOrgInfo bpsSysOrgInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BpsSysOrgInfo> page = bpsSysOrgInfoService.findPage(new Page<BpsSysOrgInfo>(request, response), bpsSysOrgInfo); 
		model.addAttribute("orgInfoDropDownMap", bpsSysOrgInfoService.getOrgCodeDropDownMap());
		model.addAttribute("page", page);
		return "modules/settlementfront/bpsSysOrgInfoList";
	}

	@RequiresPermissions("settlementfront:bpsSysOrgInfo:view")
	@RequestMapping(value = "form")
	public String form(BpsSysOrgInfo bpsSysOrgInfo, Model model) {
		model.addAttribute("bpsSysOrgInfo", bpsSysOrgInfo);
		return "modules/settlementfront/bpsSysOrgInfoForm";
	}

	@RequiresPermissions("settlementfront:bpsSysOrgInfo:edit")
	@RequestMapping(value = "save")
	public String save(BpsSysOrgInfo bpsSysOrgInfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bpsSysOrgInfo)){
			return form(bpsSysOrgInfo, model);
		}
		/*String citycode = bpsSysOrgInfo.getCityCode();
		Area area = areaService.get(citycode);
		bpsSysOrgInfo.setAreaType(area.getType());*/
		bpsSysOrgInfoService.save(bpsSysOrgInfo);
		addMessage(redirectAttributes, "保存入网机构配置成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/bpsSysOrgInfo/?repage";
	}
	
	@RequiresPermissions("settlementfront:bpsSysOrgInfo:edit")
	@RequestMapping(value = "delete")
	public String delete(BpsSysOrgInfo bpsSysOrgInfo, RedirectAttributes redirectAttributes) {
		bpsSysOrgInfoService.delete(bpsSysOrgInfo);
		addMessage(redirectAttributes, "删除入网机构配置成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/bpsSysOrgInfo/?repage";
	}
	
	

}