package com.baizhi.dao;

import com.baizhi.entity.UserEchaters;

import java.util.List;

public interface UserDaoChaters {

    List<UserEchaters> findAll(String sex);

}
