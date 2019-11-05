package com.baizhi.service;

import com.baizhi.entity.Article;

import java.util.HashMap;

public interface ArticleService {
    HashMap<Object, Object> selectAll(Integer page, Integer rows);

    String add(Article article);

    void edit(Article article);

    void del(String id);
}
