/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.cms.web.front;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.formula.functions.T;
import org.jsoup.helper.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cttic.sysframe.utils.HttpRequestUtil;
import com.cttic.sysframe.utils.PropertiesUtil;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.servlet.ValidateCodeServlet;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.cms.entity.Article;
import com.thinkgem.jeesite.modules.cms.entity.Category;
import com.thinkgem.jeesite.modules.cms.entity.Comment;
import com.thinkgem.jeesite.modules.cms.entity.Link;
import com.thinkgem.jeesite.modules.cms.entity.Site;
import com.thinkgem.jeesite.modules.cms.service.ArticleDataService;
import com.thinkgem.jeesite.modules.cms.service.ArticleService;
import com.thinkgem.jeesite.modules.cms.service.CategoryService;
import com.thinkgem.jeesite.modules.cms.service.CommentService;
import com.thinkgem.jeesite.modules.cms.service.LinkService;
import com.thinkgem.jeesite.modules.cms.service.SiteService;
import com.thinkgem.jeesite.modules.cms.utils.CmsUtils;
import com.thinkgem.jeesite.modules.cms.utils.CollectionsSort;
import com.thinkgem.jeesite.modules.cms.utils.CollectionsSort.SortList;

/**
 * 网站Controller
 * @author ThinkGem
 * @version 2013-5-29
 */
@Controller
@RequestMapping(value = "${frontPath}")
public class FrontController extends BaseController{
	
	@Autowired
	private ArticleService articleService;
	@Autowired
	private ArticleDataService articleDataService;
	@Autowired
	private LinkService linkService;
	@Autowired
	private CommentService commentService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private SiteService siteService;
	
	/**
	 * 网站首页
	 */
	@RequestMapping
	public String index(Model model) {
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		model.addAttribute("isIndex", true);
		return "modules/cms/front/themes/"+site.getTheme()+"/frontIndex";
	}
	
	/**
	 * 网站首页
	 */
	@RequestMapping(value = "index-{siteId}${urlSuffix}")
	public String index(@PathVariable String siteId, Model model) {
		if (siteId.equals("1")){
			return "redirect:"+Global.getFrontPath();
		}
		Site site = CmsUtils.getSite(siteId);
		// 子站有独立页面，则显示独立页面
		if (StringUtils.isNotBlank(site.getCustomIndexView())){
			model.addAttribute("site", site);
			model.addAttribute("isIndex", true);
			return "modules/cms/front/themes/"+site.getTheme()+"/frontIndex"+site.getCustomIndexView();
		}
		// 否则显示子站第一个栏目
		List<Category> mainNavList = CmsUtils.getMainNavList(siteId);
		if (mainNavList.size() > 0){
			String firstCategoryId = CmsUtils.getMainNavList(siteId).get(0).getId();
			return "redirect:"+Global.getFrontPath()+"/list-"+firstCategoryId+Global.getUrlSuffix();
		}else{
			model.addAttribute("site", site);
			return "modules/cms/front/themes/"+site.getTheme()+"/frontListCategory";
		}
	}
	
