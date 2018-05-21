/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.cash.web;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
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
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.cttic.csms.modules.cash.entity.SettAdDetail;
import com.cttic.csms.modules.cash.service.SettAdDetailService;
import com.cttic.csms.modules.settlementfront.service.BpsSysOrgInfoService;

/**
 * 同步备付金账户金额--差错数据Controller
 * @author wanglk
 * @version 2016-11-26
 */
@Controller
@RequestMapping(value = "${adminPath}/cash/settAdDetail")
public class SettAdDetailController extends BaseController {

	@Autowired
	private SettAdDetailService settAdDetailService;
	@Autowired
	private OfficeService officeService;
	@Autowired
	private BpsSysOrgInfoService bpsSysOrgInfoService;
	@ModelAttribute
	public SettAdDetail get(@RequestParam(required=false) String id) {
		SettAdDetail entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = settAdDetailService.get(id);
			//取机构名称
			Office recv=officeService.get(entity.getRecvOrgCode());
			if(recv!=null){
				entity.setRecvOrgCode(recv.getName());
			}
			recv=officeService.get(entity.getIssueOrgCode());
			if(recv!=null){
				entity.setIssueOrgCode(recv.getName());
			}
			recv=officeService.get(entity.getRecvOrgCode1()) ;
			if(recv!=null){
				entity.setRecvOrgCode1(recv.getName());
			}
			recv=officeService.get(entity.getBillOrgCode()) ;
			if(recv!=null){
				entity.setBillOrgCode(recv.getName());
			}
			recv=officeService.get(entity.getSendOrgId()) ;
			if(recv!=null){
				entity.setSendOrgId(recv.getName());
			}
			recv=officeService.get(entity.getErrOriOrgId());
			if(recv!=null){
				entity.setErrOriOrgId(recv.getName());
			}
			recv=officeService.get(entity.getErrConfirmOrgId()) ;
			if(recv!=null){
				entity.setErrConfirmOrgId(recv.getName());
			}
		}
		if (entity == null){
			entity = new SettAdDetail();
		}
		return entity;
	}
	
	@RequiresPermissions("cash:settAdDetail:view")
	@RequestMapping(value = {"list", ""})
	public String list(SettAdDetail settAdDetail, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isEmpty(settAdDetail.getBeginDate())&&StringUtils.isEmpty(settAdDetail.getEndDate())){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			settAdDetail.setBeginDate(sdf.format(calendar.getTime()));
			calendar.set(Calendar.DAY_OF_MONTH,calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
			settAdDetail.setEndDate(sdf.format(calendar.getTime()));
		}
		Page<SettAdDetail> page = settAdDetailService.findPage(new Page<SettAdDetail>(request, response), settAdDetail); 
		//取机构名称
		List<SettAdDetail> list = page.getList();
		for (SettAdDetail entity : list){
			//取机构名称
			Office recv=officeService.get(entity.getRecvOrgCode());
			if(recv!=null){
				entity.setRecvOrgCode(recv.getName());
			}
			recv=officeService.get(entity.getIssueOrgCode());
			if(recv!=null){
				entity.setIssueOrgCode(recv.getName());
			}
			recv=officeService.get(entity.getRecvOrgCode1()) ;
			if(recv!=null){
				entity.setRecvOrgCode1(recv.getName());
			}
			recv=officeService.get(entity.getBillOrgCode()) ;
			if(recv!=null){
				entity.setBillOrgCode(recv.getName());
			}
			recv=officeService.get(entity.getSendOrgId()) ;
			if(recv!=null){
				entity.setSendOrgId(recv.getName());
			}
			recv=officeService.get(entity.getErrOriOrgId());
			if(recv!=null){
				entity.setErrOriOrgId(recv.getName());
			}
			recv=officeService.get(entity.getErrConfirmOrgId()) ;
			if(recv!=null){
				entity.setErrConfirmOrgId(recv.getName());
			}
		}
		Map<String,String> orgInfoDropDownMap = bpsSysOrgInfoService.getOrgInfoDropDownMap();
		model.addAttribute("orgInfoDropDownMap",orgInfoDropDownMap);
		model.addAttribute("page", page);
		return "modules/cash/settAdDetailList";
	}

	@RequiresPermissions("cash:settAdDetail:view")
	@RequestMapping(value = "form")
	public String form(SettAdDetail settAdDetail, Model model) {
		model.addAttribute("settAdDetail", settAdDetail);
		return "modules/cash/settAdDetailForm";
	}

	@RequiresPermissions("cash:settAdDetail:edit")
	@RequestMapping(value = "save")
	public String save(SettAdDetail settAdDetail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, settAdDetail)){
			return form(settAdDetail, model);
		}
		settAdDetailService.save(settAdDetail);
		addMessage(redirectAttributes, "保存记录成功");
		return "redirect:"+Global.getAdminPath()+"/cash/settAdDetail/?repage";
	}
	
	@RequiresPermissions("cash:settAdDetail:edit")
	@RequestMapping(value = "delete")
	public String delete(SettAdDetail settAdDetail, RedirectAttributes redirectAttributes) {
		settAdDetailService.delete(settAdDetail);
		addMessage(redirectAttributes, "删除记录成功");
		return "redirect:"+Global.getAdminPath()+"/cash/settAdDetail/?repage";
	}

}