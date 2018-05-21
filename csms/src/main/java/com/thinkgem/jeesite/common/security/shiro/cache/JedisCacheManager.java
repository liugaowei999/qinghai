/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.common.security.shiro.cache;

import java.util.Collection;
import java.util.Collections;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.apache.shiro.cache.CacheManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import redis.clients.jedis.Jedis;

import com.google.common.collect.Sets;
import com.thinkgem.jeesite.common.utils.JedisUtils;
import com.thinkgem.jeesite.common.web.Servlets;

/**
 * 自定义授权缓存管理类
 * @author ThinkGem
 * @version 2014-7-20
 */
public class JedisCacheManager implements CacheManager {

	private String cacheKeyPrefix = "shiro_cache_";
	
	@Override
	public <K, V> Cache<K, V> getCache(String name) throws CacheException {
		return new JedisCache<K, V>(cacheKeyPrefix + name);
	}

	public String getCacheKeyPrefix() {
		return cacheKeyPrefix;
	}

	public void setCacheKeyPrefix(String cacheKeyPrefix) {
		this.cacheKeyPrefix = cacheKeyPrefix;
	}
	
	/**
	 * 自定义授权缓存管理类
	 * @author ThinkGem
	 * @version 2014-7-20
	 */
	public class JedisCache<K, V> implements Cache<K, V> {

		private Logger logger = LoggerFactory.getLogger(getClass());

		private String cacheKeyName = null;

		public JedisCache(String cacheKeyName) {
			this.cacheKeyName = cacheKeyName;
//			if (!JedisUtils.exists(cacheKeyName)){
//				Map<String, Object> map = Maps.newHashMap();
//				JedisUtils.setObjectMap(cacheKeyName, map, 60 * 60 * 24);
//			}
//			logger.debug("Init: cacheKeyName {} ", cacheKeyName);
		}
		
		@SuppressWarnings("unchecked")
		@Override
		public V get(K key) throws CacheException {
			if (key == null){
				return null;
			}
			
			V v = null;
			//////////////////注释掉坑爹的代码//////////////////////////
			HttpServletRequest request = Servlets.getRequest();
			/*
			if (request != null){
				v = (V)request.getAttribute(cacheKeyName);
				if (v != null){
					return v;
				}
			}*/
			
			V value = null;
			try {
				value = (V)JedisUtils.mapGet(cacheKeyName,key);
				logger.debug("get {} {} {}", cacheKeyName, key, request != null ? request.getRequestURI() : "");
			} catch (Exception e) {
				logger.error("get {} {} {}", cacheKeyName, key, request != null ? request.getRequestURI() : "", e);
			} 
			
			/*
			if (request != null && value != null){
				request.setAttribute(cacheKeyName, value);
			}
			*/
			
			return value;
		}

		@Override
		public V put(K key, V value) throws CacheException {
			if (key == null){
				return null;
			}
			
			try {
				JedisUtils.mapPut(cacheKeyName, key, value);
				logger.debug("put {} {} = {}", cacheKeyName, key, value);
			} catch (Exception e) {
				logger.error("put {} {}", cacheKeyName, key, e);
			} 
			return value;
		}

		@SuppressWarnings("unchecked")
		@Override
		public V remove(K key) throws CacheException {
			V value = null;
			try {
				value = (V)JedisUtils.mapGet(cacheKeyName, key);
				JedisUtils.mapRemove(cacheKeyName, key);
				logger.debug("remove {} {}", cacheKeyName, key);
			} catch (Exception e) {
				logger.warn("remove {} {}", cacheKeyName, key, e);
			} 
			return value;
		}

		@Override
		public void clear() throws CacheException {
			try {
				JedisUtils.del(cacheKeyName);
				logger.debug("clear {}", cacheKeyName);
			} catch (Exception e) {
				logger.error("clear {}", cacheKeyName, e);
			} 
		}

		@Override
		public int size() {
			int size = 0;
			try {
				size = JedisUtils.mapSize(cacheKeyName);
				logger.debug("size {} {} ", cacheKeyName, size);
				return size;
			} catch (Exception e) {
				logger.error("clear {}",  cacheKeyName, e);
			} 
			return size;
		}

		@SuppressWarnings("unchecked")
		@Override
		public Set<K> keys() {
			Set<K> keys = Sets.newHashSet();
			try {
				Set set = JedisUtils.mapKeySet(cacheKeyName);
				for(Object key : set){
					Object obj = (K)key;
					if (obj != null){
						keys.add((K) obj);
					}
	        	}
				logger.debug("keys {} {} ", cacheKeyName, keys);
				return keys;
			} catch (Exception e) {
				logger.error("keys {}", cacheKeyName, e);
			} 
			return keys;
		}

		@SuppressWarnings("unchecked")
		@Override
		public Collection<V> values() {
			Collection<V> vals = Collections.emptyList();;
			
			try {
				Collection col = JedisUtils.mapValues(cacheKeyName);
				for(Object val : col){
					if (val != null){
						vals.add((V) val);
					}
	        	}
				logger.debug("values {} {} ", cacheKeyName, vals);
				return vals;
			} catch (Exception e) {
				logger.error("values {}",  cacheKeyName, e);
			} 
			return vals;
		}
	}
}
