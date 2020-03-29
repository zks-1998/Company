package com.qau.model;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用的返回的类
 */
public class Msg {
    //状态码 100-成功 200-失败
    private int code;
    //提示信息
    private String msg;
    //用户给浏览器返回的数据
    private Map<String,Object> extendn = new HashMap<String, Object>();

    public static Msg succcess(){
        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("处理成功!");
        return result;
    }
    public static  Msg fail(){
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("处理失败!");
        return result;
    }
    public Msg add(String key,Object value){
        this.getExtendn().put(key, value);
        return this;
    }
    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtendn() {
        return extendn;
    }

    public void setExtendn(Map<String, Object> extendn) {
        this.extendn = extendn;
    }
}
