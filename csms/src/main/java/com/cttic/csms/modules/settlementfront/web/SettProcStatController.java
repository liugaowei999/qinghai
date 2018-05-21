/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.web;

import java.util.HashMap;
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

import com.cttic.csms.modules.settlementfront.entity.SettProcStat;
import com.cttic.csms.modules.settlementfront.service.SettProcStatService;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;

/**
 * 前台出账Controller
 * @author zhouhong
 * @version 2017-05-03
 */
@Controller
@RequestMapping(value = "${adminPath}/settlementfront/settProcStat")
public class SettProcStatController extends BaseController {

	@Autowired
	private SettProcStatService settProcStatService;

	@ModelAttribute
	public SettProcStat get(@RequestParam(required = false) String module_id) {
		SettProcStat entity = null;
		if (StringUtils.isNotBlank(module_id)) {
			entity = settProcStatService.get(module_id);
		}
		if (entity == null) {
			entity = new SettProcStat();
		}
		return entity;
	}

	@RequiresPermissions("settlementfront:settProcStat:view")
	@RequestMapping(value = { "list", "" })
	public String list(SettProcStat settProcStat, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Page<SettProcStat> page = settProcStatService.findPage(new Page<SettProcStat>(request, response), settProcStat);
		model.addAttribute("page", page);
		return "modules/settlementfront/settProcStatList";
	}

	@RequiresPermissions("settlementfront:settProcStat:view")
	@RequestMapping(value = "form")
	public String form(SettProcStat settProcStat, Model model) {
		model.addAttribute("settProcStat", settProcStat);
		return "modules/settlementfront/settProcStatForm";
	}

	@RequiresPermissions("settlementfront:settProcStat:view")
	@RequestMapping(value = { "executeProc" })
	public String executeProc(SettProcStat settProcStat, HttpServletRequest req, Model model,
			RedirectAttributes redirectAttributes) {
		String month = req.getParameter("month");
		//String sqlnote = req.getParameter("note");
		//settProcStat.setNote(sqlnote);
		model.addAttribute("settProcStat", settProcStat);
		Map<String, String> paramMap = new HashMap<>();
		paramMap.put("proName", settProcStat.getBpsSysModule().getNote());
		paramMap.put("month", month);
		settProcStatService.executeProc(paramMap);
		return "redirect:" + Global.getAdminPath() + "/settlementfront/settProcStat/?repage";
	}

	@RequiresPermissions("settlementfront:settProcStat:edit")
	@RequestMapping(value = "save")
	public String save(SettProcStat settProcStat, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, settProcStat)) {
			return form(settProcStat, model);
		}
		settProcStatService.save(settProcStat);
		addMessage(redirectAttributes, "保存前台出账成功");
		return "redirect:" + Global.getAdminPath() + "/settlementfront/settProcStat/?repage";
	}

	@RequiresPermissions("settlementfront:settProcStat:edit")
	@RequestMapping(value = "delete")
	public String delete(SettProcStat settProcStat, RedirectAttributes redirectAttributes) {
		settProcStatService.delete(settProcStat);
		addMessage(redirectAttributes, "删除前台出账成功");
		return "redirect:" + Global.getAdminPath() + "/settlementfront/settProcStat/?repage";
	}

}