	/**
	 * 内容列表
	 */
	@RequestMapping(value = "list-{categoryId}${urlSuffix}")
	public String list(@PathVariable String categoryId, @RequestParam(required=false, defaultValue="1") Integer pageNo,
			@RequestParam(required=false, defaultValue="15") Integer pageSize, Model model) {
		Category category = categoryService.get(categoryId);
		if (category==null){
			Site site = CmsUtils.getSite(Site.defaultSiteId());
			model.addAttribute("site", site);
			return "error/404";
		}
		Site site = siteService.get(category.getSite().getId());
		model.addAttribute("site", site);
		// 2：简介类栏目，栏目第一条内容
		if("2".equals(category.getShowModes()) && "article".equals(category.getModule())){
			// 如果没有子栏目，并父节点为跟节点的，栏目列表为当前栏目。
			List<Category> categoryList = Lists.newArrayList();
			if (category.getParent().getId().equals("1")){
				categoryList.add(category);
			}else{
				categoryList = categoryService.findByParentId(category.getParent().getId(), category.getSite().getId());
			}
			model.addAttribute("category", category);
			model.addAttribute("categoryList", categoryList);
			// 获取文章内容
			Page<Article> page = new Page<Article>(1, 1, -1);
			Article article = new Article(category);
			page = articleService.findPage(page, article, false);
			if (page.getList().size()>0){
				article = page.getList().get(0);
				article.setArticleData(articleDataService.get(article.getId()));
				articleService.updateHitsAddOne(article.getId());
			}
			model.addAttribute("article", article);
            CmsUtils.addViewConfigAttribute(model, category);
            CmsUtils.addViewConfigAttribute(model, article.getViewConfig());
//            System.out.println("======modules/cms/front/themes/"+site.getTheme()+"/"+getTpl(article));
			return "modules/cms/front/themes/"+site.getTheme()+"/"+getTpl(article);
		}else{
			List<Category> categoryList = categoryService.findByParentId(category.getId(), category.getSite().getId());
			// 展现方式为1 、无子栏目或公共模型，显示栏目内容列表
			if("1".equals(category.getShowModes())||categoryList.size()==0){
				// 有子栏目并展现方式为1，则获取第一个子栏目；无子栏目，则获取同级分类列表。
				if(categoryList.size()>0){
					category = categoryList.get(0);
				}else{
					// 如果没有子栏目，并父节点为跟节点的，栏目列表为当前栏目。
					if (category.getParent().getId().equals("1")){
						categoryList.add(category);
					}else{
						categoryList = categoryService.findByParentId(category.getParent().getId(), category.getSite().getId());
					}
				}
				model.addAttribute("category", category);
				model.addAttribute("categoryList", categoryList);
				// 获取内容列表
				if ("article".equals(category.getModule())){
					Map viewConfig = new HashMap();
					if(!StringUtils.isBlank(category.getViewConfig())){
						String[] configArray=category.getViewConfig().split(";");
						for(String config : configArray){
							if(!StringUtils.isBlank(config)){
								String[] configInfo = config.split(":");
								if(configInfo!=null && configInfo.length==2){
									viewConfig.put(configInfo[0], configInfo[1]);
								}
							}
						}
					}
					if(viewConfig.get("pageSize")!=null){
						if(!StringUtils.isBlank(viewConfig.get("pageSize").toString())){
							pageSize = Integer.valueOf(viewConfig.get("pageSize").toString());
						}
					}
					Page<Article> page = new Page<Article>(pageNo, pageSize);
					//System.out.println(page.getPageNo());
					page = articleService.findPage(page, new Article(category), false);
					if(viewConfig.get("articleType")!=null && "qa".equals(viewConfig.get("articleType").toString()) ){
						if(page!=null && page.getList()!=null && page.getList().size()>0){
							for(Article artcleTemp : page.getList()){
								artcleTemp.setArticleData(articleDataService.get(artcleTemp.getId()));
								String content=artcleTemp.getArticleData().getContent();
								content=this.removeHtml(content);
								if(content.length()>200){
									content=content.substring(0, 200);
									content=content+"...";
								}
								artcleTemp.getArticleData().setContent(content);
							}
						}
					}
					model.addAttribute("page", page);
					// 如果第一个子栏目为简介类栏目，则获取该栏目第一篇文章
					if ("2".equals(category.getShowModes())){
						Article article = new Article(category);
						if (page.getList().size()>0){
							article = page.getList().get(0);
							article.setArticleData(articleDataService.get(article.getId()));
							articleService.updateHitsAddOne(article.getId());
						}
						model.addAttribute("article", article);
			            CmsUtils.addViewConfigAttribute(model, category);
			            CmsUtils.addViewConfigAttribute(model, article.getViewConfig());
//			            System.out.println("======modules/cms/front/themes/"+site.getTheme()+"/"+getTpl(article));
						return "modules/cms/front/themes/"+site.getTheme()+"/"+getTpl(article);
					}
				}else if ("link".equals(category.getModule())){
					Page<Link> page = new Page<Link>(1, -1);
					page = linkService.findPage(page, new Link(category), false);
					model.addAttribute("page", page);
				}
				String view = "/frontList";
				if (StringUtils.isNotBlank(category.getCustomListView())){
					view = "/"+category.getCustomListView();
				}
	            CmsUtils.addViewConfigAttribute(model, category);
                site =siteService.get(category.getSite().getId());
                //System.out.println("else 栏目第一条内容 _2 :"+category.getSite().getTheme()+","+site.getTheme());
				return "modules/cms/front/themes/"+siteService.get(category.getSite().getId()).getTheme()+view;
				//return "modules/cms/front/themes/"+category.getSite().getTheme()+view;
			}
			// 有子栏目：显示子栏目列表
			else{
				model.addAttribute("category", category);
				model.addAttribute("categoryList", categoryList);
				String view = "/frontListCategory";
				if (StringUtils.isNotBlank(category.getCustomListView())){
					view = "/"+category.getCustomListView();
				}
	            CmsUtils.addViewConfigAttribute(model, category);
				return "modules/cms/front/themes/"+site.getTheme()+view;
			}
		}
	}

