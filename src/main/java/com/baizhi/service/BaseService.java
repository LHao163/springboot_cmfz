package com.baizhi.service;

import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BaseService<T> {


    void  save(T t);    //添加
    void  update(T t);  //修改
    void  delete(String id);       //删除
    T find(String id);      //Id查询
    List<T> findAll();      //查询所有
    List<T> findByPage(@Param("start") Integer start, @Param("rows") Integer rows); //分页
    Long findTotalCouts();  //总页数

}
