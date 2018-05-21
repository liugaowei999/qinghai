/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.common.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import org.apache.commons.lang3.tuple.MutablePair;
import org.apache.commons.lang3.tuple.Pair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.core.RedisTemplate;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import com.thinkgem.jeesite.common.config.Global;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.Tuple;
import redis.clients.jedis.exceptions.JedisException;

/**
 * Jedis Cache 工具类
 * 
 * @author ThinkGem
 * @version 2014-6-29
 */
public class JedisUtils {

	private static Logger logger = LoggerFactory.getLogger(JedisUtils.class);
	
	//private static JedisPool jedisPool = SpringContextHolder.getBean(JedisPool.class);
	
	private static RedisTemplate redisTemplate = SpringContextHolder.getBean(RedisTemplate.class);
	

	public static final String KEY_PREFIX = Global.getConfig("redis.keyPrefix");
	
	/**
	 * 获取缓存
	 * @param key 键
	 * @return 值
	 */
	public static String get(String key) {
		Object obj = redisTemplate.opsForValue().get(key);
		if(obj==null){
			return null;
		}else{
			return obj.toString();
		}
	}
	
	/**
	 * 获取缓存
	 * @param key 键
	 * @return 值
	 */
	public static Object getObject(Object key) {
		
		return redisTemplate.opsForValue().get(key);
	}
	

	/**
	 * 设置缓存
	 * @param key 键
	 * @param value 值
	 * @param cacheSeconds 超时时间，0为不超时
	 * @return
	 */
	public static void setObject(Object key, Object value, int cacheSeconds) {
		redisTemplate.opsForValue().set(key, value, cacheSeconds, TimeUnit.SECONDS);
	}
	
	/**
	 * 获取List缓存
	 * @param key 键
	 * @return 值
	 */
	public static List<String> getList(String key) {
		return (List<String>)redisTemplate.opsForList().range(key, 0, -1);
	}
	
	/**
	 * 获取List缓存
	 * @param key 键
	 * @return 值
	 */
	public static List<Object> getObjectList(String key) {
		return redisTemplate.opsForList().range(key, 0, -1);
	}
	

	
	/**
	 * 设置List缓存
	 * @param key 键
	 * @param value 值
	 * @param cacheSeconds 超时时间，0为不超时
	 * @return
	 */
	public static long setList(Object key, List<Object> value, int cacheSeconds) {
		long result =  redisTemplate.opsForList().leftPushAll(key, value);
		if (cacheSeconds != 0) {
			redisTemplate.expire(key, cacheSeconds,TimeUnit.SECONDS);
		}
		return result;
	}
	

	/**
	 * 向List缓存中添加值
	 * @param key 键
	 * @param value 值
	 * @return
	 */
	public static long listAdd(Object key, Object... value) {
		return redisTemplate.opsForList().leftPush(key, value);
	}

	/**
	 * 获取缓存
	 * @param key 键
	 * @return 值
	 */
	public static Set<String> getSet(String key) {
		return (Set<String>)redisTemplate.opsForSet().members(key);
	}
	
	/**
	 * 获取缓存
	 * @param key 键
	 * @return 值
	 */
	public static Set<Object> getObjectSet(String key) {
		return redisTemplate.opsForSet().members(key);
	}
	

	
	/**
	 * 设置Set缓存
	 * @param key 键
	 * @param value 值
	 * @param cacheSeconds 超时时间，0为不超时
	 * @return
	 */
	public static void setSet(Object key, Set<Object> value, int cacheSeconds) {
		for(Object each:value){
			redisTemplate.opsForSet().add(key, each);
		}
		if (cacheSeconds != 0) {
			redisTemplate.expire(key, cacheSeconds,TimeUnit.SECONDS);
		}
	}
	

	/**
	 * 向Set缓存中添加值
	 * @param key 键
	 * @param value 值
	 * @return
	 */
	public static long setSetObjectAdd(Object key, Object... value) {
		return redisTemplate.opsForSet().add(key, value);
	}
	
