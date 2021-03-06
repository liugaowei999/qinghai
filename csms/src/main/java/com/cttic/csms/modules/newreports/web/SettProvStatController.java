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

import com.cttic.csms.modules.newreports.entity.SettProvStat;
import com.cttic.csms.modules.newreports.service.SettProvStatService;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;

/**
 * 跨省月结算报表Controller
 * @author aryo
 * @version 2017-03-07
 */
@Controller
@RequestMapping(value = "${adminPath}/newreports/settProvStat")
public class SettProvStatController extends BaseController {

	@Autowired
	private SettProvStatService settProvStatService;

	@ModelAttribute
	public SettProvStat get(@RequestParam(required = false) String id) {
		SettProvStat entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = settProvStatService.get(id);
		}
		if (entity == null) {
			entity = new SettProvStat();
		}
		return entity;
	}

	@RequiresPermissions("newreports:settProvStat:view")
	@RequestMapping(value = { "list", "" })
	public String list(SettProvStat settProvStat, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		if (StringUtils.isEmpty(settProvStat.getSettCycle())) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			settProvStat.setSettCycle(sdf.format(calendar.getTime()));
		}
		Page<SettProvStat> page = settProvStatService.findPage(new Page<SettProvStat>(request, response), settProvStat);
		List<SettProvStat> allList = settProvStatService.findAllList();
		List<String> settObjectList = new ArrayList<String>();
		for (SettProvStat ss : allList) {
			if (!StringUtils.isEmpty(ss.getSettObject()) && (!settObjectList.contains(ss.getSettObject()))) {
				settObjectList.add(ss.getSettObject().trim());
			}

		}

		model.addAttribute("page", page);
		model.addAttribute("settObjectList", settObjectList);
		return "modules/newreports/settProvStatList";
	}

	@RequestMapping(value = { "settProvStatList" })
	public String settProvStatList(SettProvStat settProvStat, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		if (StringUtils.isEmpty(settProvStat.getSettCycle())) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			settProvStat.setSettCycle(sdf.format(calendar.getTime()));
		}
		Page<SettProvStat> page = settProvStatService.findPage(new Page<SettProvStat>(request, response), settProvStat);
		List<SettProvStat> allList = settProvStatService.findList(settProvStat);
		List<String> settObjectList = new ArrayList<String>();
		for (SettProvStat ss : allList) {
			if (!StringUtils.isEmpty(ss.getSettObject()) && (!settObjectList.contains(ss.getSettObject()))) {
				settObjectList.add(ss.getSettObject().trim());
			}

		}

		model.addAttribute("page", page);
		model.addAttribute("settObjectList", settObjectList);
		return "modules/newreports/settProvStatList";
	}

	/**
	 * 导出报表
	 * @param settProvStat
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("newreports:settProvStat:view")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(SettProvStat settProvStat, HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes redirectAttributes) {
		try {
			String fileName;
			if (StringUtils.isEmpty(settProvStat.getSettCycle())) {
				fileName = "跨省汇总结算报表.xlsx";
			} else {
				fileName = "跨省汇总结算报表" + "(" + settProvStat.getSettCycle() + ").xlsx";
			}

			Page<SettProvStat> page = settProvStatService.findPage(new Page<SettProvStat>(request, response),
					settProvStat);

			new ExportExcel("跨省汇总结算报表", SettProvStat.class).setDataList(page.getList()).write(response, fileName)
					.dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/newreports/settProvStat/?repage";
	}

	@RequiresPermissions("newreports:settProvStat:view")
	@RequestMapping(value = "form")
	public String form(SettProvStat settProvStat, Model model) {
		model.addAttribute("settProvStat", settProvStat);
		return "modules/newreports/settProvStatForm";
	}

	@RequiresPermissions("newreports:settProvStat:view")
	@RequestMapping(value = "settProvStatChart")
	public String settProvStatChart(SettProvStat settProvStat, Model model) {
		//List<HashMap<String, String>> orgCodeList = settProvStatService.findOrgCodeList(settProvStat);
		model.addAttribute("settProvStat", settProvStat);
		//model.addAttribute("orgCodeList", orgCodeList);
		return "modules/newreports/settProvStatChart";
	}

	@RequestMapping(value = "provStatSumViewChart")
	@ResponseBody
	public List<SettProvStat> provStatSumViewChart(SettProvStat settProvStat, String settCycle) {
		settProvStat.setSettCycle(settCycle);
		List<SettProvStat> provStatSumViewChartList = settProvStatService.provStatSumViewChart(settProvStat);
		return provStatSumViewChartList;
	}

	@RequestMapping(value = "allYearLineChart")
	@ResponseBody
	public List<SettProvStat> allYearLineChart(SettProvStat settProvStat, String settCycle) {
		settProvStat.setSettCycle(settCycle);
		List<SettProvStat> allYearLineChartList = settProvStatService.allYearLineChart(settProvStat);
		return allYearLineChartList;
	}

	@RequiresPermissions("newreports:settProvStat:edit")
	@RequestMapping(value = "save")
	public String save(SettProvStat settProvStat, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, settProvStat)) {
			return form(settProvStat, model);
		}
		settProvStatService.save(settProvStat);
		addMessage(redirectAttributes, "保存跨省月结算报表成功");
		return "redirect:" + Global.getAdminPath() + "/newreports/settProvStat/?repage";
	}

	@RequiresPermissions("newreports:settProvStat:edit")
	@RequestMapping(value = "delete")
	public String delete(SettProvStat settProvStat, RedirectAttributes redirectAttributes) {
		settProvStatService.delete(settProvStat);
		addMessage(redirectAttributes, "删除跨省月结算报表成功");
		return "redirect:" + Global.getAdminPath() + "/newreports/settProvStat/?repage";
	}

}