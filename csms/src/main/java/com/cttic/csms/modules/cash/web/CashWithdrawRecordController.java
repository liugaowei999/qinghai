/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.cash.web;

import java.util.HashMap;
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
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.cttic.csms.modules.cash.entity.CashAdviceInfo;
import com.cttic.csms.modules.cash.entity.CashProvisions;
import com.cttic.csms.modules.cash.entity.CashWithdrawRecord;
import com.cttic.csms.modules.cash.service.CashAdviceInfoService;
import com.cttic.csms.modules.cash.service.CashPayPeriodRecordService;
import com.cttic.csms.modules.cash.service.CashProvisionsService;
import com.cttic.csms.modules.cash.service.CashWithdrawRecordService;

/**
 * 备付金提现记录Controller
 * @author aryo
 * @version 2016-11-24
 */
@Controller
@RequestMapping(value = "${adminPath}/cash/cashWithdrawRecord")
public class CashWithdrawRecordController extends BaseController {

	@Autowired
	private CashWithdrawRecordService cashWithdrawRecordService;
	@Autowired
	private CashAdviceInfoService cashAdviceInfoService;
	@Autowired
	private CashPayPeriodRecordService cashPayPeriodRecordService;
	
	@Autowired
	private CashProvisionsService cashProvisionsService;
	
	private User user = UserUtils.getUser();
	
