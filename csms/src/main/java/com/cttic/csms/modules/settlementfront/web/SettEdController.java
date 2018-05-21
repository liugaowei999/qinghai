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
import com.cttic.csms.modules.settlementfront.entity.SettEd;
import com.cttic.csms.modules.settlementfront.service.BpsSysOrgInfoService;
import com.cttic.csms.modules.settlementfront.service.SettEdService;

/**
 * ED差错处理文件Controller
 * @author wanglk
 * @version 2016-12-15
 */
@Controller
@RequestMapping(value = "${adminPath}/settlementfront/settEd")
public class SettEdController extends BaseController {

	@Autowired
	private SettEdService settEdService;
	@Autowired
	private OfficeService officeService;
	@Autowired
	private BpsSysOrgInfoService bpsSysOrgInfoService;
	@ModelAttribute
	public SettEd get(@RequestParam(required=false) String id,String settDate ) {
		SettEd entity = null;
		if (StringUtils.isNotBlank(id)){
			/*
			if(StringUtils.isEmpty(settDate)){
				settDate=settEdService.get(id).getSettDate();
			}*/
			SettEd settEd=new SettEd(id);
			settEd.setSettDate(settDate);
			entity = settEdService.get(settEd);
			
			//取机构名称
			Office recv=officeService.get(entity.getSendOrgCode());
			if(recv!=null){
				entity.setSendOrg(recv);
			}
			recv=officeService.get(entity.getErrOriOrgCode());
			if(recv!=null){
				entity.setErrOriOrg(recv);
			}
			recv=officeService.get(entity.getIssueOrgCode());
			if(recv!=null){
				entity.setIssueOrg(recv);
			}

		}
		if (entity == null){
			entity = new SettEd();
		}
		return entity;
	}
	
	@RequiresPermissions("settlementfront:settEd:view")
	@RequestMapping(value = {"list", ""})
	public String list(SettEd settEd, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isEmpty(settEd.getSettDate())){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			settEd.setSettDate(sdf.format(new Date()));
		}
		Page<SettEd> page = settEdService.findPage(new Page<SettEd>(request, response), settEd); 
		
		//取机构名称
		List<SettEd> list = page.getList();
		for (SettEd entity : list){
			//取机构名称
			Office recv=officeService.get(entity.getSendOrgCode());
			if(recv!=null){
				entity.setSendOrg(recv);
			}
			recv=officeService.get(entity.getErrOriOrgCode());
			if(recv!=null){
				entity.setErrOriOrg(recv);
			}
			recv=officeService.get(entity.getIssueOrgCode());
			if(recv!=null){
				entity.setIssueOrg(recv);
			}

		}
		Map<String,String> orgInfoDropDownMap = bpsSysOrgInfoService.getOrgInfoDropDownMap();
		model.addAttribute("orgInfoDropDownMap",orgInfoDropDownMap);
		model.addAttribute("page", page);
		return "modules/settlementfront/settEdList";
	}

	@RequiresPermissions("settlementfront:settEd:view")
	@RequestMapping(value = "form")
	public String form(SettEd settEd, Model model) {
		model.addAttribute("settEd", settEd);
		return "modules/settlementfront/settEdForm";
	}

	@RequiresPermissions("settlementfront:settEd:edit")
	@RequestMapping(value = "save")
	public String save(SettEd settEd, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, settEd)){
			return form(settEd, model);
		}
		settEdService.save(settEd);
		addMessage(redirectAttributes, "保存记录成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/settEd/?repage";
	}
	
	@RequiresPermissions("settlementfront:settEd:edit")
	@RequestMapping(value = "delete")
	public String delete(SettEd settEd, RedirectAttributes redirectAttributes) {
		settEdService.delete(settEd);
		addMessage(redirectAttributes, "删除记录成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/settEd/?repage";
	}

}