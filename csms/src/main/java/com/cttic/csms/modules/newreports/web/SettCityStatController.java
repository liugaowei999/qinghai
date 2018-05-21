/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.newreports.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cttic.csms.modules.newreports.entity.SettCityStat;
import com.cttic.csms.modules.newreports.service.SettCityStatService;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 月结算报表Controller
 * @author aryo
 * @version 2017-03-07
 */
@Controller
@RequestMapping(value = "${adminPath}/newreports/settCityStat")
public class SettCityStatController extends BaseController {

	@Autowired
	private SettCityStatService settCityStatService;

	@ModelAttribute
	public SettCityStat get(@RequestParam(required = false) String id) {
		SettCityStat entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = settCityStatService.get(id);
		}
		if (entity == null) {
			entity = new SettCityStat();
		}
		return entity;
	}

	@RequiresPermissions("newreports:settCityStat:view")
	@RequestMapping(value = { "list", "" })
	public String list(SettCityStat settCityStat, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		if (StringUtils.isEmpty(settCityStat.getSettCycle())) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			settCityStat.setSettCycle(sdf.format(calendar.getTime()));
		}
		Page<SettCityStat> page = settCityStatService.findPage(new Page<SettCityStat>(request, response), settCityStat);
		List<SettCityStat> allList = settCityStatService.findAllList();
		List<String> settObjectList = new ArrayList<String>();
		for (SettCityStat ss : allList) {

			if (!StringUtils.isEmpty(ss.getSettObject()) && (!settObjectList.contains(ss.getSettObject()))) {
				settObjectList.add(ss.getSettObject().trim());
			}

		}

		User user = settCityStat.getCurrentUser();
		String dataScope = "";
		for (Role role : user.getRoleList()) {
			dataScope = role.getDataScope();
		}
		model.addAttribute("dataScope", dataScope);
		model.addAttribute("page", page);
		model.addAttribute("settObjectList", settObjectList);
		return "modules/newreports/settCityStatList";
	}

	@RequestMapping(value = { "settCityStatList" })
	public String settCityStatList(SettCityStat settCityStat, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		if (StringUtils.isEmpty(settCityStat.getSettCycle())) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			settCityStat.setSettCycle(sdf.format(calendar.getTime()));
		}
		Page<SettCityStat> page = settCityStatService.findPage(new Page<SettCityStat>(request, response), settCityStat);
		List<SettCityStat> allList = settCityStatService.findList(settCityStat);
		List<String> settObjectList = new ArrayList<String>();
		for (SettCityStat ss : allList) {

			if (!StringUtils.isEmpty(ss.getSettObject()) && (!settObjectList.contains(ss.getSettObject()))) {
				settObjectList.add(ss.getSettObject().trim());
			}

		}

		User user = settCityStat.getCurrentUser();
		String dataScope = "";
		for (Role role : user.getRoleList()) {
			dataScope = role.getDataScope();
		}
		model.addAttribute("dataScope", dataScope);
		model.addAttribute("page", page);
		model.addAttribute("settObjectList", settObjectList);
		return "modules/newreports/settCityStatList";
	}

	/**
	 * 导出报表
	 * @param settCityStat
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("newreports:settCityStat:view")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(SettCityStat settCityStat, HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes redirectAttributes) {
		try {
			String fileName;
			if (StringUtils.isEmpty(settCityStat.getSettCycle())) {
				fileName = "省内汇总结算报表.xlsx";
			} else {
				fileName = "省内汇总结算报表" + "(" + settCityStat.getSettCycle() + ").xlsx";
			}

			Page<SettCityStat> page = settCityStatService.findPage(new Page<SettCityStat>(request, response),
					settCityStat);

			new ExportExcel("省内汇总结算报表", SettCityStat.class).setDataList(page.getList()).write(response, fileName)
					.dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/newreports/settCityStat/?repage";
	}

	@RequestMapping(value = { "settCityStatChart" })
	public String settCityStatChart(SettCityStat settCityStat, Model model) {
		model.addAttribute("settCityStat", settCityStat);
		return "modules/newreports/settCityStatChart";
	}

	@RequestMapping(value = "cityCodeCityViewChart")
	@ResponseBody
	public List<SettCityStat> cityCodeCityViewChart(SettCityStat settCityStat, String settCycle) {
		settCityStat.setSettCycle(settCycle);
		List<SettCityStat> settCityStatList = settCityStatService.cityCodeCityViewChart(settCityStat);
		return settCityStatList;
	}

	@RequiresPermissions("newreports:settCityStat:view")
	@RequestMapping(value = "form")
	public String form(SettCityStat settCityStat, Model model) {
		model.addAttribute("settCityStat", settCityStat);
		return "modules/newreports/settCityStatForm";
	}

	@RequiresPermissions("newreports:settCityStat:edit")
	@RequestMapping(value = "save")
	public String save(SettCityStat settCityStat, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, settCityStat)) {
			return form(settCityStat, model);
		}
		settCityStatService.save(settCityStat);
		addMessage(redirectAttributes, "保存月结算报表成功");
		return "redirect:" + Global.getAdminPath() + "/newreports/settCityStat/?repage";
	}

	@RequiresPermissions("newreports:settCityStat:edit")
	@RequestMapping(value = "delete")
	public String delete(SettCityStat settCityStat, RedirectAttributes redirectAttributes) {
		settCityStatService.delete(settCityStat);
		addMessage(redirectAttributes, "删除月结算报表成功");
		return "redirect:" + Global.getAdminPath() + "/newreports/settCityStat/?repage";
	}

}