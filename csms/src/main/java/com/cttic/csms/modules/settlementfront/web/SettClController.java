/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.web;

import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.cttic.csms.modules.settlementfront.entity.SettCl;
import com.cttic.csms.modules.settlementfront.service.BpsSysOrgInfoService;
import com.cttic.csms.modules.settlementfront.service.SettClService;

/**
 * CL脱机消费明细详单Controller
 * @author wanglk
 * @version 2016-12-05
 */
@Controller
@RequestMapping(value = "${adminPath}/settlementfront/settCl")
public class SettClController extends BaseController {

	@Autowired
	private SettClService settClService;
	@Autowired
	private OfficeService officeService;
	@Autowired
	private BpsSysOrgInfoService bpsSysOrgInfoService;
	
	@ModelAttribute
	public SettCl get(@RequestParam(required=false) String id,String settDate) {
		SettCl entity = null;
		if (StringUtils.isNotBlank(id)){
			SettCl settCl=new SettCl(id);
			settCl.setSettDate(settDate);
			entity = settClService.get(settCl);
			//取机构名称
			Office recv=officeService.get(entity.getRecvOrgCode());
			if(recv!=null){
				entity.setRecvOrgCode(recv.getName());
			}
			recv=officeService.get(entity.getBillOrgId()) ;
			if(recv!=null){
				entity.setSendOrgId(recv.getName());
			}
			recv=officeService.get(entity.getBillOrgCode()) ;
			if(recv!=null){
				entity.setBillOrgCode(recv.getName());
			}
			recv=officeService.get(entity.getIssueCompanyCode());
			if(recv!=null){
				entity.setIssueCompanyCode(recv.getName());
			}
			recv=officeService.get(entity.getRecvOrgCode1()) ;
			if(recv!=null){
				entity.setRecvOrgCode1(recv.getName());
			}
			recv=officeService.get(entity.getSendOrgId()) ;
			if(recv!=null){
				entity.setSendOrgId(recv.getName());
			}
			
		}
		if (entity == null){
			entity = new SettCl();
		}
		return entity;
	}
	
	@RequiresPermissions("settlementfront:settCl:view")
	@RequestMapping(value = {"list", ""})
	public String list(SettCl settCl, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isEmpty(settCl.getSettDate())){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			settCl.setSettDate(sdf.format(new Date()));
		}

		Page<SettCl> page = settClService.findPage(new Page<SettCl>(request, response), settCl); 
		
		//取机构名称
		List<SettCl> list = page.getList();
		for (SettCl entity : list){
			//取机构名称
			Office recv=officeService.get(entity.getRecvOrgCode());
			if(recv!=null){
				entity.setRecvOrgCode(recv.getName());
			}
			recv=officeService.get(entity.getBillOrgId()) ;
			if(recv!=null){
				entity.setSendOrgId(recv.getName());
			}
			recv=officeService.get(entity.getBillOrgCode()) ;
			if(recv!=null){
				entity.setBillOrgCode(recv.getName());
			}
			recv=officeService.get(entity.getIssueCompanyCode());
			if(recv!=null){
				entity.setIssueCompanyCode(recv.getName());
			}
			recv=officeService.get(entity.getRecvOrgCode1()) ;
			if(recv!=null){
				entity.setRecvOrgCode1(recv.getName());
			}
			recv=officeService.get(entity.getSendOrgId()) ;
			if(recv!=null){
				entity.setSendOrgId(recv.getName());
			}
		}
		Map<String,String> orgInfoDropDownMap = bpsSysOrgInfoService.getOrgInfoDropDownMap();
		model.addAttribute("orgInfoDropDownMap",orgInfoDropDownMap);
		model.addAttribute("page", page);
		return "modules/settlementfront/settClList";
	}

	@RequiresPermissions("settlementfront:settCl:view")
	@RequestMapping(value = "form")
	public String form(SettCl settCl, Model model) {
		model.addAttribute("settCl", settCl);
		return "modules/settlementfront/settClForm";
	}

	@RequiresPermissions("settlementfront:settCl:edit")
	@RequestMapping(value = "save")
	public String save(SettCl settCl, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, settCl)){
			return form(settCl, model);
		}
		settClService.save(settCl);
		addMessage(redirectAttributes, "保存记录成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/settCl/?repage";
	}
	
	@RequiresPermissions("settlementfront:settCl:edit")
	@RequestMapping(value = "delete")
	public String delete(SettCl settCl, RedirectAttributes redirectAttributes) {
		settClService.delete(settCl);
		addMessage(redirectAttributes, "删除记录成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/settCl/?repage";
	}

}