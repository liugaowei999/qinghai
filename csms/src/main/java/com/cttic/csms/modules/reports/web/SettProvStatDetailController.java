/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.reports.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
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

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.cttic.csms.common.utils.ArithmeticUtils;
import com.cttic.csms.modules.reports.entity.SettProvStatDetail;
import com.cttic.csms.modules.reports.service.SettProvStatDetailService;

/**
 * 跨省结算报表展示Controller
 * @author wanglk
 * @version 2016-12-22
 */
@Controller
@RequestMapping(value = "${adminPath}/reports/settProvStatDetail")
public class SettProvStatDetailController extends BaseController {

	@Autowired
	private SettProvStatDetailService settProvStatDetailService;
	
	@ModelAttribute
	public SettProvStatDetail get(@RequestParam(required=false) String id) {
		SettProvStatDetail entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = settProvStatDetailService.get(id);
		}
		if (entity == null){
			entity = new SettProvStatDetail();
		}
		return entity;
	}
	
	@RequiresPermissions("reports:settProvStatDetail:view")
	@RequestMapping(value = {"list", ""})
	public String list(SettProvStatDetail settProvStatDetail, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isEmpty(settProvStatDetail.getBeginSettDate())&&StringUtils.isEmpty(settProvStatDetail.getEndSettDate())){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			settProvStatDetail.setBeginSettDate(sdf.format(calendar.getTime()));
			calendar.set(Calendar.DAY_OF_MONTH,calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
			settProvStatDetail.setEndSettDate(sdf.format(calendar.getTime()));
		}
		Page<SettProvStatDetail> page = settProvStatDetailService.findPage(new Page<SettProvStatDetail>(request, response), settProvStatDetail); 
		SettProvStatDetail settProvStatDetailSum = settProvStatDetailService.settProvStatDetailSum(settProvStatDetail);
		
		List<String> billOrgNameList = new ArrayList<String>();
		List<String> issueOrgNameList = new ArrayList<String>();
		for(SettProvStatDetail ss:page.getList()){
			
			if(!StringUtils.isEmpty(ss.getBillOrgName())&&(!billOrgNameList.contains(ss.getBillOrgName()))){
				billOrgNameList.add(ss.getBillOrgName().trim());
			}
			if(!StringUtils.isEmpty(ss.getIssueOrgName())&&(!issueOrgNameList.contains(ss.getIssueOrgName()))){
				issueOrgNameList.add(ss.getIssueOrgName().trim());
			}
			
		}
		
		if(settProvStatDetailSum!=null){
			settProvStatDetailSum.setSettDate("合计：");
			page.getList().add(settProvStatDetailSum);
		}
		model.addAttribute("page", page);
		model.addAttribute("billOrgNameList", billOrgNameList);
		model.addAttribute("issueOrgNameList", issueOrgNameList);
		return "modules/reports/settProvStatDetailList";
	}

	@RequiresPermissions("reports:settProvStatDetail:view")
	@RequestMapping(value = "form")
	public String form(SettProvStatDetail settProvStatDetail, Model model) {
		model.addAttribute("settProvStatDetail", settProvStatDetail);
		return "modules/reports/settProvStatDetailForm";
	}

	@RequiresPermissions("reports:settProvStatDetail:edit")
	@RequestMapping(value = "save")
	public String save(SettProvStatDetail settProvStatDetail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, settProvStatDetail)){
			return form(settProvStatDetail, model);
		}
		settProvStatDetailService.save(settProvStatDetail);
		addMessage(redirectAttributes, "保存记录成功");
		return "redirect:"+Global.getAdminPath()+"/reports/settProvStatDetail/?repage";
	}
	
	@RequiresPermissions("reports:settProvStatDetail:edit")
	@RequestMapping(value = "delete")
	public String delete(SettProvStatDetail settProvStatDetail, RedirectAttributes redirectAttributes) {
		settProvStatDetailService.delete(settProvStatDetail);
		addMessage(redirectAttributes, "删除记录成功");
		return "redirect:"+Global.getAdminPath()+"/reports/settProvStatDetail/?repage";
	}
	
	/**
	 * 导出报表
	 * @param settStatReport
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("reports:settProvStatDetail:view")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(SettProvStatDetail settProvStatDetail, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName;
			if(StringUtils.isEmpty(settProvStatDetail.getBeginSettDate())||StringUtils.isEmpty(settProvStatDetail.getEndSettDate())){
				fileName ="跨省结算报表.xlsx";
			}
			else{
				fileName ="跨省结算报表"+"("+settProvStatDetail.getBeginSettDate()+"-"+settProvStatDetail.getEndSettDate()+").xlsx";
			}
            
            Page<SettProvStatDetail> page = settProvStatDetailService.findPage(new Page<SettProvStatDetail>(request, response), settProvStatDetail); 
    		SettProvStatDetail settProvStatDetailSum = settProvStatDetailService.settProvStatDetailSum(settProvStatDetail);
            /*double tradeSum=0.0;
    		double serviceSum=0.0;
    		double issueSum=0.0;
    		double billSum=0.0;
    		double centerSum=0.0;
    		double settSum=0.0;
    		double timesSum=0;
    		for(SettProvStatDetail ss:page.getList()){
    			tradeSum=ArithmeticUtils.add(tradeSum,ss.getTradeCharge());
    			serviceSum=ArithmeticUtils.add(serviceSum,ss.getServiceFee());
    			issueSum=ArithmeticUtils.add(issueSum,ss.getIssueCharge());
    			billSum=ArithmeticUtils.add(billSum,ss.getBillCharge());
    			centerSum=ArithmeticUtils.add(centerSum,ss.getCenterCharge());
    			settSum=ArithmeticUtils.add(settSum,ss.getSettCharge());
    			timesSum=ArithmeticUtils.add(timesSum,ss.getTimes());
    		}
    		SettProvStatDetail sum = new SettProvStatDetail();
    		sum.setSettDate("合计：");
    		sum.setIssueOrgName("");
    		sum.setBillOrgName("");
    		sum.setTradeCharge(tradeSum);
    		sum.setServiceFee(serviceSum);
    		sum.setIssueCharge(issueSum);
    		sum.setBillCharge(billSum);
    		sum.setCenterCharge(centerSum);
    		sum.setSettCharge(settSum);
    		sum.setTimes(timesSum);  */
    		if(settProvStatDetailSum!=null){
    			settProvStatDetailSum.setSettDate("合计：");
    			page.getList().add(settProvStatDetailSum);
    		}
            new ExportExcel("跨省结算报表", SettProvStatDetail.class).setDataList(page.getList()).write(response,fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/reports/SettProvStatDetail/?repage";
    }
	
	@RequiresPermissions("reports:SettProvStatDetail:view")
	@RequestMapping(value="settProvStatDetailProvReport")
	public String settProvStatDetailProvReport(SettProvStatDetail settProvStatDetail, Model model) {
		List<HashMap<String, String>> billOrgCodeList = settProvStatDetailService.findBillOrgCode(settProvStatDetail);
		List<HashMap<String, String>> issueOrgCodeList = settProvStatDetailService.findIssueOrgCode(settProvStatDetail);
		
		model.addAttribute("settProvStatDetail", settProvStatDetail);
		model.addAttribute("billOrgCodeList", billOrgCodeList);
		model.addAttribute("issueOrgCodeList", issueOrgCodeList);
		return "modules/reports/settProvStatDetailProvReport";
	}
	
	@RequiresPermissions("reports:SettProvStatDetail:view")
	@RequestMapping(value="settProvStatDetailCityReport")
	public String settProvStatDetailCityReport(SettProvStatDetail settProvStatDetail, Model model) {
		List<HashMap<String, String>> billOrgCodeList = settProvStatDetailService.findBillOrgCode(settProvStatDetail);
		List<HashMap<String, String>> issueOrgCodeList = settProvStatDetailService.findIssueOrgCode(settProvStatDetail);
		
		model.addAttribute("settProvStatDetail", settProvStatDetail);
		model.addAttribute("billOrgCodeList", billOrgCodeList);
		model.addAttribute("issueOrgCodeList", issueOrgCodeList);
		return "modules/reports/settProvStatDetailCityReport";
	}
	
	@RequestMapping(value="billCodeProvViewChart")
	@ResponseBody
	public List<SettProvStatDetail> billCodeProvViewChart(SettProvStatDetail settProvStatDetail,String settDate){
		settProvStatDetail.setSettDate(settDate);
		List<SettProvStatDetail> billCodeProvViewChartList = settProvStatDetailService.billCodeProvViewChart(settProvStatDetail);
		
		return billCodeProvViewChartList;
	}
	
	@RequestMapping(value="billCodeSumProvViewChart")
	@ResponseBody
	public List<SettProvStatDetail> billCodeSumViewChart(SettProvStatDetail settProvStatDetail,String settDate){
		settProvStatDetail.setSettDate(settDate);
		List<SettProvStatDetail> billCodeSumProvViewChartList = settProvStatDetailService.billCodeSumProvViewChart(settProvStatDetail);
		return billCodeSumProvViewChartList;
	}
	
	@RequestMapping(value="issueCodeProvViewChart")
	@ResponseBody
	public List<SettProvStatDetail> issueCodeProvViewChart(SettProvStatDetail settProvStatDetail,String settDate){
		settProvStatDetail.setSettDate(settDate);
		List<SettProvStatDetail>issueCodeProvViewChartList = settProvStatDetailService.issueCodeProvViewChart(settProvStatDetail);
		
		return issueCodeProvViewChartList;
	}
	
	@RequestMapping(value="issueCodeProvLineChart")
	@ResponseBody
	public List<SettProvStatDetail> issueCodeProvLineChart(SettProvStatDetail settProvStatDetail,String settDate,String issueCode){
		settProvStatDetail.setSettDate(settDate);
		settProvStatDetail.setIssueCode(issueCode);
		List<SettProvStatDetail> issueCodeProvLineChartList = settProvStatDetailService.issueCodeProvLineChart(settProvStatDetail);
		
		return issueCodeProvLineChartList;
	}
	
	@RequestMapping(value="billCodeProvLineChart")
	@ResponseBody
	public List<SettProvStatDetail> billCodeProvLineChart(SettProvStatDetail settProvStatDetail,String settDate,String billCode){
		settProvStatDetail.setSettDate(settDate);
		settProvStatDetail.setBillCode(billCode);
		List<SettProvStatDetail> billCodeProvLineChartList = settProvStatDetailService.billCodeProvLineChart(settProvStatDetail);
		
		return billCodeProvLineChartList;
	}

}