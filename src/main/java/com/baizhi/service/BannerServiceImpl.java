package com.baizhi.service;

import com.baizhi.dao.BannerDao;
import com.baizhi.entity.Banner;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.*;

@Service
@Transactional
public class BannerServiceImpl implements BannerService {

    @Autowired
    private BannerDao bannerDao;

    @Override
    public Map<String, Object> selectAll(Integer page, Integer rows) {
        Banner banner = new Banner();
        RowBounds rowBounds = new RowBounds((page-1)*rows,rows);
        List<Banner> list = bannerDao.selectByRowBounds(banner, rowBounds);
        int count = bannerDao.selectCount(banner);
        Map<String, Object> map = new HashMap<>();
        map.put("page",page);
        map.put("rows",list);
        map.put("total",count%rows==0?count/rows:count/rows+1);//总共有几页
        map.put("records",count);//总共有多少条数据

        return map;
    }

    @Override
    public String add(Banner banner) {
        banner.setId(UUID.randomUUID().toString());
        banner.setCreatedate(new Date());
        int i = bannerDao.insertSelective(banner);
        if(i == 0){
            throw new RuntimeException("添加有误请重试！");
        }
        return banner.getId();
    }

    @Override
    public void edit(Banner banner) {
        if("".equals(banner.getCover())){
            banner.setCover(null);
        }
        try {
            bannerDao.updateByPrimaryKeySelective(banner);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("修改失败请重试！");
        }
    }

    @Override
    public void del(String id, HttpServletRequest request) {
        Banner banner = bannerDao.selectByPrimaryKey(id);
        int i = bannerDao.deleteByPrimaryKey(id);
        if(i == 0){
            throw new RuntimeException("删除失败");
        }else{
            String cover = banner.getCover();
            File file = new File(request.getServletContext().getRealPath("/banner/img/"), cover);
            boolean boln = file.delete();
            if(boln == false){
                throw new RuntimeException("删除轮播图文件失败");
            }
        }
    }
}
