package com.baizhi.controller;


import com.baizhi.entity.Album;
import com.baizhi.entity.Chapter;
import com.baizhi.service.AlbumService;
import com.baizhi.service.ChapterService;
import it.sauronsoftware.jave.Encoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

@RequestMapping("chapter")
@RestController
public class ChapterController {

    @Autowired
    private ChapterService chapterService;

    @Autowired
    private AlbumService albumService;


    @RequestMapping("selectByAlbumIdAll")
    public Map<String,Object> selectByAlbumIdAll(Integer page, Integer rows, String albumId){
        return chapterService.selectByAlbumIdAll(page,rows,albumId);
    }

        //文件上传
        @RequestMapping("upload")
        public Map<String,Object> upload(MultipartFile name, String id, HttpServletRequest request,String albumId){
            Map<String, Object> map = new HashMap<>();
            try {
                name.transferTo(new File(request.getServletContext().getRealPath("/chapter/audios"),name.getOriginalFilename()));
                Chapter chapter = new Chapter();
                chapter.setName(name.getOriginalFilename());
                //文件大小
                BigDecimal sizez = new BigDecimal(name.getSize());
                BigDecimal mod = new BigDecimal(1024);
                //除两个1024，保留两位小数，进行四舍五入
                BigDecimal setScale = sizez.divide(mod).divide(mod).setScale(2, BigDecimal.ROUND_HALF_UP);
                ///文件时长
                Encoder encoder = new Encoder();
                long length = encoder.getInfo(new File(request.getServletContext().getRealPath("/chapter/audios"), name.getOriginalFilename())).getDuration();
                chapter.setDuration(length/1000/60+"min"+length/1000%60+"seconds ");
                //修改专辑中的数量
                Album album = albumService.selectOne(albumId);
                album.setCount(album.getCount()+1);
                albumService.edit(album);
                chapter.setId(id);
                chapter.setAlbumId(albumId);
                chapter.setSize(setScale+"MG");
                chapterService.edit(chapter);
                map.put("status",true);
            } catch (Exception e) {
                e.printStackTrace();
                map.put("status",false);
            }
            return map;
        }


    @RequestMapping("edit")
    public Map<String,Object> edit(String oper, Chapter chapter, HttpServletRequest request){
        Map<String, Object> map = new HashMap<>();
        try {
            if("add".equals(oper)){
                String id = chapterService.add(chapter);
                map.put("message",id);
            }
            if("edit".equals(oper)){
                chapterService.edit(chapter);
            }
            map.put("status",true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("status",false);
            map.put("message",e.getMessage());
        }
        return map;
    }



}
