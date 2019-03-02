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
import com.cttic.csms.modules.settlementfront.entity.SettFb;
import com.cttic.csms.modules.settlementfront.service.BpsSysOrgInfoService;
import com.cttic.csms.modules.settlementfront.service.SettFbService;

/**
 * FB清算反馈文件详单Controller
 * @author wanglk
 * @version 2016-12-05
 */
@Controller
@RequestMapping(value = "${adminPath}/settlementfront/settFb")
public class SettFbController extends BaseController {

	@Autowired
	private SettFbService settFbService;
	@Autowired
	private OfficeService officeService;
	
	@Autowired
	private BpsSysOrgInfoService bpsSysOrgInfoService;
	
	@ModelAttribute
	public SettFb get(@RequestParam(required=false) String id,String settDate) {
		SettFb entity = null;
		if (StringUtils.isNotBlank(id)){
			SettFb settFb=new SettFb(id);
			settFb.setSettDate(settDate);
			entity = settFbService.get(settFb);
			//取机构名称
			Office recv=officeService.get(entity.getRecvOrgCode());
			if(recv!=null){
				entity.setRecvOrgCode(recv.getName());
			}
			recv=officeService.get(entity.getBillOrgId()) ;
			if(recv!=null){
				entity.setSendOrgId(recv.getName());
			}
			recv=officeService.get(entity.getRecvOrgId()) ;
			if(recv!=null){
				entity.setRecvOrgId(recv.getName());
			}
			recv=officeService.get(entity.getIssueCompanyCode());
			if(recv!=null){
				entity.setIssueCompanyCode(recv.getName());
			}
			recv=officeService.get(entity.getSendOrgId()) ;
			if(recv!=null){
				entity.setSendOrgId(recv.getName());
			}
		}
		if (entity == null){
			entity = new SettFb();
		}
		return entity;
	}
	
	@RequiresPermissions("settlementfront:settFb:view")
	@RequestMapping(value = {"list", ""})
	public String list(SettFb settFb, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isEmpty(settFb.getSettDate())){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			settFb.setSettDate(sdf.format(new Date()));
		}
		
		Page<SettFb> page = settFbService.findPage(new Page<SettFb>(request, response), settFb); 
		
		//取机构名称
		List<SettFb> list = page.getList();
		for (SettFb entity : list){
			//取机构名称
//			Office recv=officeService.get(entity.getRecvOrgCode());
//			if(recv!=null){
//				entity.setRecvOrgCode(recv.getName());
//			}
			Office recv=officeService.get(entity.getBillOrgId()) ;
			if(recv!=null){
				entity.setSendOrgId(recv.getName());
			}
//			recv=officeService.get(entity.getRecvOrgId()) ;
//			if(recv!=null){
//				entity.setRecvOrgId(recv.getName());
//			}
//			recv=officeService.get(entity.getIssueCompanyCode());
//			if(recv!=null){
//				entity.setIssueCompanyCode(recv.getName());
//			}
//			recv=officeService.get(entity.getSendOrgId()) ;
//			if(recv!=null){
//				entity.setSendOrgId(recv.getName());
//			}
		}
		Map<String,String> orgInfoDropDownMap = bpsSysOrgInfoService.getOrgInfoDropDownMap();
		model.addAttribute("orgInfoDropDownMap",orgInfoDropDownMap);
		model.addAttribute("page", page);
		return "modules/settlementfront/settFbList";
	}

	@RequiresPermissions("settlementfront:settFb:view")
	@RequestMapping(value = "form")
	public String form(SettFb settFb, Model model) {
		model.addAttribute("settFb", settFb);
		return "modules/settlementfront/settFbForm";
	}

	@RequiresPermissions("settlementfront:settFb:edit")
	@RequestMapping(value = "save")
	public String save(SettFb settFb, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, settFb)){
			return form(settFb, model);
		}
		settFbService.save(settFb);
		addMessage(redirectAttributes, "保存记录成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/settFb/?repage";
	}
	
	@RequiresPermissions("settlementfront:settFb:edit")
	@RequestMapping(value = "delete")
	public String delete(SettFb settFb, RedirectAttributes redirectAttributes) {
		settFbService.delete(settFb);
		addMessage(redirectAttributes, "删除记录成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/settFb/?repage";
	}

}