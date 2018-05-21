package com.cttic.sysframe.solr.repositories;
import java.util.Date;

import org.apache.solr.client.solrj.beans.Field;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.annotation.Id;

import cn.edu.hfut.dmic.contentextractor.ContentExtractor;

import com.thinkgem.jeesite.modules.cms.entity.Article;

public class ArticleDocument {
	private static Logger logger = LoggerFactory.getLogger(ArticleDocument.class);
	///////文章实体
	@Id
	@Field
	private String id;
	//标题
	@Field
	private String title;
	//描述
	@Field
	private String description;
	//备注
	@Field
	private String remark;
	//作者
	@Field
	private String author;
	//关键字
	@Field
	private String keywords;
	@Field
	private String category;
	@Field
	private String categoryId;
	@Field
	private String url;
	@Field
	private Date updateDate;
	@Field
	private Date createDate;
	@Field
	private String link;
	@Field
	private String content;
	
	


	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public static Builder getBuilder() {
        return new Builder();
    }
	
	public static class Builder {
		
		public Builder() {}

		public ArticleDocument build( Article article ) {
			ArticleDocument doc = new ArticleDocument();
			doc.setId(article.getId());
			if(article.getCreateBy()!=null){
				doc.setAuthor(article.getCreateBy().getName());
			}
			if(article.getCategory()!=null){
				doc.setCategoryId(article.getCategory().getId());
				doc.setCategory(article.getCategory().getName());
			}
			if(article.getArticleData()!=null){
				//抽取网页正文
				String content = null;
				try {
					content = ContentExtractor.getContentByHtml(article.getArticleData().getContent());
					doc.setContent(content);
				} catch (Exception e) {
					logger.error("抽取网页正文失败", e);
				}
				
			}
			if(article.getDescription()!=null){
				doc.setDescription(article.getDescription());
			}
			if(article.getKeywords()!=null){
				doc.setKeywords(article.getKeywords());
			}
			doc.setCreateDate(article.getCreateDate());
			doc.setUpdateDate(article.getUpdateDate());
			if(article.getLink()!=null){
				doc.setLink(article.getLink());
			}
			if(article.getRemarks()!=null){
				doc.setRemark(article.getRemarks());
			}
			if(article.getTitle()!=null){
				doc.setTitle(article.getTitle());
			}
			if(article.getUrl()!=null){
				doc.setUrl(article.getUrl());
			}
			return doc;
		}
	}

}
