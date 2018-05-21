/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.cash.web;

import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.cttic.csms.modules.cash.entity.SettBpDetail;
import com.cttic.csms.modules.cash.service.SettBpDetailService;
import com.cttic.csms.modules.settlementfront.service.BpsSysOrgInfoService;

/**
 * 同步备付金账户金额Controller
 * @author wanglk
 * @version 2016-11-26
 */
@Controller
@RequestMapping(value = "${adminPath}/cash/settBpDetail")
public class SettBpDetailController extends BaseController {

	@Autowired
	private SettBpDetailService settBpDetailService;
	@Autowired
	private BpsSysOrgInfoService bpsSysOrgInfoService;
	@ModelAttribute
	public SettBpDetail get(@RequestParam(required=false) String id) {
		SettBpDetail entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = settBpDetailService.get(id);
		}
		if (entity == null){
			entity = new SettBpDetail();
		}
		return entity;
	}
	
	@RequiresPermissions("cash:settBpDetail:view")
	@RequestMapping(value = {"list", ""})
	public String list(SettBpDetail settBpDetail, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isEmpty(settBpDetail.getBeginDate())&&StringUtils.isEmpty(settBpDetail.getEndDate())){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			settBpDetail.setBeginDate(sdf.format(calendar.getTime()));
			calendar.set(Calendar.DAY_OF_MONTH,calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
			settBpDetail.setEndDate(sdf.format(calendar.getTime()));
		}
		Page<SettBpDetail> page = settBpDetailService.findPage(new Page<SettBpDetail>(request, response), settBpDetail); 
		Map<String,String> orgInfoDropDownMap = bpsSysOrgInfoService.getOrgInfoDropDownMap();
		model.addAttribute("orgInfoDropDownMap",orgInfoDropDownMap);
		model.addAttribute("page", page);
		return "modules/cash/settBpDetailList";
	}

	@RequiresPermissions("cash:settBpDetail:view")
	@RequestMapping(value = "form")
	public String form(SettBpDetail settBpDetail, Model model) {
		model.addAttribute("settBpDetail", settBpDetail);
		return "modules/cash/settBpDetailForm";
	}

	@RequiresPermissions("cash:settBpDetail:edit")
	@RequestMapping(value = "save")
	public String save(SettBpDetail settBpDetail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, settBpDetail)){
			return form(settBpDetail, model);
		}
		settBpDetailService.save(settBpDetail);
		addMessage(redirectAttributes, "保存记录成功");
		return "redirect:"+Global.getAdminPath()+"/cash/settBpDetail/?repage";
	}
	
	@RequiresPermissions("cash:settBpDetail:edit")
	@RequestMapping(value = "delete")
	public String delete(SettBpDetail settBpDetail, RedirectAttributes redirectAttributes) {
		settBpDetailService.delete(settBpDetail);
		addMessage(redirectAttributes, "删除记录成功");
		return "redirect:"+Global.getAdminPath()+"/cash/settBpDetail/?repage";
	}

}