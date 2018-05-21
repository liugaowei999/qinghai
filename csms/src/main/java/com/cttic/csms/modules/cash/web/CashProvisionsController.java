/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.csms.modules.cash.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.cttic.csms.modules.cash.entity.CashProvisions;
import com.cttic.csms.modules.cash.service.CashProvisionsService;

/**
 * 备付金开户Controller
 * @author wanglk
 * @version 2016-11-24
 */
@Controller
@RequestMapping(value = "${adminPath}/cash/cashProvisions")
public class CashProvisionsController extends BaseController {

	@Autowired
	private CashProvisionsService cashProvisionsService;
	@Autowired
	private SystemService systemService;
	
	@ModelAttribute
	public CashProvisions get(@RequestParam(required=false) String id) {
		CashProvisions entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cashProvisionsService.get(id);
		}
		if (entity == null){
			entity = new CashProvisions();
		}
		return entity;
	}
	
	@RequiresPermissions("cash:cashProvisions:view")
	@RequestMapping(value = {"list", ""})
	public String list(CashProvisions cashProvisions, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CashProvisions> page = cashProvisionsService.findPage(new Page<CashProvisions>(request, response), cashProvisions); 
		model.addAttribute("page", page);
		return "modules/cash/cashProvisionsList";
	}

	@RequiresPermissions("cash:cashProvisions:view")
	@RequestMapping(value = "form")
	public String form(CashProvisions cashProvisions, Model model) {
		model.addAttribute("cashProvisions", cashProvisions);
		return "modules/cash/cashProvisionsForm";
	}

	@RequiresPermissions("cash:cashProvisions:edit")
	@RequestMapping(value = "save")
	public String save(CashProvisions cashProvisions,String loginName,String newPassword, Model model, RedirectAttributes redirectAttributes) {
		 
		if (!beanValidator(model, cashProvisions)){
			return form(cashProvisions, model);
		}
		
		//新增
		if(StringUtils.isEmpty(cashProvisions.getId())){
			List<Role> roleList = new ArrayList<Role>();
			//记录user
			User user = cashProvisions.getUser();
			//备付金新增的用户角色暂定为2..................
			Role role = systemService.getRole("2"); 
			roleList.add(role);
			user.setRoleList(roleList);
			user.setLoginName(loginName);
			user.setPassword(SystemService.entryptPassword(newPassword));
			Office office = cashProvisions.getCompany();
			user.setCompany(office);
			user.setOffice(office);
			systemService.saveUser(user);
			cashProvisions.setUserId(user.getId());
			cashProvisions.setNeedPay(0.00);
			cashProvisions.setWithdrawDeposite(0.00);
			cashProvisions.setTotalAmount(cashProvisions.getDeposite()+cashProvisions.getRemainingSum());
		}
		
		cashProvisionsService.save(cashProvisions);
		
		addMessage(redirectAttributes, "保存记录成功");
		return "redirect:"+Global.getAdminPath()+"/cash/cashProvisions/?repage";
	}
	
	@RequiresPermissions("cash:cashProvisions:edit")
	@RequestMapping(value = "delete")
	public String delete(CashProvisions cashProvisions, RedirectAttributes redirectAttributes) {
		cashProvisionsService.delete(cashProvisions);
		User user =new User(cashProvisions.getUserId());
		systemService.deleteUser(user);
		addMessage(redirectAttributes, "删除记录成功");
		return "redirect:"+Global.getAdminPath()+"/cash/cashProvisions/?repage";
	}
	
	/**
	 * 验证登录名是否有效
	 * @param oldLoginName
	 * @param loginName
	 * @return
	 */
	@ResponseBody
	@RequiresPermissions("cash:cashProvisions:edit")
	@RequestMapping(value = "checkLoginName")
	public String checkLoginName(String loginName) {
		if (loginName !=null && systemService.getUserByLoginName(loginName) == null) {
			return "true";
		}
		return "false";
	}
	
}