package com.baizhi.service;

import com.baizhi.entity.User;
import com.baizhi.entity.UserEchaters;

import java.util.List;
import java.util.Map;

public interface UserService {

    Map<String,Object> selectUsersByStarIdAll(Integer page, Integer rows, String starId);

    List<User> easyPoi();

    List<UserEchaters> findAll(String sex);
}
