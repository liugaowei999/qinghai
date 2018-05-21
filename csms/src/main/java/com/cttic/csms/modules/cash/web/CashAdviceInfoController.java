package com.cttic.csms.modules.cash.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.cttic.csms.modules.cash.entity.CashAdviceInfo;
import com.cttic.csms.modules.cash.entity.CashProvisions;
import com.cttic.csms.modules.cash.entity.CashWithdrawRecord;
import com.cttic.csms.modules.cash.service.CashAdviceInfoService;
import com.cttic.csms.modules.cash.service.CashPayPeriodRecordService;
import com.cttic.csms.modules.cash.service.CashProvisionsService;

/**
 * 通知信息Controller
 * @author ambitious
 * @version 2016-11-29
 */
@Controller
@RequestMapping(value = "${adminPath}/cash/cashAdviceInfo")
public class CashAdviceInfoController extends BaseController {

	@Autowired
	private CashAdviceInfoService cashAdviceInfoService;
	@Autowired
	private CashProvisionsService cashProvisionsService;
	@Autowired
	private CashPayPeriodRecordService cashPayPeriodRecordService;

	
	@ModelAttribute
	public CashAdviceInfo get(@RequestParam(required=false) String id) {
		CashAdviceInfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cashAdviceInfoService.get(id);
		}
		if (entity == null){
			entity = new CashAdviceInfo();
		}
		return entity;
	}
	
	@RequiresPermissions("cash:cashAdviceInfo:view")
	@RequestMapping(value = {"userAdviceInfo", ""})
	public String list(CashAdviceInfo cashAdviceInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		CashProvisions cashProvisions = cashPayPeriodRecordService.getCashProvisionsByUserId(user.getId());
		//CashProvisions cashProvisions = cashPayPeriodRecordService.getCashProvisionsByUserId("7");
		String provisionsId="";
		if(cashProvisions!=null){
			provisionsId = cashProvisions.getId();
			cashAdviceInfo.setProvisionsId(provisionsId);
		}
		List<CashAdviceInfo> warningInfoList = cashAdviceInfoService.findInfoByParam(provisionsId,"0");
		List<CashAdviceInfo> adviceInfoList = cashAdviceInfoService.findInfoByParam(provisionsId,"");
		String ndWarningInfoCount = cashAdviceInfoService.countNdInfo(provisionsId,"0","0");
		String ndAdviceInfoCount = cashAdviceInfoService.countNdInfo(provisionsId,"0","");
		model.addAttribute("cashProvisions", cashProvisions);
		model.addAttribute("warningInfoList", warningInfoList);
		model.addAttribute("adviceInfoList", adviceInfoList);
		model.addAttribute("ndWarningInfoCount", ndWarningInfoCount);
		model.addAttribute("ndAdviceInfoCount", ndAdviceInfoCount);
		return "modules/cash/cashAdviceInfoList";
	}
	
	@RequiresPermissions("cash:cashAdviceInfo:view")
	@RequestMapping(value = "warningInfo")
	public String warningInfoList(CashAdviceInfo cashAdviceInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		CashProvisions cashProvisions = cashPayPeriodRecordService.getCashProvisionsByUserId(user.getId());
		//CashProvisions cashProvisions = cashPayPeriodRecordService.getCashProvisionsByUserId("7");
		String provisionsId="";
		if(cashProvisions!=null){
			provisionsId = cashProvisions.getId();
			cashAdviceInfo.setProvisionsId(provisionsId);
		}
		cashAdviceInfo.setAdviceType("0");
		cashAdviceInfo.setDealState("");
		Page<CashAdviceInfo> page = cashAdviceInfoService.findPage(new Page<CashAdviceInfo>(request, response), cashAdviceInfo); 
		String ndWarningInfoCount = cashAdviceInfoService.countNdInfo(provisionsId,"0","0");
		model.addAttribute("page", page);
		model.addAttribute("ndWarningInfoCount", ndWarningInfoCount);
		return "modules/cash/cashAdviceWInfoList";
	}
	
	@RequiresPermissions("cash:cashAdviceInfo:view")
	@RequestMapping(value = "adviceInfo")
	public String adviceInfoList(CashAdviceInfo cashAdviceInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		CashProvisions cashProvisions = cashPayPeriodRecordService.getCashProvisionsByUserId(user.getId());
		//CashProvisions cashProvisions = cashPayPeriodRecordService.getCashProvisionsByUserId("7");
		String provisionsId="";
		if(cashProvisions!=null){
			provisionsId = cashProvisions.getId();
			cashAdviceInfo.setProvisionsId(provisionsId);
		}
		cashAdviceInfo.setDealState("");
		Page<CashAdviceInfo> page = cashAdviceInfoService.findPage(new Page<CashAdviceInfo>(request, response), cashAdviceInfo); 
		String ndAdviceInfoCount = cashAdviceInfoService.countNdInfo(provisionsId,"0","");
		model.addAttribute("page", page);
		model.addAttribute("ndAdviceInfoCount", ndAdviceInfoCount);
		return "modules/cash/cashAdviceAInfoList";
	}
	
	@RequestMapping(value = "updateDealState")
	@ResponseBody
	public boolean form(CashAdviceInfo cashAdviceInfo,String id, Model model) {
		boolean flag = true;
		cashAdviceInfo.setId(id);
		cashAdviceInfo.setDealState("1");
		cashAdviceInfoService.save(cashAdviceInfo);
		return flag;
	}

	@RequiresPermissions("cash:cashAdviceInfo:view")
	@RequestMapping(value = "form")
	public String form(CashAdviceInfo cashAdviceInfo, Model model) {
		model.addAttribute("cashAdviceInfo", cashAdviceInfo);
		return "modules/cash/cashAdviceInfoForm";
	}

	@RequiresPermissions("cash:cashAdviceInfo:edit")
	@RequestMapping(value = "save")
	public String save(CashAdviceInfo cashAdviceInfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cashAdviceInfo)){
			return form(cashAdviceInfo, model);
		}
		cashAdviceInfoService.save(cashAdviceInfo);
		addMessage(redirectAttributes, "保存通知信息成功");
		return "redirect:"+Global.getAdminPath()+"/cash/cashAdviceInfo/?repage";
	}
	
	@RequiresPermissions("cash:cashAdviceInfo:edit")
	@RequestMapping(value = "delete")
	public String delete(CashAdviceInfo cashAdviceInfo, RedirectAttributes redirectAttributes) {
		cashAdviceInfoService.delete(cashAdviceInfo);
		addMessage(redirectAttributes, "删除通知信息成功");
		return "redirect:"+Global.getAdminPath()+"/cash/cashAdviceInfo/?repage";
	}

}