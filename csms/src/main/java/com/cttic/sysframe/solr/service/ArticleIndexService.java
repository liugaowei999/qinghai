package com.cttic.sysframe.solr.service;

import org.springframework.data.solr.core.query.result.HighlightPage;
import org.springframework.data.solr.repository.Highlight;
import com.cttic.sysframe.solr.repositories.ArticleDocument;
import com.thinkgem.jeesite.modules.cms.entity.Article;


public interface ArticleIndexService {
	public void add(Article article);
	public void update(Article article);
	public void delete(String id);
	
	@Highlight(prefix = "<b>", postfix = "</b>")
	public HighlightPage<ArticleDocument> hlsearch(String searchKey,int pageNo,int pageSize);
}
