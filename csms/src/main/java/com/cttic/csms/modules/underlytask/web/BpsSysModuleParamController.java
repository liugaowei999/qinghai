package com.cttic.csms.modules.underlytask.web;

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
import com.cttic.csms.modules.underlytask.entity.BpsSysModuleParam;
import com.cttic.csms.modules.underlytask.service.BpsSysModuleParamService;

/**
 * 清分结算后台任务状态参数查询Controller
 * @author ambitious
 * @version 2016-11-14
 */
@Controller
@RequestMapping(value = "${adminPath}/underlytask/bpsSysModuleParam")
public class BpsSysModuleParamController extends BaseController {

	@Autowired
	private BpsSysModuleParamService bpsSysModuleParamService;
	
//	@ModelAttribute
//	public BpsSysModuleParam get(@RequestParam(required=false) String id) {
//		BpsSysModuleParam entity = null;
//		if (StringUtils.isNotBlank(id)){
//			entity = bpsSysModuleParamService.get(id);
//		}
//		if (entity == null){
//			entity = new BpsSysModuleParam();
//		}
//		return entity;
//	}
	
//	@ModelAttribute("bpsSysModuleParam")
//	public BpsSysModuleParam get(BpsSysModuleParam bpsSysModuleParam) {
//		// 根据联合主键（moduleId + sectionCode + paramCode）去查找实体
//		if (bpsSysModuleParam != null && bpsSysModuleParam.getModuleId() != null 
//				&& StringUtils.isNotBlank(bpsSysModuleParam.getSectionCode()) && StringUtils.isNotBlank(bpsSysModuleParam.getParamCode())){
//			bpsSysModuleParam = bpsSysModuleParamService.getUnionKey(bpsSysModuleParam);
//		}
//		if (bpsSysModuleParam == null){
//			bpsSysModuleParam = new BpsSysModuleParam();
//		}
//		return bpsSysModuleParam;
//	}
	
	@ModelAttribute
	public BpsSysModuleParam get(@RequestParam(required=false) Integer moduleId,  @RequestParam(required=false) String sectionCode,  
			@RequestParam(required=false) String paramCode) {
		BpsSysModuleParam entity = null;
		
		// 根据联合主键（moduleId + sectionCode + paramCode）去查找实体
		if (moduleId != null && StringUtils.isNotBlank(sectionCode) && StringUtils.isNotBlank(paramCode)) {
			entity = new BpsSysModuleParam();
			entity.setModuleId(moduleId);
			entity.setSectionCode(sectionCode);
			entity.setParamCode(paramCode);
			entity = bpsSysModuleParamService.getUnionKey(entity);
		}
		return entity == null ? new BpsSysModuleParam() : entity;
	}
	
	@RequiresPermissions("underlytask:bpsSysModuleParam:view")
	@RequestMapping(value = {"list", ""})
	public String list(BpsSysModuleParam bpsSysModuleParam, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BpsSysModuleParam> page = bpsSysModuleParamService.findPage(new Page<BpsSysModuleParam>(request, response), bpsSysModuleParam); 
		model.addAttribute("page", page);
		return "modules/underlytask/bpsSysModuleParamList";
	}

	@RequiresPermissions("underlytask:bpsSysModuleParam:view")
	@RequestMapping(value = "form")
	public String form(BpsSysModuleParam bpsSysModuleParam, Model model) {
		model.addAttribute("bpsSysModuleParam", bpsSysModuleParam);
		return "modules/underlytask/bpsSysModuleParamForm";
	}

	@RequiresPermissions("underlytask:bpsSysModuleParam:edit")
	@RequestMapping(value = "save")
	public String save(BpsSysModuleParam bpsSysModuleParam, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bpsSysModuleParam)){
			return form(bpsSysModuleParam, model);
		}
		bpsSysModuleParamService.save(bpsSysModuleParam);
		addMessage(redirectAttributes, "保存后台任务状态参数成功");
		return "redirect:"+Global.getAdminPath()+"/underlytask/bpsSysModuleParam/?repage";
	}

}