	@ModelAttribute
	public CashWithdrawRecord get(@RequestParam(required=false) String id) {
		CashWithdrawRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cashWithdrawRecordService.get(id);
		}
		if (entity == null){
			entity = new CashWithdrawRecord();
		}
		return entity;
	}
	
	/**
	 * 现金提现申请记录列表
	 * @param cashWithdrawRecord
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "cashWithdrawList")
	public String cashWithdrawList(CashWithdrawRecord cashWithdrawRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		CashProvisions cashProvisions = cashPayPeriodRecordService.getCashProvisionsByUserId(user.getId());
		if(cashProvisions!=null){
			cashWithdrawRecord.setProvisionsId(cashProvisions.getId());
		}
		Page<CashWithdrawRecord> page = cashWithdrawRecordService.findPage(new Page<CashWithdrawRecord>(request, response), cashWithdrawRecord); 
		model.addAttribute("page", page);
		return "modules/cash/cashWithdrawRecordList";
	}
	
	/**
	 * 现金申请记录审核列表
	 * @param cashWithdrawRecord
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "cashWithdrawExamineList")
	public String cashWithdrawExamineList(CashWithdrawRecord cashWithdrawRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CashWithdrawRecord> page = cashWithdrawRecordService.findPage(new Page<CashWithdrawRecord>(request, response), cashWithdrawRecord); 
		model.addAttribute("provisionMap",getProvisionMap());
		model.addAttribute("page", page);
		return "modules/cash/cashWithdrawExamineList";
	}

	/**
	 * 现金提现申请
	 * @param cashWithdrawRecord
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "cashWithdrawApply")
	public String cashWithdrawApply(CashWithdrawRecord cashWithdrawRecord,Model model) {
		CashProvisions cashProvisions = cashPayPeriodRecordService.getCashProvisionsByUserId(user.getId());
		String withdrawFlag = "1";
		if(cashProvisions!=null){
			if(cashProvisions.getWithdrawDeposite()>0){
				withdrawFlag = "2";
			}
		}
		model.addAttribute("cashProvisions", cashProvisions);
		model.addAttribute("withdrawFlag", withdrawFlag);
		return "modules/cash/cashWithdrawRecordForm";
	}
	
	/**
	 * 现金提现申请审核
	 * @param withdrawId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "cashWithdrawExamine")
	public String cashWithdrawExamine(String withdrawId,Model model) {
		CashWithdrawRecord cashWithdrawRecord = cashWithdrawRecordService.get(withdrawId);
		CashProvisions cashProvisions = cashProvisionsService.get(cashWithdrawRecord.getProvisionsId());
		
		model.addAttribute("cashProvisions", cashProvisions);
		model.addAttribute("cashWithdrawRecord", cashWithdrawRecord);
		return "modules/cash/cashWithdrawExamine";
	}

	/**
	 * 现金申请记录保存
	 * @param cashWithdrawRecord
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "cashWithdrawApplySave")
	public String cashWithdrawApplySave(CashWithdrawRecord cashWithdrawRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cashWithdrawRecord)){
			return cashWithdrawApply(cashWithdrawRecord, model);
		}
		CashProvisions cashProvisions = cashProvisionsService.get(cashWithdrawRecord.getProvisionsId());
		cashWithdrawRecord.setPreWithdrawDeposite(cashProvisions.getTotalAmount());
		cashWithdrawRecord.setNextWithdrawDeposite(cashProvisions.getTotalAmount()-cashWithdrawRecord.getWithdrawDeposite());
		cashWithdrawRecord.setWithdrawType("1");
		cashWithdrawRecord.setWithdrawState("0");
		cashWithdrawRecord.setIsNewRecord(true);
		cashProvisions.setTotalAmount(cashProvisions.getTotalAmount()-cashWithdrawRecord.getWithdrawDeposite());
		cashProvisions.setRemainingSum(cashProvisions.getRemainingSum()-cashWithdrawRecord.getWithdrawDeposite());
		cashProvisions.setWithdrawDeposite(cashProvisions.getWithdrawDeposite()-cashWithdrawRecord.getWithdrawDeposite());
		cashWithdrawRecordService.cashWithdrawApplySave(cashWithdrawRecord,cashProvisions);
		addMessage(redirectAttributes, "提现申请成功！");
		return "redirect:"+Global.getAdminPath()+"/cash/cashWithdrawRecord/cashWithdrawList/?repage";
	}
	
	/**
	 * 现金申请审核保存
	 * @param cashWithdrawRecord
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "cashWithdrawExamineSave")
	public String cashWithdrawExamineSave(CashWithdrawRecord cashWithdrawRecords, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cashWithdrawRecords)){
			return cashWithdrawApply(cashWithdrawRecords, model);
		}
		
		cashWithdrawRecordService.cashWithdrawExamineSave(cashWithdrawRecords);
		CashWithdrawRecord cashWithdrawRecord = cashWithdrawRecordService.get(cashWithdrawRecords.getWithdrawId());
		CashAdviceInfo cashAdviceInfo = new CashAdviceInfo();
		cashAdviceInfo.setProvisionsId(cashWithdrawRecord.getProvisionsId());
		cashAdviceInfo.setDealState("0");
		cashAdviceInfo.setAdviceType("4");
		cashAdviceInfo.setNeedPay(0d);
		String message = "";
		String withdrawState = cashWithdrawRecord.getWithdrawState();
		if(withdrawState.equals("1")){
			message = "尊敬得用户您好，你本次提现的"+cashWithdrawRecord.getWithdrawDeposite()+"元已到账，请注意查收！";
			cashAdviceInfo.setMessage(message);
			cashAdviceInfoService.save(cashAdviceInfo);
		}else if(withdrawState.equals("2")){
			message = "尊敬得用户您好，你本次提现"+cashWithdrawRecord.getWithdrawDeposite()+"元的申请未通过审核，如有疑问，请和管理员联系！";
			cashAdviceInfo.setMessage(message);
			cashAdviceInfoService.save(cashAdviceInfo);
		}
		addMessage(redirectAttributes, "提现申请审核完成！");
		return "redirect:"+Global.getAdminPath()+"/cash/cashWithdrawRecord/cashWithdrawExamineList/?repage";
	}
	
	/**
	 * 获取备付金下拉列表
	 * @return
	 */
	public Map<String, String> getProvisionMap() {
		CashProvisions cashProvisions = new CashProvisions();
		
		List<CashProvisions> provisionList = cashProvisionsService.findList(cashProvisions);
		Map<String, String> provisionMap = new HashMap<String,String>();
		for (CashProvisions provision : provisionList) {
			provisionMap.put(provision.getId(), provision.getProvisionsNo());
		}
		
		return provisionMap;
	}
	

}