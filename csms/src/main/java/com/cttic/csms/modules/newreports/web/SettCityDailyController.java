/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.newreports.web;

import java.io.UnsupportedEncodingException;
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

import com.cttic.csms.modules.newreports.entity.SettCityDaily;
import com.cttic.csms.modules.newreports.service.SettCityDailyService;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;

/**
 * 省内日统计报表Controller
 * @author aryo
 * @version 2017-03-07
 */
@Controller
@RequestMapping(value = "${adminPath}/newreports/settCityDaily")
public class SettCityDailyController extends BaseController {

	@Autowired
	private SettCityDailyService settCityDailyService;

	@ModelAttribute
	public SettCityDaily get(@RequestParam(required = false) String id) {
		SettCityDaily entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = settCityDailyService.get(id);
		}
		if (entity == null) {
			entity = new SettCityDaily();
		}
		return entity;
	}

	@RequiresPermissions("newreports:settCityDaily:view")
	@RequestMapping(value = { "list", "" })
	public String list(SettCityDaily settCityDaily, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		if (StringUtils.isEmpty(settCityDaily.getBeginSettDate())
				&& StringUtils.isEmpty(settCityDaily.getEndSettDate())) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			settCityDaily.setBeginSettDate(sdf.format(calendar.getTime()));
			calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
			settCityDaily.setEndSettDate(sdf.format(calendar.getTime()));
		}
		SettCityDaily settCityDailySum = settCityDailyService.settCityDailySum(settCityDaily);
		List<SettCityDaily> allList = settCityDailyService.findAllList(settCityDaily);
		Page<SettCityDaily> page = settCityDailyService.findPage(new Page<SettCityDaily>(request, response),
				settCityDaily);

		List<String> settObjectList = new ArrayList<String>();
		List<String> settRoleList = new ArrayList<String>();

		for (SettCityDaily ss : allList) {

			if (!StringUtils.isEmpty(ss.getSettObject()) && (!settObjectList.contains(ss.getSettObject()))) {
				settObjectList.add(ss.getSettObject().trim());
			}
			if (!StringUtils.isEmpty(ss.getSettRole()) && (!settRoleList.contains(ss.getSettRole()))) {
				settRoleList.add(ss.getSettRole().trim());
			}

		}
		//add sum
		if (settCityDailySum != null) {
			settCityDailySum.setSettDate("合计：");
			page.getList().add(settCityDailySum);
		}
		model.addAttribute("page", page);
		model.addAttribute("settObjectList", settObjectList);
		model.addAttribute("settRoleList", settRoleList);
		return "modules/newreports/settCityDailyList";
	}

	@RequestMapping(value = { "settCityDailyList" })
	public String settCityDailyList(SettCityDaily settCityDaily, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		if (StringUtils.isEmpty(settCityDaily.getBeginSettDate())
				&& StringUtils.isEmpty(settCityDaily.getEndSettDate())) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			settCityDaily.setBeginSettDate(sdf.format(calendar.getTime()));
			calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
			settCityDaily.setEndSettDate(sdf.format(calendar.getTime()));
		}

        SettCityDaily settCityDailySum = settCityDailyService.settCityDailySum(settCityDaily);
        //List allList = settCityDailyService.findAllList(settCityDaily);
        //Page page = settCityDailyService.findPage(new Page(request, response), settCityDaily);

		Page<SettCityDaily> page = settCityDailyService.findPage(new Page<SettCityDaily>(request, response), 	settCityDaily);
        List<SettCityDaily> allList = settCityDailyService.findAllList(settCityDaily);
        List<String> settObjectList = new ArrayList<String>();
        List<String> settRoleList = new ArrayList<String>();

        for (SettCityDaily ss : allList) {
            if (!StringUtils.isEmpty(ss.getSettObject()) && (!settObjectList.contains(ss.getSettObject()))) {
                settObjectList.add(ss.getSettObject().trim());
            }
            if (!StringUtils.isEmpty(ss.getSettRole()) && (!settRoleList.contains(ss.getSettRole()))) {
                settRoleList.add(ss.getSettRole().trim());
            }
        }

        if (settCityDailySum != null) {
            settCityDailySum.setSettDate("合计：");
            page.getList().add(settCityDailySum);
        }

		model.addAttribute("page", page);
		model.addAttribute("settObjectList", settObjectList);
		model.addAttribute("settRoleList", settRoleList);
		return "modules/newreports/settCityDailyList";
	}

	/**
	 * 导出报表
	 * @param settCityDaily
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("newreports:settCityDaily:view")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(SettCityDaily settCityDaily, HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes redirectAttributes) {
		try {
			String fileName;
			if (StringUtils.isEmpty(settCityDaily.getBeginSettDate())
					|| StringUtils.isEmpty(settCityDaily.getEndSettDate())) {
				fileName = "省内日结算报表.xlsx";
			} else {
				fileName = "省内日结算报表" + "(" + settCityDaily.getBeginSettDate() + "-" + settCityDaily.getEndSettDate()
						+ ").xlsx";
			}
			//add sum export all
			//Page<SettCityDaily> page = settCityDailyService.findPage(new Page<SettCityDaily>(request, response), settCityDaily);
			List<SettCityDaily> displayList = settCityDailyService.findList(settCityDaily);
			SettCityDaily settCityDailySum = settCityDailyService.settCityDailySum(settCityDaily);
			if (settCityDailySum != null) {
				settCityDailySum.setSettDate("合计：");
			}
			displayList.add(settCityDailySum);
			new ExportExcel("省内日结算报表", SettCityDaily.class).setDataList(displayList).write(response, fileName)
					.dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/newreports/settCityDaily/?repage";
	}

	@RequestMapping(value = { "settCityDailyChart" })
	public String settCityDailyChart(SettCityDaily settCityDaily, Model model) {
		List<SettCityDaily> allList = settCityDailyService.findAllList(settCityDaily);
		List<String> settObjectList = new ArrayList<String>();
		for (SettCityDaily ss : allList) {

			if (!StringUtils.isEmpty(ss.getSettObject()) && (!settObjectList.contains(ss.getSettObject()))) {
				settObjectList.add(ss.getSettObject().trim());
			}
		}
		model.addAttribute("settObjectList", settObjectList);
		model.addAttribute("settCityDaily", settCityDaily);
		return "modules/newreports/settCityDailyChart";
	}

	@RequestMapping(value = "issueCityViewChart")
	@ResponseBody
	public List<SettCityDaily> issueCityViewChart(SettCityDaily settCityDaily, String settDate, String settObject)
			throws UnsupportedEncodingException {
		settCityDaily.setSettDate(settDate);
		String settobject = java.net.URLDecoder.decode(settObject, "utf-8");
		settCityDaily.setSettObject(settobject);
		List<SettCityDaily> issueCityViewChartList = settCityDailyService.issueCityViewChart(settCityDaily);
		return issueCityViewChartList;
	}

	@RequestMapping(value = "billCityViewChart")
	@ResponseBody
	public List<SettCityDaily> billCityViewChart(SettCityDaily settCityDaily, String settDate, String settObject)
			throws UnsupportedEncodingException {
		settCityDaily.setSettDate(settDate);
		String settobject = java.net.URLDecoder.decode(settObject, "utf-8");
		settCityDaily.setSettObject(settobject);
		List<SettCityDaily> billCityViewChartList = settCityDailyService.billCityViewChart(settCityDaily);
		return billCityViewChartList;
	}

	@RequestMapping(value = "issueCodeProvLineChart")
	@ResponseBody
	public List<SettCityDaily> issueCodeProvLineChart(SettCityDaily settCityDaily, String settDate, String settObject)
			throws UnsupportedEncodingException {
		settCityDaily.setSettDate(settDate);
		String settobject = java.net.URLDecoder.decode(settObject, "utf-8");
		settCityDaily.setSettObject(settobject);
		List<SettCityDaily> issueObjectMonthLineChartList = settCityDailyService
				.issueObjectMonthLineChart(settCityDaily);
		return issueObjectMonthLineChartList;
	}

	@RequestMapping(value = "billCodeProvLineChart")
	@ResponseBody
	public List<SettCityDaily> billCodeProvLineChart(SettCityDaily settCityDaily, String settDate, String settObject)
			throws UnsupportedEncodingException {
		settCityDaily.setSettDate(settDate);
		String settobject = java.net.URLDecoder.decode(settObject, "utf-8");
		settCityDaily.setSettObject(settobject);
		List<SettCityDaily> issueObjectMonthLineChartList = settCityDailyService.billCodeProvLineChart(settCityDaily);
		return issueObjectMonthLineChartList;
	}

	@RequiresPermissions("newreports:settCityDaily:view")
	@RequestMapping(value = "form")
	public String form(SettCityDaily settCityDaily, Model model) {
		model.addAttribute("settCityDaily", settCityDaily);
		return "modules/newreports/settCityDailyForm";
	}

	@RequiresPermissions("newreports:settCityDaily:edit")
	@RequestMapping(value = "save")
	public String save(SettCityDaily settCityDaily, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, settCityDaily)) {
			return form(settCityDaily, model);
		}
		settCityDailyService.save(settCityDaily);
		addMessage(redirectAttributes, "保存省内日统计报表成功");
		return "redirect:" + Global.getAdminPath() + "/newreports/settCityDaily/?repage";
	}

	@RequiresPermissions("newreports:settCityDaily:edit")
	@RequestMapping(value = "delete")
	public String delete(SettCityDaily settCityDaily, RedirectAttributes redirectAttributes) {
		settCityDailyService.delete(settCityDaily);
		addMessage(redirectAttributes, "删除省内日统计报表成功");
		return "redirect:" + Global.getAdminPath() + "/newreports/settCityDaily/?repage";
	}


	@RequiresPermissions({"newreports:settCityDaily:view"})
	@RequestMapping(value={"exportmonth"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	public String exportMonthlyFile(SettCityDaily settCityDaily, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes)
	{
		try
		{
			String fileName;
			if ((StringUtils.isEmpty(settCityDaily.getBeginSettDate())) ||
					(StringUtils.isEmpty(settCityDaily.getEndSettDate())))
				fileName = "省内月结算报表.xlsx";
			else {
				fileName = "省内月结算报表(" + settCityDaily.getBeginSettDate() + "-" + settCityDaily.getEndSettDate() +
						").xlsx";
			}

			List displayList = this.settCityDailyService.findMonthList(settCityDaily);
			SettCityDaily settCityDailySum = this.settCityDailyService.settCityMonthlySum(settCityDaily);
			if (settCityDailySum != null)
				settCityDailySum.setSettDate("合计：");

			displayList.add(settCityDailySum);
			new ExportExcel("省内月结算报表", SettCityDaily.class).setDataList(displayList).write(response, fileName)
					.dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, new String[] { "导出用户失败！失败信息：" + e.getMessage() });
		}
		return "redirect:" + Global.getAdminPath() + "/newreports/settCityStat/?repage";
	}

}