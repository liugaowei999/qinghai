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

import freemarker.core.ReturnInstruction.Return;

import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.cttic.csms.common.utils.ArithmeticUtils;
import com.cttic.csms.modules.reports.entity.SettProvStatDetail;
import com.cttic.csms.modules.reports.entity.SettStatReport;
import com.cttic.csms.modules.reports.service.SettStatReportService;

/**
 * 结算报表展示Controller
 * @author wanglk
 * @version 2016-12-21
 */
@Controller
@RequestMapping(value = "${adminPath}/reports/settStatReport")
public class SettStatReportController extends BaseController {

	@Autowired
	private SettStatReportService settStatReportService;
	
	@ModelAttribute
	public SettStatReport get(@RequestParam(required=false) String id) {
		SettStatReport entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = settStatReportService.get(id);
		}
		if (entity == null){
			entity = new SettStatReport();
		}
		return entity;
	}
	
	@RequiresPermissions("reports:settStatReport:view")
	@RequestMapping(value = {"list", ""})
	public String list(SettStatReport settStatReport, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isEmpty(settStatReport.getBeginSettDate())&&StringUtils.isEmpty(settStatReport.getEndSettDate())){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			settStatReport.setBeginSettDate(sdf.format(calendar.getTime()));
			calendar.set(Calendar.DAY_OF_MONTH,calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
			settStatReport.setEndSettDate(sdf.format(calendar.getTime()));
		}
		
		Page<SettStatReport> page = settStatReportService.findPage(new Page<SettStatReport>(request, response), settStatReport); 
		SettStatReport settStatReportSum = new SettStatReport();
        String settType= settStatReport.getSettType();
		if(settType.equals("01")){
			 settStatReportService.settStatReportOutProvSum(settStatReportSum);
		}else{
			settStatReportService.settStatReportInProvSum(settStatReportSum);
		}
		 if(settStatReportSum!=null){
         	settStatReportSum.setSettDate("合计：");
 			page.getList().add(settStatReportSum);
 		}
		model.addAttribute("page", page);
		return "modules/reports/settCityStatReportList";
	}
	
	/**
	 * 导出报表
	 * @param settStatReport
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("reports:settStatReport:view")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(SettStatReport settStatReport, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName;
			if(StringUtils.isEmpty(settStatReport.getBeginSettDate())||StringUtils.isEmpty(settStatReport.getEndSettDate())){
				fileName ="结算报表.xlsx";
			}
			else{
				fileName ="结算报表"+"("+settStatReport.getBeginSettDate()+"-"+settStatReport.getEndSettDate()+").xlsx";
			}
            
            Page<SettStatReport> page = settStatReportService.findPage(new Page<SettStatReport>(request, response), settStatReport); 
            SettStatReport settStatReportSum = new SettStatReport();
            String settType= settStatReport.getSettType();
    		if(settType.equals("01")){
    			settStatReportSum = settStatReportService.settStatReportOutProvSum(settStatReport);
    		}else{
    			settStatReportSum = settStatReportService.settStatReportInProvSum(settStatReport);
    		}
           
    		/*double incomeSum=0.0;
    		double outcomeSum=0.0;
    		double offSetSum=0.0;
    		for(SettStatReport sr:page.getList()){
    			incomeSum=ArithmeticUtils.add(incomeSum,sr.getIncomeCharge());
    			outcomeSum=ArithmeticUtils.add(outcomeSum,sr.getOutcomeCharge());
    			offSetSum=ArithmeticUtils.add(offSetSum,sr.getOffsetBalance());
    		}
    		SettStatReport sum = new SettStatReport();
    		sum.setSettDate("合计：");
    		sum.setIncomeCharge(incomeSum);
    		sum.setOutcomeCharge(outcomeSum);
    		sum.setOffsetBalance(offSetSum);*/
            if(settStatReportSum!=null){
            	settStatReportSum.setSettDate("合计：");
    			page.getList().add(settStatReportSum);
    		}
    		
            new ExportExcel("结算报表", SettStatReport.class).setDataList(page.getList()).write(response,fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/reports/settStatReport/?repage";
    }
	
	@RequestMapping(value="orgCodeViewChart")
	@ResponseBody
	public List<SettStatReport> orgCodeViewChart(SettStatReport settStatReport,String settDate,String settType){
		settStatReport.setSettDate(settDate);
		settStatReport.setSettType(settType);
		List<SettStatReport> orgCodeViewChartList = settStatReportService.orgCodeViewChart(settStatReport);
		
		return orgCodeViewChartList;
	}
	
	@RequestMapping(value="orgCodeSumViewChart")
	@ResponseBody
	public List<SettStatReport> orgCodeSumViewChart(SettStatReport settStatReport,String settDate,String settType){
		settStatReport.setSettDate(settDate);
		settStatReport.setSettType(settType);
		List<SettStatReport> orgCodeSumViewChartList = settStatReportService.orgCodeSumViewChart(settStatReport);
		
		return orgCodeSumViewChartList;
	}
	
	@RequestMapping(value="settTypeViewChart")
	@ResponseBody
	public List<SettStatReport> settTypeViewChart(SettStatReport settStatReport,String settDate){
		settStatReport.setSettDate(settDate);
		List<SettStatReport> settTypeViewChartList = settStatReportService.settTypeViewChart(settStatReport);
		
		return settTypeViewChartList;
	}
	
	@RequestMapping(value="settTypeLineChart")
	@ResponseBody
	public List<SettStatReport> settTypeLineChart(SettStatReport settStatReport,String settDate,String settType){
		settStatReport.setSettDate(settDate);
		settStatReport.setSettType(settType);
		List<SettStatReport> stMViewChartList = settStatReportService.stMViewChart(settStatReport);
		
		return stMViewChartList;
	}
	
	@RequestMapping(value="orgCodeLineChart")
	@ResponseBody
	public List<SettStatReport> ocMViewChart(SettStatReport settStatReport,String settDate,String orgCode,String settType){
		settStatReport.setSettDate(settDate);
		settStatReport.setOrgCode(orgCode);
		settStatReport.setSettType(settType);
		List<SettStatReport> ocMViewChartList = settStatReportService.ocMViewChart(settStatReport);
		
		return ocMViewChartList;
	}
	
	@RequestMapping(value="settStatReportInProvList")
	public String settStatReportInProvList(SettStatReport settStatReport, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isEmpty(settStatReport.getBeginSettDate())&&StringUtils.isEmpty(settStatReport.getEndSettDate())){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			settStatReport.setBeginSettDate(sdf.format(calendar.getTime()));
			calendar.set(Calendar.DAY_OF_MONTH,calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
			settStatReport.setEndSettDate(sdf.format(calendar.getTime()));
		}
		
		Page<SettStatReport> page = settStatReportService.findPage(new Page<SettStatReport>(request, response), settStatReport); 
		
		SettStatReport settStatReportSum = settStatReportService.settStatReportInProvSum(settStatReport);
		
		 if(settStatReportSum!=null){
         	settStatReportSum.setSettDate("合计：");
 			page.getList().add(settStatReportSum);
 		}
		User  user= settStatReport.getCurrentUser();
		String dataScope="";
		for (Role role : user.getRoleList()){
			dataScope = role.getDataScope();
		}
		model.addAttribute("page", page);
		//model.addAttribute("dataScope", dataScope);
		return "modules/reports/settStatReportInProvList";
	}
	@RequestMapping(value="settStatReportOutProvList")
	public String settStatReportOutProvList(SettStatReport settStatReport, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isEmpty(settStatReport.getBeginSettDate())&&StringUtils.isEmpty(settStatReport.getEndSettDate())){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			settStatReport.setBeginSettDate(sdf.format(calendar.getTime()));
			calendar.set(Calendar.DAY_OF_MONTH,calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
			settStatReport.setEndSettDate(sdf.format(calendar.getTime()));
		}
		String settType = settStatReport.getSettType();
		if(settType==null||settType==""){
			settStatReport.setSettType("01");
		}
		Page<SettStatReport> page = settStatReportService.findPage(new Page<SettStatReport>(request, response), settStatReport); 
		
		SettStatReport settStatReportSum = settStatReportService.settStatReportOutProvSum(settStatReport);
		
		 if(settStatReportSum!=null){
         	settStatReportSum.setSettDate("合计：");
 			page.getList().add(settStatReportSum);
 		}
		model.addAttribute("page", page);
		return "modules/reports/settStatReportOutProvList";
	}
	
	@RequiresPermissions("reports:settStatReport:view")
	@RequestMapping(value = "settStatReportInProvChart")
	public String settStatReportInProvChart(SettStatReport settStatReport, Model model) {
		List<HashMap<String, String>> orgCodeList = settStatReportService.findOrgCodeList(settStatReport);
		List<HashMap<String, String>> settTypeList = settStatReportService.findSettTypeList(settStatReport);
		
		model.addAttribute("settStatReport", settStatReport);
		model.addAttribute("orgCodeList", orgCodeList);
		model.addAttribute("settTypeList", settTypeList);
		return "modules/reports/settStatReportInProvChart";
	}
	
	@RequiresPermissions("reports:settStatReport:view")
	@RequestMapping(value = "settStatReportInCityChart")
	public String settStatReportInCityChart(SettStatReport settStatReport, Model model) {
		List<HashMap<String, String>> settTypeList = settStatReportService.findSettTypeList(settStatReport);
		model.addAttribute("settStatReport", settStatReport);
		model.addAttribute("settTypeList", settTypeList);
		return "modules/reports/settStatReportInCityChart";
	}
	
	@RequestMapping(value="settStatReportOutProvChart")
	public String settStatReportOutProvChart(SettStatReport settStatReport, Model model){
		List<HashMap<String, String>> orgCodeList = settStatReportService.findOrgCodeList(settStatReport);
		model.addAttribute("settStatReport", settStatReport);
		model.addAttribute("orgCodeList", orgCodeList);
		return "modules/reports/settStatReportOutProvChart";
	}

	
}