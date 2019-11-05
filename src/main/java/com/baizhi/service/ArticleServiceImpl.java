package com.baizhi.service;

import com.baizhi.dao.ArticleDao;
import com.baizhi.entity.Article;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;


@Service
@Transactional
public class ArticleServiceImpl implements  ArticleService {


    @Autowired
    private ArticleDao articleDao;
    @Override
    public HashMap<Object, Object> selectAll(Integer page, Integer rows) {
        Article article = new Article();
        RowBounds rowBounds = new RowBounds((page - 1) * rows, rows);
        List<Article> list1 = articleDao.selectByRowBounds(article, rowBounds);
        int count1 = articleDao.selectCount(article);
        HashMap<Object, Object> map = new HashMap<>();
        map.put("page",page);
        map.put("rows",list1);
        map.put("total",count1%rows==0?count1/rows:count1/rows+1);
        map.put("records",count1);
        return map;
    }

    @Override
    public String add(Article article) {
       article.setId(UUID.randomUUID().toString());
       article.setCreateDate(new Date());
        int i = articleDao.insertSelective(article);
        if(i == 0){
            throw new RuntimeException("添加有误请重试！");
        }
        return article.getId();
    }

    @Override
    public void edit(Article article) {
        System.out.println(article);
        articleDao.updateByPrimaryKeySelective(article);
    }

    @Override
    public void del(String id) {
       articleDao.deleteByPrimaryKey(id);

    }


}
