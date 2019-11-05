package com.baizhi.service;

import com.baizhi.entity.Album;

import java.util.HashMap;

public interface AlbumService {

    HashMap<Object, Object> selectAll(Integer page, Integer rows);
    String add(Album album);
    void edit(Album album);

    Album selectOne(String id);




}
