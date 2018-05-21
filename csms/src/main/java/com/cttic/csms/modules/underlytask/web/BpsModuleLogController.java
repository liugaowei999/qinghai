/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.underlytask.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cttic.csms.modules.underlytask.entity.BpsModuleLog;
import com.cttic.csms.modules.underlytask.service.BpsModuleLogService;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;

/**
 * 对日志表记录进行查询Controller
 * @author wanglk
 * @version 2016-11-12
 */
@Controller
@RequestMapping(value = "${adminPath}/underlytask/bpsModuleLog")
public class BpsModuleLogController extends BaseController {

	@Autowired
	private BpsModuleLogService bpsModuleLogService;
	
	@RequiresPermissions("underlytask:bpsModuleLog:view")
	@RequestMapping(value = {"list", ""})
	public String list(BpsModuleLog bpsModuleLog, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BpsModuleLog> page = bpsModuleLogService.findPage(new Page<BpsModuleLog>(request, response), bpsModuleLog); 
		model.addAttribute("page", page);
		return "modules/underlytask/bpsModuleLogList";
	}

}