	/**
	 * 内容列表（通过url自定义视图）
	 */
	@RequestMapping(value = "listc-{categoryId}-{customView}${urlSuffix}")
	public String listCustom(@PathVariable String categoryId, @PathVariable String customView, @RequestParam(required=false, defaultValue="1") Integer pageNo,
			@RequestParam(required=false, defaultValue="15") Integer pageSize, Model model) {
		Category category = categoryService.get(categoryId);
		if (category==null){
			Site site = CmsUtils.getSite(Site.defaultSiteId());
			model.addAttribute("site", site);
			return "error/404";
		}
		Site site = siteService.get(category.getSite().getId());
		model.addAttribute("site", site);
		List<Category> categoryList = categoryService.findByParentId(category.getId(), category.getSite().getId());
		model.addAttribute("category", category);
		model.addAttribute("categoryList", categoryList);
        CmsUtils.addViewConfigAttribute(model, category);
		return "modules/cms/front/themes/"+site.getTheme()+"/frontListCategory"+customView;
	}

	/**
	 * 显示内容
	 */
	@RequestMapping(value = "view-{categoryId}-{contentId}${urlSuffix}")
	public String view(@PathVariable String categoryId, @PathVariable String contentId, Model model) {
		Category category = categoryService.get(categoryId);
		if (category==null){
			Site site = CmsUtils.getSite(Site.defaultSiteId());
			model.addAttribute("site", site);
			return "error/404";
		}
		model.addAttribute("site", category.getSite());
		if ("article".equals(category.getModule())){
			// 如果没有子栏目，并父节点为跟节点的，栏目列表为当前栏目。
			List<Category> categoryList = Lists.newArrayList();
			if (category.getParent().getId().equals("1")){
				categoryList.add(category);
			}else{
				categoryList = categoryService.findByParentId(category.getParent().getId(), category.getSite().getId());
			}
			// 获取文章内容
			Article article = articleService.get(contentId);
			if (article==null || !Article.DEL_FLAG_NORMAL.equals(article.getDelFlag())){
				return "error/404";
			}
			// 文章阅读次数+1
			articleService.updateHitsAddOne(contentId);
			// 获取推荐文章列表
			List<Object[]> relationList = articleService.findByIds(articleDataService.get(article.getId()).getRelation());
			// 将数据传递到视图
			model.addAttribute("category", categoryService.get(article.getCategory().getId()));
			model.addAttribute("categoryList", categoryList);
			article.setArticleData(articleDataService.get(article.getId()));
			model.addAttribute("article", article);
			model.addAttribute("relationList", relationList); 
            CmsUtils.addViewConfigAttribute(model, article.getCategory());
            CmsUtils.addViewConfigAttribute(model, article.getViewConfig());
            Site site = siteService.get(category.getSite().getId());
            model.addAttribute("site", site);
//			return "modules/cms/front/themes/"+category.getSite().getTheme()+"/"+getTpl(article);
            return "modules/cms/front/themes/"+site.getTheme()+"/"+getTpl(article);
		}
		return "error/404";
	}
	
	/**
	 * 内容评论
	 */
	@RequestMapping(value = "comment", method=RequestMethod.GET)
	public String comment(String theme, Comment comment, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Comment> page = new Page<Comment>(request, response);
		Comment c = new Comment();
		c.setCategory(comment.getCategory());
		c.setContentId(comment.getContentId());
		c.setDelFlag(Comment.DEL_FLAG_NORMAL);
		page = commentService.findPage(page, c);
		model.addAttribute("page", page);
		model.addAttribute("comment", comment);
		return "modules/cms/front/themes/"+theme+"/frontComment";
	}
	
