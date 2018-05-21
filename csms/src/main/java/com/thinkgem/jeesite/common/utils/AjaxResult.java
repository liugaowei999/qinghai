package com.thinkgem.jeesite.common.utils;

import com.thinkgem.jeesite.common.mapper.JsonMapper;



public class AjaxResult {
	private int code;  
    private String message;  
    private Object data;  
  
    public static final AjaxResult SUCCESS = new AjaxResult(StatusCode.SUCCESS, "SUC");  
    public static final AjaxResult FAILURE = new AjaxResult(StatusCode.FAILURE, "FAIL");   
    
    public AjaxResult(){
    	
    }
  
    /** 
     * <pre> 
     * @param code 
     * @param message 
     * </pre> 
     */  
    public AjaxResult(int code, String message) {  
        this.code = code;  
        this.message = message;  
    }  
  
    /** 
     * <pre> 
     * @return the body 
     * </pre> 
     */  
    public Object getData() {  
        return data;  
    }  
  
    /** 
     * <pre> 
     * @return the code 
     * </pre> 
     */  
    public int getCode() {  
        return code;  
    }  
  
    /** 
     * <pre> 
     * @return the message 
     * </pre> 
     */  
    public String getMessage() {  
        return message;  
    }  
  
    /** 
     * <pre> 
     * @param body the body to set 
     * </pre> 
     */  
    public AjaxResult setData(Object data) {  
        this.data = data;  
        return this;  
    }  
  
    /** 
     * <pre> 
     * @param code the code to set 
     * </pre> 
     */  
    public AjaxResult setCode(int code) {  
        this.code = code;  
        return this;  
    }  
  
    /** 
     * <pre> 
     * @param message the message to set 
     * </pre> 
     */  
    public AjaxResult setMessage(String message) {  
        this.message = message;  
        return this;  
    }  
    
    public String  toJsonString(){
    	return JsonMapper.getInstance().toJson(this);
    }
  
}
