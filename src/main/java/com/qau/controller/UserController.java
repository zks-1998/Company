package com.qau.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.qau.model.User;
import com.qau.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
public class UserController {
    @Autowired
    private UserService userService;
    //跳转到首页
    @RequestMapping("/gofrist")
    public String goFrist(){
        return "index";
    }
    //跳转到列表页
    @RequestMapping("/goindex")
    public String goSuccess(String username,String password){
        User user = userService.selectUser(username, password);
        if(user!=null){
            return "list";
        }else
            return "index";
    }
    @RequestMapping("/userID")
    @ResponseBody
    public String selectUserId(String username){
        if(username.trim().length()==0){
            return "输账号呀";
        }else{
            String userid = userService.selectId(username);
            if(userid!=null){
                return "账号安全";
            }else
                return "该账号不存在";
        }
    }

    @RequestMapping("/userPWD")
    @ResponseBody
    public String selectUserPwd(String username,String password){
        if(userService.selectPwd(username).equals(password)){
            return "密码正确";
        }else if(password.trim().length()==0){
            return "密码不能为空";
        }else {
            return "密码错误";
        }
    }

    @RequestMapping("/checkuser.do")
    @ResponseBody
    public String checkUserName(String username){
        Map<String, Boolean> map = new HashMap<String, Boolean>();
        String userid = userService.selectId(username);
        if(userid!=null){
            map.put("valid", false);
        }else{
            map.put("valid",true);
        }
        ObjectMapper objectMapper = new ObjectMapper();
        String stringJson = null;
        try {
          stringJson = objectMapper.writeValueAsString(map);
        } catch (Exception e) {
           e.printStackTrace();
        }
        return stringJson;
    }


    @RequestMapping("/goreg")
    public String goReg(){
        return "reg";
    }

    @RequestMapping("/regsuccess")
    public String regsuccess(String username,String password){
        userService.insertUser(new User(username,password));
        return "index";
    }
}
