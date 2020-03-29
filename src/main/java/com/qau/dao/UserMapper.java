package com.qau.dao;

import com.qau.model.User;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {
    //判断用户账号密码是否正确登录验证
    User selectUser(@Param("userId") String userId, @Param("userPwd") String userPwd);
    //查询已经存在的UID
    String selectId(@Param("userId") String userId);
    //根据ID验证用户密码
    String selectPwd(@Param("userId") String userId);
    //插入新用户
    int insertUser(User user);
}
