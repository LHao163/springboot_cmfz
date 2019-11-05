package com.baizhi.service;

import com.baizhi.entity.Star;

import java.util.HashMap;
import java.util.List;

public interface StarService {

    HashMap<Object, Object> selectAll(Integer page, Integer rows);
    String add(Star star);
    void edit(Star star);


    List<Star> findAll();
}
