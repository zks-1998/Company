package com.qau.service;

import com.qau.dao.UserMapper;
import com.qau.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;

   public User selectUser(String id,String pwd){
       return userMapper.selectUser(id,pwd);
   }
   public String selectId(String id){
       return userMapper.selectId(id);
   }
   public String selectPwd(String id){
       return userMapper.selectPwd(id);
   }
   public int insertUser(User user){
       return userMapper.insertUser(user);
   }
}