	/**
	 * 内容评论保存
	 */
	@ResponseBody
	@RequestMapping(value = "comment", method=RequestMethod.POST)
	public String commentSave(Comment comment, String validateCode,@RequestParam(required=false) String replyId, HttpServletRequest request) {
		if (StringUtils.isNotBlank(validateCode)){
			if (ValidateCodeServlet.validate(request, validateCode)){
				if (StringUtils.isNotBlank(replyId)){
					Comment replyComment = commentService.get(replyId);
					if (replyComment != null){
						comment.setContent("<div class=\"reply\">"+replyComment.getName()+":<br/>"
								+replyComment.getContent()+"</div>"+comment.getContent());
					}
				}
				comment.setIp(request.getRemoteAddr());
				comment.setCreateDate(new Date());
				comment.setDelFlag(Comment.DEL_FLAG_AUDIT);
				commentService.save(comment);
				return "{result:1, message:'提交成功。'}";
			}else{
				return "{result:2, message:'验证码不正确。'}";
			}
		}else{
			return "{result:2, message:'验证码不能为空。'}";
		}
	}
	
	/**
	 * 站点地图
	 */
	@RequestMapping(value = "map-{siteId}${urlSuffix}")
	public String map(@PathVariable String siteId, Model model) {
		Site site = CmsUtils.getSite(siteId!=null?siteId:Site.defaultSiteId());
		model.addAttribute("site", site);
		return "modules/cms/front/themes/"+site.getTheme()+"/frontMap";
	}

    private String getTpl(Article article){
        if(StringUtils.isBlank(article.getCustomContentView())){
            String view = null;
            Category c = article.getCategory();
            boolean goon = true;
            do{
                if(StringUtils.isNotBlank(c.getCustomContentView())){
                    view = c.getCustomContentView();
                    goon = false;
                }else if(c.getParent() == null || c.getParent().isRoot()){
                    goon = false;
                }else{
                    c = c.getParent();
                }
            }while(goon);
            return StringUtils.isBlank(view) ? Article.DEFAULT_TEMPLATE : view;
        }else{
            return article.getCustomContentView();
        }
    }
    
