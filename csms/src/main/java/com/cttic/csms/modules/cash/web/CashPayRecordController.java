package com.cttic.csms.modules.cash.web;

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
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.cttic.csms.modules.cash.entity.CashPayRecord;
import com.cttic.csms.modules.cash.service.CashPayRecordService;
import com.cttic.csms.modules.cash.service.CashProvisionsService;

/**
 * 备付金缴存相关功能Controller
 * @author ambitious
 * @version 2016-11-24
 */
@Controller
@RequestMapping(value = "${adminPath}/cash/cashPayRecord")
public class CashPayRecordController extends BaseController {

	@Autowired
	private CashPayRecordService cashPayRecordService;
	
	@Autowired
	private CashProvisionsService cashProvisionsService;
	
	@ModelAttribute
	public CashPayRecord get(@RequestParam(required=false) String id) {
		CashPayRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cashPayRecordService.get(id);
		}
		if (entity == null){
			entity = new CashPayRecord();
		}
		
		//如果不是系统管理员，设置组织名称
		if(!UserUtils.getUser().isAdmin()) {
			entity.setOfficeName(UserUtils.getCurOfficeName());
		}
		
		return entity;
	}
	
	@RequiresPermissions("cash:cashPayRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(CashPayRecord cashPayRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CashPayRecord> page = cashPayRecordService.findPage(new Page<CashPayRecord>(request, response), cashPayRecord); 
		// 根据当前用户，获取该用户下面的备付金帐号
		model.addAttribute("provisionsDropDownList", cashProvisionsService.getByCurLoginUser());
		model.addAttribute("page", page);
		return "modules/cash/cashPayRecordList";
	}

	@RequiresPermissions("cash:cashPayRecord:view")
	@RequestMapping(value = "form")
	public String form(CashPayRecord cashPayRecord, Model model) {
		model.addAttribute("cashPayRecord", cashPayRecord);
		// 根据当前用户，获取该用户下面的备付金帐号
		model.addAttribute("provisionsDropDownList", cashProvisionsService.getByCurLoginUser());
		return "modules/cash/cashPayRecordForm";
	}

	@RequiresPermissions("cash:cashPayRecord:edit")
	@RequestMapping(value = "save")
	public String save(CashPayRecord cashPayRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cashPayRecord)){
			return form(cashPayRecord, model);
		}
		if(cashPayRecordService.payProcess(cashPayRecord)) {
			addMessage(redirectAttributes, "备付金正在缴存，已提交银行处理...");
		} else {
			addMessage(redirectAttributes, "银行处理失败，请稍后再进行缴存");
		}
		return "redirect:"+Global.getAdminPath()+"/cash/cashPayRecord/?repage";
	}
	
	@RequiresPermissions("cash:cashPayRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(CashPayRecord cashPayRecord, RedirectAttributes redirectAttributes) {
		cashPayRecordService.delete(cashPayRecord);
		addMessage(redirectAttributes, "删除备付金缴存记录成功");
		return "redirect:"+Global.getAdminPath()+"/cash/cashPayRecord/?repage";
	}
	
}