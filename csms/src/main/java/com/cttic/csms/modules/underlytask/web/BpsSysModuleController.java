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
import com.cttic.csms.modules.underlytask.entity.BpsSysModule;
import com.cttic.csms.modules.underlytask.service.BpsSysModuleService;

/**
 * 对后台任务处理情况进行查询和修改Controller
 * @author ambitious
 * @version 2016-11-12
 */
@Controller
@RequestMapping(value = "${adminPath}/underlytask/bpsSysModule")
public class BpsSysModuleController extends BaseController {

	@Autowired
	private BpsSysModuleService bpsSysModuleService;
	
	@ModelAttribute
	public BpsSysModule get(@RequestParam(required=false) String id) {
		BpsSysModule entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bpsSysModuleService.get(id);
		}
		if (entity == null){
			entity = new BpsSysModule();
		}
		return entity;
	}
	
	@RequiresPermissions("underlytask:bpsSysModule:view")
	@RequestMapping(value = {"list", ""})
	public String list(BpsSysModule bpsSysModule, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BpsSysModule> page = bpsSysModuleService.findPage(new Page<BpsSysModule>(request, response), bpsSysModule); 
		model.addAttribute("page", page);
		return "modules/underlytask/bpsSysModuleList";
	}

	@RequiresPermissions("underlytask:bpsSysModule:view")
	@RequestMapping(value = "form")
	public String form(BpsSysModule bpsSysModule, Model model) {
		model.addAttribute("bpsSysModule", bpsSysModule);
		return "modules/underlytask/bpsSysModuleForm";
	}

	@RequiresPermissions("underlytask:bpsSysModule:edit")
	@RequestMapping(value = "save")
	public String save(BpsSysModule bpsSysModule, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bpsSysModule)){
			return form(bpsSysModule, model);
		}
		bpsSysModuleService.save(bpsSysModule);
		addMessage(redirectAttributes, "保存后台任务成功");
		return "redirect:"+Global.getAdminPath()+"/underlytask/bpsSysModule/?repage";
	}

}