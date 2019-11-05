package com.baizhi;

import com.baizhi.dao.AdminDao;
import com.baizhi.dao.BannerDao;
import com.baizhi.entity.Admin;
import com.baizhi.service.BannerService;
import org.apache.ibatis.session.RowBounds;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.UUID;

@SpringBootTest
class SpringbootCmfzApplicationTests {
    @Autowired
    private AdminDao adminDao;
    @Test
    void contextLoads() {
        Admin admin = new Admin();
        //adminDao.selectAll();
        List<Admin> list = adminDao.select(admin);
        System.out.println(list);

    }

    @Test
    void test(){
        Admin admin = new Admin();
       // admin.setUsername("uu");
        RowBounds rowBounds = new RowBounds(0,2);
        List<Admin> list = adminDao.selectByRowBounds(admin, rowBounds);
        for (Admin admin1 : list) {
            System.out.println(admin1);
        }
    }

    @Test
    void test2(){
        Admin admin = new Admin();
        admin.setId(UUID.randomUUID().toString());
        admin.setPassword("000");
        admin.setUsername("nn");
        int insert = adminDao.insert(admin);
        System.out.println(insert);

    }

    @Test
    void uu(){
        Admin admin = new Admin();
        admin.setId("2");
        //admin.setUsername("qqqqqqq");
        admin.setUsername("001");
        //int i = adminDao.updateByPrimaryKey(admin);

        int i1 = adminDao.updateByPrimaryKeySelective(admin);
        System.out.println(i1);
    }


    @Autowired
    private BannerService bannerService;
    @Autowired
    private BannerDao bannerDao;


}
