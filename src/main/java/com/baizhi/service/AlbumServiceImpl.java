package com.baizhi.service;

import com.baizhi.dao.AlbumDao;
import com.baizhi.dao.StarDao;
import com.baizhi.entity.Album;
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
public class AlbumServiceImpl implements AlbumService {

    @Autowired
    private AlbumDao albumDao;
    @Autowired
    private StarDao starDao;

    @Override
    public HashMap<Object, Object> selectAll(Integer page, Integer rows) {
        Album album = new Album();
        RowBounds rowBounds = new RowBounds((page-1)*rows,rows);
        List<Album> list = albumDao.selectByRowBounds(album, rowBounds);
        int count = albumDao.selectCount(album);
        HashMap<Object, Object> map = new HashMap<>();
        map.put("page",page);
        map.put("rows",list);
        map.put("total",count%rows==0?count/rows:count/rows+1);
        map.put("records",count);
        return map;
    }

    @Override
    public String add(Album album) {
        album.setId(UUID.randomUUID().toString());
        album.setCreateDate(new Date());
        album.setCount(0);
        int i = albumDao.insertSelective(album);
        if(i == 0){
            throw new RuntimeException("添加有误请重试！");
        }
        return album.getId();
    }

    @Override
    public void edit(Album album) {
        if("".equals(album.getCover())){
            album.setCover(null);
        }
        try {
            albumDao.updateByPrimaryKeySelective(album);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("修改失败请重试！");
        }
    }

    @Override
    public Album selectOne(String id) {
        return albumDao.selectByPrimaryKey(id);
    }


}
