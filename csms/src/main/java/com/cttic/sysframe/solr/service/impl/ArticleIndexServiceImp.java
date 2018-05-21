package com.cttic.sysframe.solr.service.impl;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.solr.core.SolrTemplate;
import org.springframework.data.solr.core.query.Criteria;
import org.springframework.data.solr.core.query.HighlightOptions;
import org.springframework.data.solr.core.query.HighlightOptions.HighlightParameter;
import org.springframework.data.solr.core.query.Query;
import org.springframework.data.solr.core.query.SimpleHighlightQuery;
import org.springframework.data.solr.core.query.SimpleQuery;
import org.springframework.data.solr.core.query.result.HighlightPage;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.cttic.sysframe.solr.repositories.ArticleDocument;
import com.cttic.sysframe.solr.repositories.ArticleDocumentRepository;
import com.cttic.sysframe.solr.service.ArticleIndexService;
import com.thinkgem.jeesite.modules.cms.entity.Article;

@Service
public class ArticleIndexServiceImp implements ArticleIndexService {

	 @Resource
	 private ArticleDocumentRepository repository;
	 @Resource
	 private SolrTemplate solrTemplate;
	
	 private Logger log = Logger.getLogger(ArticleIndexServiceImp.class);



	@Async
	@Override
	public void add(Article article) {
		ArticleDocument doc = ArticleDocument.getBuilder().build(article);
		repository.save(doc);
	}


	@Async
	@Override
	public void update(Article article) {
		//查出旧的对象
		ArticleDocument olddoc = repository.findOne(article.getId());
		if(olddoc==null){
			log.warn("更新时根据ID找不到记录,直接新增,id:"+article.getId());
			add(article);
		}else{
			delete(article.getId());
			add(article);
		}
	}


	@Async
	@Override
	public void delete(String id) {
		if(id!=null){
			repository.delete(id);
		}
	}


	/**
	 * 高亮查询
	 * @param searchKey 查询关键词
	 * @param pageNo 页码 从1开始
	 * @param pageSize 每页显示多少条数据
	 * @return
	 */
	@Override
	public HighlightPage<ArticleDocument> hlsearch(String searchKey, int pageNo,int pageSize) {
		Criteria conditions = null;
		HighlightPage<ArticleDocument> results = null;
		if(StringUtils.isNotBlank(searchKey)){
			conditions = this.createSearchConditions(searchKey);
		}
		if(pageNo>=1){
			pageNo -= 1;
		}else{
			pageNo = 0;
		}
		if(pageSize<0){
			pageSize = 10;
		}
		if(conditions!=null){
			SimpleHighlightQuery query = new SimpleHighlightQuery(conditions);
			//query.addCriteria(conditions);
			Pageable pageRequest = new PageRequest(pageNo,pageSize);  
			query.setPageRequest(pageRequest);
			HighlightOptions highlightOptions =  new HighlightOptions();
			highlightOptions.addField("content","title","description","keywords");
			highlightOptions.addHighlightParameter("hl.simple.pre", "<b><font color=\"red\">");
			highlightOptions.addHighlightParameter("hl.simple.post", "</font></b>");
			query.setHighlightOptions(highlightOptions);
			results = this.solrTemplate.queryForHighlightPage(query, ArticleDocument.class);
			
		}
		return results;
	}
	
	 private Criteria createSearchConditions(String searchTerm ) {
	        Criteria conditions = null;
	        String[] words = StringUtils.split(searchTerm);
	        for (String word: words) {
	            if (conditions == null) {
	                conditions = new Criteria("all").contains(word);
	            }
	            else {
	                conditions = conditions.and(new Criteria("all").contains(word));
	            }
	        }
	        return conditions;
	    }

}
