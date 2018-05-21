/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.cash.web;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
import com.cttic.csms.modules.cash.entity.CashPayPeriodRecord;
import com.cttic.csms.modules.cash.entity.CashPayRecord;
import com.cttic.csms.modules.cash.entity.CashProvisions;
import com.cttic.csms.modules.cash.service.CashAdviceInfoService;
import com.cttic.csms.modules.cash.service.CashPayPeriodRecordService;
import com.cttic.csms.modules.cash.service.CashPayRecordService;
import com.cttic.csms.modules.cash.service.CashProvisionsService;

/**
 * 备付金缴存周期变更Controller
 * @author aryo
 * @version 2016-11-25
 */
@Controller
@RequestMapping(value = "${adminPath}/cash/cashPayPeriodRecord")
public class CashPayPeriodRecordController extends BaseController {

	@Autowired
	private CashPayPeriodRecordService cashPayPeriodRecordService;
	@Autowired
	private CashPayRecordService cashPayRecordService;
	@Autowired
	private CashProvisionsService cashProvisionsService;
	@Autowired
	private CashAdviceInfoService cashAdviceInfoService;
	
	@ModelAttribute
	public CashPayPeriodRecord get(@RequestParam(required=false) String id) {
		CashPayPeriodRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cashPayPeriodRecordService.get(id);
		}
		if (entity == null){
			entity = new CashPayPeriodRecord();
		}
		return entity;
	}
	

	/**
	 * 周期变更申请记录列表
	 * @param cashPayPeriodRecord
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"periodRecordList", ""})
	public String periodRecordList(CashPayPeriodRecord cashPayPeriodRecord,HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		CashProvisions cashProvisions = cashPayPeriodRecordService.getCashProvisionsByUserId(user.getId());
		if(cashProvisions!=null){
			cashPayPeriodRecord.setProvisionsId(cashProvisions.getId());
		}
		/*cashPayPeriodRecord.setProvisionsId("4");*/
		Page<CashPayPeriodRecord> page = cashPayPeriodRecordService.findPage(new Page<CashPayPeriodRecord>(request, response), cashPayPeriodRecord); 
		
		model.addAttribute("page", page);
		return "modules/cash/cashPayPeriodRecordList";
	}
	
	/**
	 * 周期变更申请记录审核列表
	 * @param cashPayPeriodRecord
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "examinePeriodList")
	public String examinePeriodList(CashPayPeriodRecord cashPayPeriodRecord,HttpServletRequest request, HttpServletResponse response, Model model){
		Page<CashPayPeriodRecord> page = cashPayPeriodRecordService.findPage(new Page<CashPayPeriodRecord>(request, response), cashPayPeriodRecord); 
		model.addAttribute("provisionMap",getProvisionMap());
		model.addAttribute("page", page);
		return "modules/cash/cashPayPeriodExamineList";
	}

	/**
	 * 周期变更申请审核页面
	 * @param cashPayPeriodRecord
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "toExaminePayPeriod")
	public String toExaminePayPeriod(CashPayPeriodRecord cashPayPeriodRecord,HttpServletRequest request, HttpServletResponse response, Model model) {
		cashPayPeriodRecord = cashPayPeriodRecordService.get(cashPayPeriodRecord.getPeriodId());
		CashProvisions cashProvisions = new CashProvisions();
		cashProvisions.setId(cashPayPeriodRecord.getProvisionsId());
		CashPayRecord cashPayRecord= new CashPayRecord();
		cashPayRecord.setCashProvisions(cashProvisions);
		Page<CashPayRecord> page = cashPayRecordService.findPage(new Page<CashPayRecord>(request, response), cashPayRecord);
		model.addAttribute("cashPayPeriodRecord", cashPayPeriodRecord);
		model.addAttribute("page", page);
		return "modules/cash/cashPayPeriodExamine";
	}
	
	/**
	 * 周期变更申请审核保存
	 * @param cashPayPeriodRecord
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "examinePeriod")
	public String examinePeriod(CashPayPeriodRecord cashPayPeriodRecords, RedirectAttributes redirectAttributes) {
		cashPayPeriodRecords.preUpdate();
		cashPayPeriodRecordService.update(cashPayPeriodRecords);
		CashPayPeriodRecord cashPayPeriodRecord = cashPayPeriodRecordService.get(cashPayPeriodRecords.getPeriodId());
		String message = "";
		String adviceMessage = "";
		CashAdviceInfo cashAdviceInfo = new CashAdviceInfo();
		cashAdviceInfo.setProvisionsId(cashPayPeriodRecord.getProvisionsId());
		cashAdviceInfo.setDealState("0");
		
		String examineStatus = cashPayPeriodRecord.getExamineStatus();
		String modifyStatus = cashPayPeriodRecord.getModifyStatus();
		Double needPayMoney = cashPayPeriodRecord.getNeePayMoney()==null?0d:cashPayPeriodRecord.getNeePayMoney();
		System.out.println(cashPayPeriodRecord.getNeePayMoney());
		System.out.println(needPayMoney);
		if(examineStatus.equals("0")){
			message = "缴存周期申请保存成功！";
		}else if(examineStatus.equals("1")){
			if(modifyStatus.equals("0")){
				message = "缴存周期申请审核成功！";
				if(needPayMoney!=0){
					adviceMessage = "尊敬的用户您好，你本次的缴存周期变更申请已通过审核，请尽快缴纳需补齐的备付金，谢谢！";
					cashAdviceInfo.setAdviceType("0");
					Date currentDate = new Date();
					Calendar cu = Calendar.getInstance();
					cu.setTime(currentDate);
					cu.add(Calendar.DATE,3);
					cashAdviceInfo.setPayDeadline(cu.getTime());
					cashAdviceInfo.setNeedPay(needPayMoney);
					cashAdviceInfoService.save(cashAdviceInfo);
				}
				
			}else if(modifyStatus.equals("1")){
				message = "缴存周期申请变更成功！";
				adviceMessage = "尊敬的用户您好，你本次的缴存周期变更申请已成功，请按照新的缴存周期缴存备付金，谢谢！";
			}else{
				message = "缴存周期申请变更失败！";
				adviceMessage = "尊敬的用户您好，由于你未及时缴纳备付金，你本次的缴存周期变更申请未能通过，如有疑问，请联系管理员！";
			}
		}else{
			message = "缴存周期申请审核失败！";
			adviceMessage = "尊敬的用户您好，你本次的缴存周期变更申请未能通过，如有疑问，请联系管理员！";
		}
		cashAdviceInfo.setMessage(adviceMessage);
		cashAdviceInfo.setAdviceType("3");
		cashAdviceInfo.setNeedPay(needPayMoney);
		cashAdviceInfoService.save(cashAdviceInfo);
		addMessage(redirectAttributes, message);
		return "redirect:"+Global.getAdminPath()+"/cash/cashPayPeriodRecord/examinePeriodList/?repage";
	}
	
	/**
	 * 周期变更申请页面
	 * @param cashPayPeriodRecord
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "toCashPayPeriod")
	public String toCashPayPeriod(CashPayPeriodRecord cashPayPeriodRecord, Model model) {
		User user = UserUtils.getUser();
		CashProvisions cashProvisions = cashPayPeriodRecordService.getCashProvisionsByUserId(user.getId());
		if(cashProvisions!=null){
			cashPayPeriodRecord.setProvisionsId(cashProvisions.getId());
			cashPayPeriodRecord.setProvisionsNo(cashProvisions.getProvisionsNo());
			cashPayPeriodRecord.setOriPayPeriod(cashProvisions.getPayPeriod());
			if(cashProvisions.getPayPeriod().equals("1")){
				cashPayPeriodRecord.setCurPayPeriod("2");
			}else{
				cashPayPeriodRecord.setCurPayPeriod("1");
			}
		}
		String periodValidate =periodValidate(cashPayPeriodRecord.getProvisionsId());
		model.addAttribute("periodValidate", periodValidate);
		model.addAttribute("cashPayPeriodRecord", cashPayPeriodRecord);
		return "modules/cash/cashPayPeriodForm";
	}

	/**
	 * 周期变更申请保存
	 * @param cashPayPeriodRecord
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "cashPayPeriodSave")
	public String cashPayPeriodSave(CashPayPeriodRecord cashPayPeriodRecord, Model model, RedirectAttributes redirectAttributes) {
		/*if (!beanValidator(model, cashPayPeriodRecord)){
			return toCashPayPeriod(cashPayPeriodRecord, model);
		}*/
		if(cashPayPeriodRecord.getCurPayPeriod().equals("1")){
			cashPayPeriodRecord.setNeePayMoney(0d);
		}else{
			Double needPay = cashProvisionsService.get(cashPayPeriodRecord.getProvisionsId()).getNeedPay();
			needPay = (needPay/7)*31;
			cashPayPeriodRecord.setNeePayMoney(needPay);
		}
		cashPayPeriodRecord.setModifyStatus("0");
		cashPayPeriodRecord.setExamineStatus("0");
		cashPayPeriodRecordService.save(cashPayPeriodRecord);
		addMessage(redirectAttributes, "备付金缴存周期变更申请已提交，请耐心等待审核！");
		return "redirect:"+Global.getAdminPath()+"/cash/cashPayPeriodRecord/?repage";
	}
	
	
	/**
	 * 周期变更申请撤回
	 * @param cashPayPeriodRecord
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "cancelPayPeriod")
	public String cancelPayPeriod(CashPayPeriodRecord cashPayPeriodRecord, RedirectAttributes redirectAttributes) {
		cashPayPeriodRecord.setExamineStatus("2");
		cashPayPeriodRecord.setModifyStatus("2");
		cashPayPeriodRecord.setPeriodStatus("1");
		cashPayPeriodRecord.preUpdate();
		cashPayPeriodRecordService.update(cashPayPeriodRecord);
		addMessage(redirectAttributes, "申请撤回缴存周期变更请求成功");
		return "redirect:"+Global.getAdminPath()+"/cash/cashPayPeriodRecord/?repage";
	}
	
	/**
	 * 不满足申请条件时信息警告页面
	 * @param cashPayPeriodRecord
	 * @return
	 */
	@RequestMapping(value = "toWaringInfo")
	public String toWaringInfo(CashPayPeriodRecord cashPayPeriodRecord) {
		
		return "modules/cash/cashPayPeriodWaringInfo";
	}
	
	/**
	 * 周期变更申请满足条件验证
	 * @param provisionsId
	 * @return
	 */
	public String periodValidate(String provisionsId){
		String validateFlag = "0";
		CashPayPeriodRecord cashPayPeriodRecord = new CashPayPeriodRecord();
		cashPayPeriodRecord.setProvisionsId(provisionsId);
		cashPayPeriodRecord.setModifyStatus("0");
		List<CashPayPeriodRecord> list = cashPayPeriodRecordService.findList(cashPayPeriodRecord);
		if(list==null || list.size()==0){
			Date createDate = queryProvisionsCreateDate(provisionsId);
			Date modifySuccessDate = queryPeriodSuccessDate(provisionsId);
			Date currentDate = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
			Calendar cu = Calendar.getInstance();
			cu.setTime(currentDate);
			Calendar cr = Calendar.getInstance();
			cr.setTime(createDate);
			cr.add(Calendar.MONTH,3);
			String cuDate = dateFormat.format(cu.getTime());
			String crDate = dateFormat.format(cr.getTime());
			int result1 = cuDate.compareTo(crDate);
			if(modifySuccessDate==null){
				if(result1<0){
					validateFlag = "1";
				}
			}else{
				Calendar mo = Calendar.getInstance();
				mo.setTime(modifySuccessDate);
				mo.add(Calendar.MONTH,3);
				String moDate = dateFormat.format(mo.getTime());
				int result2 = cuDate.compareTo(moDate);
				if(result2<0){
					validateFlag = "1";
				}
			}
		}
		
		
		return validateFlag;
	}
	
	/**
	 * 查找备付金账号创建日期
	 * @param provisionsId
	 * @return
	 */
	public Date queryProvisionsCreateDate(String provisionsId){
		CashProvisions cashProvisions = cashProvisionsService.get(provisionsId);
		Date createDate = new Date();
		if(cashProvisions!=null){
			createDate = cashProvisions.getCreateDate();
		}
		return createDate;
	} 
	
	/**
	 * 查找备付金缴存周期变更成功日期
	 * @param provisionsId
	 * @return
	 */
	public Date queryPeriodSuccessDate(String provisionsId){
		CashPayPeriodRecord cashPayPeriodRecord = cashPayPeriodRecordService.findLastSuccessRecord(provisionsId);
		Date modifySuccessDate = null;
		if(cashPayPeriodRecord!=null){
			modifySuccessDate = cashPayPeriodRecord.getUpdateDate();
		}
		return modifySuccessDate;
	} 
	
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
