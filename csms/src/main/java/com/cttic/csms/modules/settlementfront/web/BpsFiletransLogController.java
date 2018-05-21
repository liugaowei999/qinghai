/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.settlementfront.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cttic.csms.modules.settlementfront.entity.BpsFiletransLog;
import com.cttic.csms.modules.settlementfront.service.BpsFiletransLogService;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;

/**
 * 外围系统接口传输信息记录Controller
 * @author aryo
 * @version 2016-12-23
 */
@Controller
@RequestMapping(value = "${adminPath}/settlementfront/bpsFiletransLog")
public class BpsFiletransLogController extends BaseController {

	@Autowired
	private BpsFiletransLogService bpsFiletransLogService;
	
	/*@ModelAttribute
	public BpsFiletransLog get(@RequestParam(required=false) String id) {
		BpsFiletransLog entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bpsFiletransLogService.get(id);
		}
		if (entity == null){
			entity = new BpsFiletransLog();
		}
		return entity;
	}*/
	
	@RequiresPermissions("settlementfront:bpsFiletransLog:view")
	@RequestMapping(value = {"list", ""})
	public String list(BpsFiletransLog bpsFiletransLog, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BpsFiletransLog> page = bpsFiletransLogService.findPage(new Page<BpsFiletransLog>(request, response), bpsFiletransLog); 
		model.addAttribute("page", page);
		return "modules/settlementfront/bpsFiletransLogList";
	}

	/*@RequiresPermissions("settlementfront:bpsFiletransLog:view")
	@RequestMapping(value = "form")
	public String form(BpsFiletransLog bpsFiletransLog, Model model) {
		model.addAttribute("bpsFiletransLog", bpsFiletransLog);
		return "modules/settlementfront/bpsFiletransLogForm";
	}

	@RequiresPermissions("settlementfront:bpsFiletransLog:edit")
	@RequestMapping(value = "save")
	public String save(BpsFiletransLog bpsFiletransLog, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bpsFiletransLog)){
			return form(bpsFiletransLog, model);
		}
		bpsFiletransLogService.save(bpsFiletransLog);
		addMessage(redirectAttributes, "保存记录成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/bpsFiletransLog/?repage";
	}
	
	@RequiresPermissions("settlementfront:bpsFiletransLog:edit")
	@RequestMapping(value = "delete")
	public String delete(BpsFiletransLog bpsFiletransLog, RedirectAttributes redirectAttributes) {
		bpsFiletransLogService.delete(bpsFiletransLog);
		addMessage(redirectAttributes, "删除记录成功");
		return "redirect:"+Global.getAdminPath()+"/settlementfront/bpsFiletransLog/?repage";
	}*/

}