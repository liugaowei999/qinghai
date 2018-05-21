/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cttic.sysframe.nginx.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cttic.sysframe.utils.HttpRequestUtil;
import com.cttic.sysframe.utils.PropertiesUtil;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.cms.entity.Article;
import com.thinkgem.jeesite.modules.cms.entity.Category;
import com.thinkgem.jeesite.modules.cms.service.ArticleService;
import com.thinkgem.jeesite.modules.cms.service.CategoryService;
import com.thinkgem.jeesite.modules.sys.entity.Office;

/**
 * Nginx管理功能Controller
 * @author dener
 * @version 2016-12-06
 */
@Controller
@RequestMapping(value = "${adminPath}/nginx/nginx")
public class NginxController extends BaseController {

	@Autowired
	private ArticleService articleService;
	@Autowired
	private CategoryService categoryService;
	
	@RequiresPermissions("nginx:nginx:view")
	@RequestMapping(value = {"list", ""})
	public String list(Article article, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Article> page = articleService.findPage(new Page<Article>(request, response), article, true); 
        model.addAttribute("page", page);
		return "sysframe/nginx/nginxCacheRefresh";
	}
	@RequiresPermissions("nginx:nginx:refreshUrl")
	@RequestMapping(value = "refreshUrl")
	public String refreshUrl(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "sysframe/nginx/nginxCacheRefreshUrl"; 
	}
	/**
	 * 刷新单个nginx缓存信息
	 */
	@RequestMapping(value = "refreshInfo")
	public String refreshInfo(HttpServletRequest request, HttpServletResponse response, Model model) {
		String refreshId=(String)request.getParameter("refreshId");
		
		PropertiesUtil properties = new PropertiesUtil("sysframe.properties");
		String nginxServer=properties.readProperty("nginx_server");
		
		HttpRequestUtil.sendGetNotRes(nginxServer+refreshId, null);
		
		model.addAttribute("result", "刷新成功！");
		return renderString(response,model);
	}
	/**
	 * 刷新所有nginx缓存信息
	 */
	@RequestMapping(value = "refreshAll")
	public String refreshAll(HttpServletRequest request, HttpServletResponse response, Model model) {
		String refreshId="";
		
		PropertiesUtil properties = new PropertiesUtil("sysframe.properties");
		String nginxServer=properties.readProperty("nginx_server");
		
		//1.刷新目录
		Category categoryQry = new Category();
		List<Category>  categoryList= categoryService.findList(categoryQry);
		if(categoryList!=null && categoryList.size()>0){
			for(Category category:categoryList){
				// http://localhost:8080/csms/f/list-18.html 
				refreshId="csms/f/list-"+category.getId()+".html";
				HttpRequestUtil.sendGetNotRes(nginxServer+refreshId, null);
			}
		}
		//2.刷新文章
		Article articleQry = new Article();
		List<Article>  articleList= articleService.findList(articleQry);
		if(articleList!=null && articleList.size()>0){
			for(Article article:articleList){
				// http://localhost:8080/csms/f/view-3-2.html 
				refreshId="csms/f/view-"+article.getCategory().getId()+"-"+article.getId()+".html";
				HttpRequestUtil.sendGetNotRes(nginxServer+refreshId, null);
			}
		}
		model.addAttribute("result", "刷新成功！");
		return renderString(response,model);
	}
}