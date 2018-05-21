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

import com.cttic.csms.modules.newreports.entity.SettProvDaily;
import com.cttic.csms.modules.newreports.service.SettProvDailyService;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;

/**
 * 跨省日统计报表Controller
 * @author aryo
 * @version 2017-03-07
 */
@Controller
@RequestMapping(value = "${adminPath}/newreports/settProvDaily")
public class SettProvDailyController extends BaseController {

	@Autowired
	private SettProvDailyService settProvDailyService;

	@ModelAttribute
	public SettProvDaily get(@RequestParam(required = false) String id) {
		SettProvDaily entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = settProvDailyService.get(id);
		}
		if (entity == null) {
			entity = new SettProvDaily();
		}
		return entity;
	}

	@RequiresPermissions("newreports:settProvDaily:view")
	@RequestMapping(value = { "list", "" })
	public String list(SettProvDaily settProvDaily, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		if (StringUtils.isEmpty(settProvDaily.getBeginSettDate())
				&& StringUtils.isEmpty(settProvDaily.getEndSettDate())) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			settProvDaily.setBeginSettDate(sdf.format(calendar.getTime()));
			calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
			settProvDaily.setEndSettDate(sdf.format(calendar.getTime()));
		}
		//add sum 2017/10/10
		SettProvDaily settProvDailySum = settProvDailyService.settProvDetailSum(settProvDaily);

		Page<SettProvDaily> page = settProvDailyService.findPage(new Page<SettProvDaily>(request, response),
				settProvDaily);
		List<SettProvDaily> allList = settProvDailyService.findAllList();
		List<String> settObjectList = new ArrayList<String>();
		List<String> settRoleList = new ArrayList<String>();
		for (SettProvDaily ss : allList) {

			if (!StringUtils.isEmpty(ss.getSettObject()) && (!settObjectList.contains(ss.getSettObject()))) {
				settObjectList.add(ss.getSettObject().trim());
			}
			if (!StringUtils.isEmpty(ss.getSettRole()) && (!settRoleList.contains(ss.getSettRole()))) {
				settRoleList.add(ss.getSettRole().trim());
			}

		}
		//add sum 2017/10/10
		if (settProvDailySum != null) {
			settProvDailySum.setSettDate("合计：");
			//是在每行加上合计？
			page.getList().add(settProvDailySum);
		}
		model.addAttribute("page", page);
		model.addAttribute("settObjectList", settObjectList);
		model.addAttribute("settRoleList", settRoleList);
		return "modules/newreports/settProvDailyList";
	}

	@RequestMapping(value = { "settProvDailyList" })
	public String settProvDailyList(SettProvDaily settProvDaily, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		if (StringUtils.isEmpty(settProvDaily.getBeginSettDate())
				&& StringUtils.isEmpty(settProvDaily.getEndSettDate())) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			settProvDaily.setBeginSettDate(sdf.format(calendar.getTime()));
			calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
			settProvDaily.setEndSettDate(sdf.format(calendar.getTime()));
		}
		Page<SettProvDaily> page = settProvDailyService.findPage(new Page<SettProvDaily>(request, response),
				settProvDaily);
		List<SettProvDaily> allList = settProvDailyService.findAllList();
		List<String> settObjectList = new ArrayList<String>();
		List<String> settRoleList = new ArrayList<String>();
		for (SettProvDaily ss : allList) {

			if (!StringUtils.isEmpty(ss.getSettObject()) && (!settObjectList.contains(ss.getSettObject()))) {
				settObjectList.add(ss.getSettObject().trim());
			}
			if (!StringUtils.isEmpty(ss.getSettRole()) && (!settRoleList.contains(ss.getSettRole()))) {
				settRoleList.add(ss.getSettRole().trim());
			}

		}
		model.addAttribute("page", page);
		model.addAttribute("settObjectList", settObjectList);
		model.addAttribute("settRoleList", settRoleList);
		return "modules/newreports/settProvDailyList";
	}

	/**
	 * 导出报表
	 * @param settProvDaily
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("newreports:settProvDaily:view")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(SettProvDaily settProvDaily, HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes redirectAttributes) {
		try {
			String fileName;
			if (StringUtils.isEmpty(settProvDaily.getBeginSettDate())
					|| StringUtils.isEmpty(settProvDaily.getEndSettDate())) {
				fileName = "跨省日结算报表.xlsx";
			} else {
				fileName = "跨省日结算报表" + "(" + settProvDaily.getBeginSettDate() + "-" + settProvDaily.getEndSettDate()
						+ ").xlsx";
			}
			//add sum export all 2017/10/10
			//Page<SettProvDaily> page = settProvDailyService.findPage(new Page<SettProvDaily>(request, response), settProvDaily);
			List<SettProvDaily> displayList = settProvDailyService.findList(settProvDaily);
			SettProvDaily settProvDailySum = settProvDailyService.settProvDetailSum(settProvDaily);
			if (settProvDailySum != null)
				settProvDailySum.setSettDate("合计：");
			displayList.add(settProvDailySum);
			new ExportExcel("跨省日结算报表", SettProvDaily.class).setDataList(displayList).write(response, fileName)
					.dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/newreports/settProvDaily/?repage";
	}

	@RequestMapping(value = { "settProvDailyChart" })
	public String settProvDailyChart(SettProvDaily settProvDaily, Model model) {
		model.addAttribute("settProvDaily", settProvDaily);
		return "modules/newreports/settProvDailyChart";
	}

	@RequestMapping(value = "billCodeSumProvViewChart")
	@ResponseBody
	public List<SettProvDaily> billCodeSumProvViewChart(SettProvDaily settProvDaily, String settDate) {
		settProvDaily.setSettDate(settDate);
		List<SettProvDaily> billCodeSumProvViewChartList = settProvDailyService.billCodeSumProvViewChart(settProvDaily);
		return billCodeSumProvViewChartList;
	}

	@RequestMapping(value = "issueCodeProvViewChart")
	@ResponseBody
	public List<SettProvDaily> issueCodeProvViewChart(SettProvDaily settProvDaily, String settDate) {
		settProvDaily.setSettDate(settDate);
		List<SettProvDaily> issueCodeProvViewChartList = settProvDailyService.billCodeSumProvViewChart(settProvDaily);
		return issueCodeProvViewChartList;
	}

	@RequiresPermissions("newreports:settProvDaily:view")
	@RequestMapping(value = "form")
	public String form(SettProvDaily settProvDaily, Model model) {
		model.addAttribute("settProvDaily", settProvDaily);
		return "modules/newreports/settProvDailyForm";
	}

	@RequiresPermissions("newreports:settProvDaily:edit")
	@RequestMapping(value = "save")
	public String save(SettProvDaily settProvDaily, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, settProvDaily)) {
			return form(settProvDaily, model);
		}
		settProvDailyService.save(settProvDaily);
		addMessage(redirectAttributes, "保存跨省日统计报表成功");
		return "redirect:" + Global.getAdminPath() + "/newreports/settProvDaily/?repage";
	}

	@RequiresPermissions("newreports:settProvDaily:edit")
	@RequestMapping(value = "delete")
	public String delete(SettProvDaily settProvDaily, RedirectAttributes redirectAttributes) {
		settProvDailyService.delete(settProvDaily);
		addMessage(redirectAttributes, "删除跨省日统计报表成功");
		return "redirect:" + Global.getAdminPath() + "/newreports/settProvDaily/?repage";
	}

}