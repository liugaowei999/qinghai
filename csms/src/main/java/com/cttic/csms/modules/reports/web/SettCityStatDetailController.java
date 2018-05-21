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
import com.cttic.csms.modules.reports.entity.SettCityStatDetail;
import com.cttic.csms.modules.reports.service.SettCityStatDetailService;

/**
 * 省内结算报表展示Controller
 * @author wanglk
 * @version 2016-12-22
 */
@Controller
@RequestMapping(value = "${adminPath}/reports/settCityStatDetail")
public class SettCityStatDetailController extends BaseController {

	@Autowired
	private SettCityStatDetailService settCityStatDetailService;
	
	@ModelAttribute
	public SettCityStatDetail get(@RequestParam(required=false) String id) {
		SettCityStatDetail entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = settCityStatDetailService.get(id);
		}
		if (entity == null){
			entity = new SettCityStatDetail();
		}
		return entity;
	}
	
	@RequiresPermissions("reports:settCityStatDetail:view")
	@RequestMapping(value = {"list", ""})
	public String list(SettCityStatDetail settCityStatDetail, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		if(StringUtils.isEmpty(settCityStatDetail.getBeginSettDate())&&StringUtils.isEmpty(settCityStatDetail.getEndSettDate())){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			settCityStatDetail.setBeginSettDate(sdf.format(calendar.getTime()));
			calendar.set(Calendar.DAY_OF_MONTH,calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
			settCityStatDetail.setEndSettDate(sdf.format(calendar.getTime()));
		}
		
		Page<SettCityStatDetail> page = settCityStatDetailService.findPage(new Page<SettCityStatDetail>(request, response), settCityStatDetail); 
		SettCityStatDetail settCityStatDetailSum = settCityStatDetailService.settCityStatDetailSum(settCityStatDetail);
		
		List<String> billOrgNameList = new ArrayList<String>();
		List<String> issueOrgNameList = new ArrayList<String>();
		for(SettCityStatDetail ss:page.getList()){
			
			if(!StringUtils.isEmpty(ss.getBillOrgName())&&(!billOrgNameList.contains(ss.getBillOrgName()))){
				billOrgNameList.add(ss.getBillOrgName().trim());
			}
			if(!StringUtils.isEmpty(ss.getIssueOrgName())&&(!issueOrgNameList.contains(ss.getIssueOrgName()))){
				issueOrgNameList.add(ss.getIssueOrgName().trim());
			}
			
		}
		SettCityStatDetail sum = new SettCityStatDetail();
		if(settCityStatDetailSum!=null){
			settCityStatDetailSum.setSettDate("合计:");
			page.getList().add(settCityStatDetailSum);
		}
		
		User  user= settCityStatDetail.getCurrentUser();
		String dataScope="";
		for (Role role : user.getRoleList()){
			dataScope = role.getDataScope();
		}
		
		model.addAttribute("page", page);
		model.addAttribute("dataScope", dataScope);
		model.addAttribute("billOrgNameList", billOrgNameList);
		model.addAttribute("issueOrgNameList", issueOrgNameList);
		return "modules/reports/settCityStatDetailList";
	}

	
	
	/**
	 * 导出报表
	 * @param settCityStatDetail
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("reports:settCityStatDetail:view")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(SettCityStatDetail settCityStatDetail, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName;
			if(StringUtils.isEmpty(settCityStatDetail.getBeginSettDate())||StringUtils.isEmpty(settCityStatDetail.getEndSettDate())){
				fileName ="省内结算报表.xlsx";
			}
			else{
				fileName ="省内结算报表"+"("+settCityStatDetail.getBeginSettDate()+"-"+settCityStatDetail.getEndSettDate()+").xlsx";
			}
            
            Page<SettCityStatDetail> page = settCityStatDetailService.findPage(new Page<SettCityStatDetail>(request, response), settCityStatDetail); 
            SettCityStatDetail settCityStatDetailSum = settCityStatDetailService.settCityStatDetailSum(settCityStatDetail);
    		
    		if(settCityStatDetailSum!=null){
    			settCityStatDetailSum.setSettDate("合计:");
    			page.getList().add(settCityStatDetailSum);
    		}
            new ExportExcel("省内结算报表", SettCityStatDetail.class).setDataList(page.getList()).write(response,fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/reports/SettCityStatDetail/?repage";
    }
	@RequiresPermissions("reports:settCityStatDetail:view")
	@RequestMapping(value="settCityStatDetailProvReport")
	public String settCityStatDetailProvReport(SettCityStatDetail settCityStatDetail, Model model) {
		List<HashMap<String, String>> billOrgCodeList = settCityStatDetailService.findBillOrgCode(settCityStatDetail);
		List<HashMap<String, String>> issueOrgCodeList = settCityStatDetailService.findIssueOrgCode(settCityStatDetail);
		
		model.addAttribute("settProvStatDetail", settCityStatDetail);
		model.addAttribute("billOrgCodeList", billOrgCodeList);
		model.addAttribute("issueOrgCodeList", issueOrgCodeList);
		return "modules/reports/settCityStatDetailProvReport";
	}
	
	@RequiresPermissions("reports:settCityStatDetail:view")
	@RequestMapping(value="settCityStatDetailCityReport")
	public String settCityStatDetailCityReport(SettCityStatDetail settCityStatDetail, Model model) {
		List<HashMap<String, String>> billOrgCodeList = settCityStatDetailService.findBillOrgCode(settCityStatDetail);
		List<HashMap<String, String>> issueOrgCodeList = settCityStatDetailService.findIssueOrgCode(settCityStatDetail);
		
		model.addAttribute("settProvStatDetail", settCityStatDetail);
		model.addAttribute("billOrgCodeList", billOrgCodeList);
		model.addAttribute("issueOrgCodeList", issueOrgCodeList);
		return "modules/reports/settCityStatDetailCityReport";
	}
	
	@RequestMapping(value="billCodeViewChart")
	@ResponseBody
	public List<SettCityStatDetail> billCodeViewChart(SettCityStatDetail settCityStatDetail,String settDate){
		settCityStatDetail.setSettDate(settDate);
		List<SettCityStatDetail> billCodeViewChartList = settCityStatDetailService.billCodeViewChart(settCityStatDetail);
		
		return billCodeViewChartList;
	}
	
	@RequestMapping(value="billCodeSumViewChart")
	@ResponseBody
	public List<SettCityStatDetail> billCodeSumViewChart(SettCityStatDetail settCityStatDetail,String settDate){
		settCityStatDetail.setSettDate(settDate);
		List<SettCityStatDetail> billCodeSumViewChartList = settCityStatDetailService.billCodeSumViewChart(settCityStatDetail);
		return billCodeSumViewChartList;
	}
	
	@RequestMapping(value="issueCodeViewChart")
	@ResponseBody
	public List<SettCityStatDetail> issueCodeViewChart(SettCityStatDetail settCityStatDetail,String settDate){
		settCityStatDetail.setSettDate(settDate);
		List<SettCityStatDetail>issueCodeViewChartList = settCityStatDetailService.issueCodeViewChart(settCityStatDetail);
		
		return issueCodeViewChartList;
	}
	
	@RequestMapping(value="issueCodeLineChart")
	@ResponseBody
	public List<SettCityStatDetail> issueCodeLineChart(SettCityStatDetail settCityStatDetail,String settDate,String issueOrgName){
		settCityStatDetail.setSettDate(settDate);
		settCityStatDetail.setIssueOrgName(issueOrgName);;
		List<SettCityStatDetail> issueCodeLineChartList = settCityStatDetailService.issueCodeLineChart(settCityStatDetail);
		
		return issueCodeLineChartList;
	}
	
	@RequestMapping(value="billCodeLineChart")
	@ResponseBody
	public List<SettCityStatDetail> billCodeLineChart(SettCityStatDetail settCityStatDetail,String settDate,String billOrgName){
		settCityStatDetail.setSettDate(settDate);
		settCityStatDetail.setBillOrgName(billOrgName);
		List<SettCityStatDetail> billCodeLineChartList = settCityStatDetailService.billCodeLineChart(settCityStatDetail);
		
		return billCodeLineChartList;
	}

}