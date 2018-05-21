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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cttic.csms.modules.newreports.entity.SettProvDetail;
import com.cttic.csms.modules.newreports.service.SettProvDetailService;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;

/**
 * 跨省结算详单展示Controller
 * @author aryo
 * @version 2017-03-07
 */
@Controller
@RequestMapping(value = "${adminPath}/newreports/settProvDetail")
public class SettProvDetailController extends BaseController {

	@Autowired
	private SettProvDetailService settProvDetailService;

	@ModelAttribute
	public SettProvDetail get(@RequestParam(required = false) String id) {
		SettProvDetail entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = settProvDetailService.get(id);
		}
		if (entity == null) {
			entity = new SettProvDetail();
		}
		return entity;
	}

	@RequiresPermissions("newreports:settProvDetail:view")
	@RequestMapping(value = { "list", "" })
	public String list(SettProvDetail settProvDetail, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		if (StringUtils.isEmpty(settProvDetail.getBeginSettDate())
				&& StringUtils.isEmpty(settProvDetail.getEndSettDate())) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			settProvDetail.setBeginSettDate(sdf.format(calendar.getTime()));
			calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
			settProvDetail.setEndSettDate(sdf.format(calendar.getTime()));
		}
		//add sum
		SettProvDetail settProvDetailSum = settProvDetailService.getSum(settProvDetail);
		Page<SettProvDetail> page = settProvDetailService.findPage(new Page<SettProvDetail>(request, response),
				settProvDetail);
		List<SettProvDetail> allList = settProvDetailService.findAllList();
		List<String> billOrgNameList = new ArrayList<String>();
		List<String> issueOrgNameList = new ArrayList<String>();

		for (SettProvDetail ss : allList) {

			if (!StringUtils.isEmpty(ss.getBillOrgName()) && (!billOrgNameList.contains(ss.getBillOrgName()))) {
				billOrgNameList.add(ss.getBillOrgName().trim());
			}
			if (!StringUtils.isEmpty(ss.getIssueOrgName()) && (!issueOrgNameList.contains(ss.getIssueOrgName()))) {
				issueOrgNameList.add(ss.getIssueOrgName().trim());
			}

		}
		if (settProvDetailSum != null) {
			settProvDetailSum.setSettDate("合计：");
			page.getList().add(settProvDetailSum);
		}
		model.addAttribute("page", page);
		model.addAttribute("billOrgNameList", billOrgNameList);
		model.addAttribute("issueOrgNameList", issueOrgNameList);
		return "modules/newreports/settProvDetailList";
	}

	@RequestMapping(value = "settProvDetailList")
	public String settProvDetailList(SettProvDetail settProvDetail, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		if (StringUtils.isEmpty(settProvDetail.getBeginSettDate())
				&& StringUtils.isEmpty(settProvDetail.getEndSettDate())) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			settProvDetail.setBeginSettDate(sdf.format(calendar.getTime()));
			calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
			settProvDetail.setEndSettDate(sdf.format(calendar.getTime()));
		}
		Page<SettProvDetail> page = settProvDetailService.findPage(new Page<SettProvDetail>(request, response),
				settProvDetail);
		List<SettProvDetail> allList = settProvDetailService.findAllList();
		List<String> billOrgNameList = new ArrayList<String>();
		List<String> issueOrgNameList = new ArrayList<String>();
		for (SettProvDetail ss : allList) {

			if (!StringUtils.isEmpty(ss.getBillOrgName()) && (!billOrgNameList.contains(ss.getBillOrgName()))) {
				billOrgNameList.add(ss.getBillOrgName().trim());
			}
			if (!StringUtils.isEmpty(ss.getIssueOrgName()) && (!issueOrgNameList.contains(ss.getIssueOrgName()))) {
				issueOrgNameList.add(ss.getIssueOrgName().trim());
			}

		}
		model.addAttribute("page", page);
		model.addAttribute("billOrgNameList", billOrgNameList);
		model.addAttribute("issueOrgNameList", issueOrgNameList);
		return "modules/newreports/settProvDetailList";
	}

	/**
	 * 导出报表
	 * @param settProvDetail
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("newreports:settProvDetail:view")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(SettProvDetail settProvDetail, HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes redirectAttributes) {
		try {
			String fileName;
			if (StringUtils.isEmpty(settProvDetail.getBeginSettDate())
					|| StringUtils.isEmpty(settProvDetail.getEndSettDate())) {
				fileName = "跨省明细结算报表.xlsx";
			} else {
				fileName = "跨省明细结算报表" + "(" + settProvDetail.getBeginSettDate() + "-" + settProvDetail.getEndSettDate()
						+ ").xlsx";
			}
			//add sum export all 2017/10/10

			//Page<SettProvDetail> page = settProvDetailService.findPage(new Page<SettProvDetail>(request, response), settProvDetail);
			List<SettProvDetail> displayList = settProvDetailService.findList(settProvDetail);
			SettProvDetail settProvDetailSum = settProvDetailService.getSum(settProvDetail);
			if (settProvDetailSum != null)
				settProvDetailSum.setSettDate("合计：");
			displayList.add(settProvDetailSum);
			new ExportExcel("跨省明细结算报表", SettProvDetail.class).setDataList(displayList).write(response, fileName)
					.dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/newreports/settProvDetail/?repage";
	}

	@RequiresPermissions("newreports:settProvDetail:view")
	@RequestMapping(value = "form")
	public String form(SettProvDetail settProvDetail, Model model) {
		model.addAttribute("settProvDetail", settProvDetail);
		return "modules/newreports/settProvDetailForm";
	}

	@RequiresPermissions("newreports:settProvDetail:edit")
	@RequestMapping(value = "save")
	public String save(SettProvDetail settProvDetail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, settProvDetail)) {
			return form(settProvDetail, model);
		}
		settProvDetailService.save(settProvDetail);
		addMessage(redirectAttributes, "保存跨省结算详单展示成功");
		return "redirect:" + Global.getAdminPath() + "/newreports/settProvDetail/?repage";
	}

	@RequiresPermissions("newreports:settProvDetail:edit")
	@RequestMapping(value = "delete")
	public String delete(SettProvDetail settProvDetail, RedirectAttributes redirectAttributes) {
		settProvDetailService.delete(settProvDetail);
		addMessage(redirectAttributes, "删除跨省结算详单展示成功");
		return "redirect:" + Global.getAdminPath() + "/newreports/settProvDetail/?repage";
	}

}