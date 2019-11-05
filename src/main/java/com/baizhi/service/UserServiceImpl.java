package com.baizhi.service;

import com.baizhi.dao.UserDao;
import com.baizhi.dao.UserDaoChaters;
import com.baizhi.entity.User;
import com.baizhi.entity.UserEchaters;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
@Transactional
public class UserServiceImpl  implements  UserService{

    @Autowired
    private UserDao userDao;

    @Autowired
    private UserDaoChaters userDaoChaters;

    @Override
    public Map<String, Object> selectUsersByStarIdAll(Integer page, Integer rows, String starId) {
        User user = new User();
        user.setStarId(starId);
        RowBounds rowBounds = new RowBounds((page - 1) * rows, rows);
        List<User> list = userDao.selectByRowBounds(user, rowBounds);
        int count = userDao.selectCount(user);
        Map<String, Object> map = new HashMap<>();
        map.put("page",page);
        map.put("rows",list);
        map.put("total",count%rows==0?count/rows:count/rows+1);
        map.put("records",count);
        return map;
    }

    @Override
    public List<User> easyPoi() {
        return userDao.selectAll();
    }

    @Override
    public List<UserEchaters> findAll(String sex) {
        List<UserEchaters> list = userDaoChaters.findAll(sex);
        return list;
    }


}
