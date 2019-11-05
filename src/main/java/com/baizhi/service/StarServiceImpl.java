package com.baizhi.service;

import com.baizhi.dao.StarDao;
import com.baizhi.entity.Star;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class StarServiceImpl implements StarService {

    @Autowired
    private StarDao starDao;
    @Override
    public HashMap<Object, Object> selectAll(Integer page, Integer rows) {

        Star star = new Star();
        RowBounds rowBounds = new RowBounds((page - 1) * rows, rows);
        List<Star> list1 = starDao.selectByRowBounds(star, rowBounds);
        int count1 = starDao.selectCount(star);
        HashMap<Object, Object> map = new HashMap<>();
        map.put("page",page);
        map.put("rows",list1);
        map.put("total",count1%rows==0?count1/rows:count1/rows+1);
        map.put("records",count1);
        return map;
    }

    @Override
    public String add(Star star) {
        star.setId(UUID.randomUUID().toString());
        int i = starDao.insertSelective(star);
        if(i == 0){
            throw new RuntimeException("添加有误请重试！");
        }
        return star.getId();
    }

    @Override
    public void edit(Star star) {
        if("".equals(star.getPhoto())){
            star.setPhoto(null);
        }
        try {
            starDao.updateByPrimaryKeySelective(star);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("修改失败请重试！");
        }
    }

    @Override
    public List<Star> findAll() {

        return starDao.selectAll();
    }
}