	/**
	 * 获取Map缓存
	 * @param key 键
	 * @return 值
	 */
	public static Map<String, String> getMap(String key) {
		Map<String, String> entries = (Map<String, String>)redisTemplate.opsForHash().entries(key);
		return entries;
	}
	
	/**
	 * 获取Map缓存
	 * @param key 键
	 * @return 值
	 */
	public static Map<String, Object> getObjectMap(String key) {
		return (Map<String, Object>)redisTemplate.opsForHash().entries(key);
	}
	

	/**
	 * 设置Map缓存
	 * @param key 键
	 * @param value 值
	 * @param cacheSeconds 超时时间，0为不超时
	 * @return
	 */
	public static void setObjectMap(Object key, Map<Object, Object> value, int cacheSeconds) {
		redisTemplate.opsForHash().putAll(key, value);
		if (cacheSeconds != 0) {
			redisTemplate.expire(key, cacheSeconds,TimeUnit.SECONDS);
		}
	}
	
	/**
	 * 向Map缓存中添加值
	 * @param key 键
	 * @param value 值
	 * @return
	 */
	public static void mapPut(Object key, Map<Object, Object> value) {
		redisTemplate.opsForHash().putAll(key, value);
	}
	
	public static void mapPut(Object key, Object mkey,Object value) {
		redisTemplate.opsForHash().put(key, mkey, value);
	}
	
	
	public static int mapSize(Object key) {
		return redisTemplate.opsForHash().size(key).intValue();
	}
	

	public static Object mapGet(Object key,Object mKey){
		return redisTemplate.opsForHash().get(key, mKey);
	}
	
	public static Set mapKeySet(Object key){
		return redisTemplate.opsForHash().keys(key);
	}
	
	public static List mapValues(Object key){
		return redisTemplate.opsForHash().values(key);
	}

	/**
	 * 移除Map缓存中的值
	 * @param key 键
	 * @param value 值
	 * @return
	 */
	public static long mapRemove(Object key, Object mapKey) {
		return redisTemplate.opsForHash().delete(key, mapKey);
	}
	
	/**
	 * 判断Map缓存中的Key是否存在
	 * @param key 键
	 * @param value 值
	 * @return
	 */
	public static boolean mapExists(Object key, Object mapKey) {
		return redisTemplate.opsForHash().hasKey(key, mapKey);
	}
	
	
	/**
	 * 删除缓存
	 * @param key 键
	 * @return
	 */
	public static void del(Object key) {
		 redisTemplate.delete(key);
	}


	
	/**
	 * 缓存是否存在
	 * @param key 键
	 * @return
	 */
	public static boolean exists(Object key) {
		return redisTemplate.hasKey(key);
	}
	

	/**
     * 排序集合增加一定值
	 * @param key
	 * @return
	 */
	public static Double zincr(String key,String zkey,Double delta){
		return redisTemplate.opsForZSet().incrementScore(zkey, zkey, delta);
	}
	/**
     * 获取TopN
	 * @param key
	 * @return
	 */
	public static List<Pair<String,Double>> zgetTopN(String key,long n){
		Jedis jedis = null;
		Set<Tuple> result = null;
		long size = redisTemplate.opsForZSet().size(key);
		long end = size -1;
		long start = end -n+1;
		if(start<0){
			start = 0;
		}
		List<Pair<String,Double>> rsltList =  null;
		result = redisTemplate.opsForZSet().rangeWithScores(key, start, end);
		
		if(result!=null && result.size()>0){
			rsltList = new ArrayList<Pair<String,Double>>();
			for(Tuple tuple:result){
				Pair kv = new MutablePair<String,Double>(tuple.getElement(),tuple.getScore());
				rsltList.add(kv);
			}
		}
		return rsltList;
	}
	/**
     * 获取一个Key的具体值
	 * @param key
	 * @return
	 */
	public static Double zget(String key,String zkey){
		return redisTemplate.opsForZSet().score(key, zkey);
	}
	

}
