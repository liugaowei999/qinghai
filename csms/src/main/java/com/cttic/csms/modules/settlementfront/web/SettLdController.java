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
import com.cttic.csms.modules.settlementfront.entity.SettLd;
import com.cttic.csms.modules.settlementfront.service.BpsSysOrgInfoService;
import com.cttic.csms.modules.settlementfront.service.SettLdService;

/**
 * LD消费已处理文件清单Controller
 * @author wanglk
 * @version 2016-12-05
 */
@Controller
@RequestMapping(value = "${adminPath}/settlementfront/settLd")
public class SettLdController extends BaseController {

	@Autowired
	private SettLdService settLdService;
	
	@Autowired
	private OfficeService officeService;
	
	@Autowired
	private BpsSysOrgInfoService bpsSysOrgInfoService;
	
	@ModelAttribute
	public SettLd get(@RequestParam(required=false) String id,String settDate) {
		SettLd entity = null;
		if (StringUtils.isNotBlank(id)){
			SettLd settLd=new SettLd(id);
			settLd.setSettDate(settDate);
			entity = settLdService.get(settLd);
		}
		if (entity == null){
			entity = new SettLd();
		}
		return entity;
	}
	
	@RequiresPermissions("settlementfront:settLd:view")
	@RequestMapping(value = {"list", ""})
	public String list(SettLd settLd, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isEmpty(settLd.getSettDate())){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			settLd.setSettDate(sdf.format(new Date()));
		}
		
		Page<SettLd> page = settLdService.findPage(new Page<SettLd>(request, response), settLd); 
		
		//取机构名称
		List<SettLd> list = page.getList();
		for (SettLd entity : list){
			//取机构名称
			Office recv=officeService.get(entity.getRecvOrgCode());
			if(recv!=null){
				entity.setRecvOrgCode(recv.getName());
			}
		}
		Map<String,String> orgInfoDropDownMap = bpsSysOrgInfoService.getOrgInfoDropDownMap();
		model.addAttribute("orgInfoDropDownMap",orgInfoDropDownMap);
		model.addAttribute("page", page);
		return "modules/settlementfront/settLdList";
	}

	@RequiresPermissions("settlementfront:settLd:view")
	@RequestMapping(value = "form")
	public String form(SettLd settLd, Model model) {
		model.addAttribute("settLd", settLd);
		return "modules/settlementfront/settLdForm";
	}

	@RequiresPermissions("settlementfront:settLd:edit")
	@RequestMapping(value = "save")
	public String save(SettLd settLd, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, settLd)){
			return form(settLd, model);
		}
		settLdService.save(settLd);
		addMessage(redirectAttributes, "保存记录成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/settLd/?repage";
	}
	
	@RequiresPermissions("settlementfront:settLd:edit")
	@RequestMapping(value = "delete")
	public String delete(SettLd settLd, RedirectAttributes redirectAttributes) {
		settLdService.delete(settLd);
		addMessage(redirectAttributes, "删除记录成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/settLd/?repage";
	}

}