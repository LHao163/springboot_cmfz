package com.baizhi.service;

import com.baizhi.dao.ChapterDao;
import com.baizhi.entity.Chapter;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@Transactional
public class ChapterServiceImpl implements  ChapterService {

    @Autowired
    private ChapterDao chapterDao;

    @Override
    public Map<String, Object> selectByAlbumIdAll(Integer page, Integer rows, String albumId) {

        Chapter chapter = new Chapter();
        chapter.setAlbumId(albumId);
        RowBounds rowBounds = new RowBounds((page - 1) * rows, rows);
        int count = chapterDao.selectCount(chapter);
        List<Chapter> list = chapterDao.selectByRowBounds(chapter, rowBounds);
        Map<String, Object> map = new HashMap<>();
        map.put("page",page);
        map.put("rows",list);
        map.put("total",count%rows==0?count/rows:count/rows+1);
        map.put("records",count);
        return map;
    }



    @Override
    public String add(Chapter chapter) {
        chapter.setId(UUID.randomUUID().toString());
        chapter.setCreateDate(new Date());
        int i = chapterDao.insertSelective(chapter);
        if(i == 0){
            throw new RuntimeException("添加有误请重试！");
        }
        return chapter.getId();
    }

    @Override
    public void edit(Chapter chapter) {
        if("".equals(chapter.getName())){
            chapter.setName(null);
        }
        try {
            chapterDao.updateByPrimaryKeySelective(chapter);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("修改失败请重试！");
        }
    }



}
