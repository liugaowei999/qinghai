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

import com.cttic.csms.modules.newreports.entity.SettCityDetail;
import com.cttic.csms.modules.newreports.service.SettCityDetailService;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;

/**
 * 省内结算详单展示Controller
 * @author aryo
 * @version 2017-03-07
 */
@Controller
@RequestMapping(value = "${adminPath}/newreports/settCityDetail")
public class SettCityDetailController extends BaseController {

	@Autowired
	private SettCityDetailService settCityDetailService;

	@ModelAttribute
	public SettCityDetail get(@RequestParam(required = false) String id) {
		SettCityDetail entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = settCityDetailService.get(id);
		}
		if (entity == null) {
			entity = new SettCityDetail();
		}
		return entity;
	}

	@RequiresPermissions("newreports:settCityDetail:view")
	@RequestMapping(value = { "list", "" })
	public String list(SettCityDetail settCityDetail, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		if (StringUtils.isEmpty(settCityDetail.getBeginSettDate())
				&& StringUtils.isEmpty(settCityDetail.getEndSettDate())) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			settCityDetail.setBeginSettDate(sdf.format(calendar.getTime()));
			calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
			settCityDetail.setEndSettDate(sdf.format(calendar.getTime()));
		}
		//add sum, 必须先获取总数， 再获取明细， 否则 page对象中的总条数会被覆盖掉不正确
		SettCityDetail settCityDetailSum = settCityDetailService.getSum(settCityDetail);
		Page<SettCityDetail> page = settCityDetailService.findPage(new Page<SettCityDetail>(request, response),
				settCityDetail);
		List<SettCityDetail> allList = settCityDetailService.findAllList();
		List<String> billOrgNameList = new ArrayList<String>();
		List<String> issueOrgNameList = new ArrayList<String>();
		List<String> settOrgCodeList = new ArrayList<String>();

		for (SettCityDetail ss : allList) {

			if (!StringUtils.isEmpty(ss.getBillOrgName()) && (!billOrgNameList.contains(ss.getBillOrgName()))) {
				billOrgNameList.add(ss.getBillOrgName().trim());
			}
			if (!StringUtils.isEmpty(ss.getIssueOrgName()) && (!issueOrgNameList.contains(ss.getIssueOrgName()))) {
				issueOrgNameList.add(ss.getIssueOrgName().trim());
			}

			if (!StringUtils.isEmpty(ss.getSettOrgCode()) && (!settOrgCodeList.contains(ss.getSettOrgCode()))) {
				settOrgCodeList.add(ss.getSettOrgCode().trim());
			}

		}

		//add sum
		if (settCityDetailSum != null) {
			settCityDetailSum.setSettDate("合计：");
			//settCityDetailSum.setCardNo(page.getCount() + "笔");
			page.getList().add(settCityDetailSum);
		}
		model.addAttribute("page", page);
		model.addAttribute("billOrgNameList", billOrgNameList);
		model.addAttribute("issueOrgNameList", issueOrgNameList);
		model.addAttribute("settOrgCodeList", settOrgCodeList);
		return "modules/newreports/settCityDetailList";
	}

	/**
	 * 导出报表
	 * @param settCityDetail
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("newreports:settCityDetail:view")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(SettCityDetail settCityDetail, HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes redirectAttributes) {
		try {
			String fileName;
			if (StringUtils.isEmpty(settCityDetail.getBeginSettDate())
					|| StringUtils.isEmpty(settCityDetail.getEndSettDate())) {
				fileName = "省内明细结算报表.xlsx";
			} else {
				fileName = "省内明细结算报表" + "(" + settCityDetail.getBeginSettDate() + "-" + settCityDetail.getEndSettDate()
						+ ").xlsx";
			}

			//Page<SettCityDetail> page = settCityDetailService.findPage(new Page<SettCityDetail>(request, response), settCityDetail);
			List<SettCityDetail> displayList = settCityDetailService.findList(settCityDetail);
			SettCityDetail settCityDetailSum = settCityDetailService.getSum(settCityDetail);
			if (settCityDetailSum != null) {
				settCityDetailSum.setSettDate("合计:");
				displayList.add(settCityDetailSum);
			}

			new ExportExcel("省内明细结算报表", SettCityDetail.class).setDataList(displayList).write(response, fileName)
					.dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/newreports/settCityDetail/?repage";
	}

	@RequiresPermissions("newreports:settCityDetail:view")
	@RequestMapping(value = "form")
	public String form(SettCityDetail settCityDetail, Model model) {
		model.addAttribute("settCityDetail", settCityDetail);
		return "modules/newreports/settCityDetailForm";
	}

	@RequiresPermissions("newreports:settCityDetail:edit")
	@RequestMapping(value = "save")
	public String save(SettCityDetail settCityDetail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, settCityDetail)) {
			return form(settCityDetail, model);
		}
		settCityDetailService.save(settCityDetail);
		addMessage(redirectAttributes, "保存省内结算详单展示成功");
		return "redirect:" + Global.getAdminPath() + "/newreports/settCityDetail/?repage";
	}

	@RequiresPermissions("newreports:settCityDetail:edit")
	@RequestMapping(value = "delete")
	public String delete(SettCityDetail settCityDetail, RedirectAttributes redirectAttributes) {
		settCityDetailService.delete(settCityDetail);
		addMessage(redirectAttributes, "删除省内结算详单展示成功");
		return "redirect:" + Global.getAdminPath() + "/newreports/settCityDetail/?repage";
	}

}