	/**
	 * 文章数据获取
	 */
	@RequestMapping(value = "getArticleList")
	public String getArticleList(HttpServletRequest request, HttpServletResponse response, Model model) {
		String categoryId=(String)request.getParameter("categoryId");
		String pageNoStr = (String)request.getParameter("pageNo");
		String pageSizeStr = (String)request.getParameter("pageSize");
		String articleType = (String)request.getParameter("articleType");
		Integer pageNo= 1;
		if(!StringUtil.isBlank(pageNoStr)){
			pageNo= Integer.valueOf(pageNoStr);
		}
		Integer pageSize=15;
		if(!StringUtil.isBlank(pageSizeStr)){
			pageSize= Integer.valueOf(pageSizeStr);
		}
		Category category = categoryService.get(categoryId);
		Page<Article> page = new Page<Article>(pageNo, pageSize);
		page = articleService.findPage(page, new Article(category), false);
		List<Article> list =  page.getList();
		if(list==null && list.size()==0){
			list = new ArrayList<Article>();
		}
		//获取data
		for(Article article : list){
			article.setArticleData(articleDataService.get(article.getId()));
			if(!StringUtil.isBlank(articleType)&&"qa".equals(articleType)){
				String content=article.getArticleData().getContent();
				content = this.removeHtml(content);
				if(content.length()>55){
					content=content.substring(0, 54);
				}
				article.getArticleData().setContent(content);
			}
		}
		model.addAttribute("list", list);
		model.addAttribute("result", "suc");
		return renderString(response,model);
	}
	/**
	 * 链接数据获取
	 */
	@RequestMapping(value = "getLinkList")
	public String getLinkList(HttpServletRequest request, HttpServletResponse response, Model model) {
		String categoryId=(String)request.getParameter("categoryId");
		String pageNoStr = (String)request.getParameter("pageNo");
		String pageSizeStr = (String)request.getParameter("pageSize");
//		String linkType = (String)request.getParameter("linkType");
		Integer pageNo= 1;
		if(!StringUtil.isBlank(pageNoStr)){
			pageNo= Integer.valueOf(pageNoStr);
		}
		Integer pageSize=8;
		if(!StringUtil.isBlank(pageSizeStr)){
			pageSize= Integer.valueOf(pageSizeStr);
		}
		Category category = categoryService.get(categoryId);
		Page<Link> page = new Page<Link>(pageNo, pageSize);
		page = linkService.findPage(page, new Link(category), false);
		List<Link> list =  page.getList();
		if(list==null && list.size()==0){
			list = new ArrayList<Link>();
		}
		model.addAttribute("list", list);
		model.addAttribute("result", "suc");
		return renderString(response,model);
	}
	/**
	 * 获取轮播图片
	 */
	@RequestMapping(value = "getCarouselArticleList")
	public String getCarouselArticleList(HttpServletRequest request, HttpServletResponse response, Model model) {
		String categoryIds=(String)request.getParameter("categoryIds");
		String pageNoStr = (String)request.getParameter("pageNo");
		String pageSizeStr = (String)request.getParameter("pageSize");
		List<Article> articleList = this.getCarouselArticleList(categoryIds, pageNoStr, pageSizeStr);
		this.sort(articleList, "desc");
		model.addAttribute("list", articleList);
		model.addAttribute("result", "suc");
		return renderString(response,model);
	}
	public void sort(List<Article> list,  final String sort) {
		Collections.sort(list, new Comparator() {
			public int compare(Article a, Article b) {
				int ret = 0;
				try {
					if (sort != null && "desc".equals(sort))// 倒序
						ret = b.getUpdateDate().toString().compareTo(a.getUpdateDate().toString());
					else// 正序
						ret = a.getUpdateDate().toString().compareTo(b.getUpdateDate().toString());
				} catch (Exception ne) {
					System.out.println(ne);
				} 
				return ret;
			}
			@Override
			public int compare(Object o1, Object o2) {
				// TODO Auto-generated method stub
				return 0;
			}
		});
	}
	private List<Article> getCarouselArticleList(String categoryIds,String pageNoStr,String pageSizeStr){
		Integer pageNo= 1;
		if(!StringUtil.isBlank(pageNoStr)){
			pageNo= Integer.valueOf(pageNoStr);
		}
		Integer pageSize=5;
		if(!StringUtil.isBlank(pageSizeStr)){
			pageSize= Integer.valueOf(pageSizeStr);
		}
		List<Article> articleList = new ArrayList<Article>();
		if(!StringUtils.isBlank(categoryIds)){
			String[] categoryArray = categoryIds.split(",");
			List<String> posidList = new ArrayList<String>();
			posidList.add(",1,");
			posidList.add(",1,2,");
			for(String categoryId :categoryArray){
				Category category = categoryService.get(categoryId);
				Article article1 = new Article(category);
				article1.setPosid(",1,");
				Page<Article> page1= new Page<Article>(pageNo, pageSize);
				page1 = articleService.findPage(page1, article1, false);
				List<Article> list1 =  page1.getList();
				if(list1==null && list1.size()==0){
					list1 = new ArrayList<Article>();
				}else{
					for(Article articleTemp : list1) {
						articleList.add(articleTemp);
					}
				}
				
//				Article article2 = new Article(category);
//				article2.setPosid(",1,2,");
//				Page<Article> page2 = new Page<Article>(pageNo, pageSize);
//				page2 = articleService.findPage(page2, article2, false);
//				List<Article> list2 =  page2.getList();
//				if(list2==null && list2.size()==0){
//					list2 = new ArrayList<Article>();
//				}else{
//					for(Article articleTemp : list2) {
//						articleList.add(articleTemp);
//					}
//				}
			}
		}
		return articleList;
	}
	private String removeHtml(String htmlStr) {
		String regEx_html="<[^>]+>"; 
		Pattern p_html=Pattern.compile(regEx_html,Pattern.CASE_INSENSITIVE); 
		Matcher m_html=p_html.matcher(htmlStr); 
        htmlStr=m_html.replaceAll(""); 
        return htmlStr;
	}
}
