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
import com.cttic.sysframe.timetask.entity.SysTimetaskLog;
import com.cttic.sysframe.timetask.service.SysTimetaskLogService;

/**
 * 定时任务日志管理Controller
 * @author dener
 * @version 2016-12-06
 */
@Controller
@RequestMapping(value = "${adminPath}/timetask/sysTimetaskLog")
public class SysTimetaskLogController extends BaseController {

	@Autowired
	private SysTimetaskLogService sysTimetaskLogService;
	
	@ModelAttribute
	public SysTimetaskLog get(@RequestParam(required=false) String id) {
		SysTimetaskLog entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sysTimetaskLogService.get(id);
		}
		if (entity == null){
			entity = new SysTimetaskLog();
		}
		return entity;
	}
	
	@RequiresPermissions("timetask:sysTimetaskLog:view")
	@RequestMapping(value = {"list", ""})
	public String list(SysTimetaskLog sysTimetaskLog, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SysTimetaskLog> page = sysTimetaskLogService.findPage(new Page<SysTimetaskLog>(request, response), sysTimetaskLog); 
		model.addAttribute("page", page);
		return "sysframe/timetask/sysTimetaskLogList";
	}

	@RequiresPermissions("timetask:sysTimetaskLog:view")
	@RequestMapping(value = "form")
	public String form(SysTimetaskLog sysTimetaskLog, Model model) {
		model.addAttribute("sysTimetaskLog", sysTimetaskLog);
		return "sysframe/timetask/sysTimetaskLogForm";
	}

	@RequiresPermissions("timetask:sysTimetaskLog:edit")
	@RequestMapping(value = "save")
	public String save(SysTimetaskLog sysTimetaskLog, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysTimetaskLog)){
			return form(sysTimetaskLog, model);
		}
		sysTimetaskLogService.save(sysTimetaskLog);
		addMessage(redirectAttributes, "保存定时任务日志成功");
		return "redirect:"+Global.getAdminPath()+"/timetask/sysTimetaskLog/?repage";
	}
	
	@RequiresPermissions("timetask:sysTimetaskLog:edit")
	@RequestMapping(value = "delete")
	public String delete(SysTimetaskLog sysTimetaskLog, RedirectAttributes redirectAttributes) {
		sysTimetaskLogService.delete(sysTimetaskLog);
		addMessage(redirectAttributes, "删除定时任务日志成功");
		return "redirect:"+Global.getAdminPath()+"/timetask/sysTimetaskLog/?repage";
	}

}