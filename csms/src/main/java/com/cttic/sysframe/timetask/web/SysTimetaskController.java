/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.sysframe.timetask.web;

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
import com.cttic.sysframe.timetask.entity.SysTimetask;
import com.cttic.sysframe.timetask.service.SysTimetaskService;

/**
 * 定时任务管理功能Controller
 * @author dener
 * @version 2016-12-06
 */
@Controller
@RequestMapping(value = "${adminPath}/timetask/sysTimetask")
public class SysTimetaskController extends BaseController {

	@Autowired
	private SysTimetaskService sysTimetaskService;
	
	@ModelAttribute
	public SysTimetask get(@RequestParam(required=false) String id) {
		SysTimetask entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sysTimetaskService.get(id);
		}
		if (entity == null){
			entity = new SysTimetask();
		}
		return entity;
	}
	
	@RequiresPermissions("timetask:sysTimetask:view")
	@RequestMapping(value = {"list", ""})
	public String list(SysTimetask sysTimetask, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SysTimetask> page = sysTimetaskService.findPage(new Page<SysTimetask>(request, response), sysTimetask); 
		model.addAttribute("page", page);
		return "sysframe/timetask/sysTimetaskList";
	}

	@RequiresPermissions("timetask:sysTimetask:view")
	@RequestMapping(value = "form")
	public String form(SysTimetask sysTimetask, Model model) {
		model.addAttribute("sysTimetask", sysTimetask);
		return "sysframe/timetask/sysTimetaskForm";
	}

	@RequiresPermissions("timetask:sysTimetask:edit")
	@RequestMapping(value = "save")
	public String save(SysTimetask sysTimetask, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysTimetask)){
			return form(sysTimetask, model);
		}
		sysTimetaskService.save(sysTimetask);
		addMessage(redirectAttributes, "保存定时任务管理功能成功");
		return "redirect:"+Global.getAdminPath()+"/timetask/sysTimetask/?repage";
	}
	
	@RequiresPermissions("timetask:sysTimetask:edit")
	@RequestMapping(value = "delete")
	public String delete(SysTimetask sysTimetask, RedirectAttributes redirectAttributes) {
		sysTimetaskService.delete(sysTimetask);
		addMessage(redirectAttributes, "删除定时任务管理功能成功");
		return "redirect:"+Global.getAdminPath()+"/timetask/sysTimetask/?repage";
	}

}