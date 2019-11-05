package com.baizhi.controller;


import com.baizhi.entity.Album;
import com.baizhi.entity.Star;
import com.baizhi.service.AlbumService;
import com.baizhi.service.StarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("album")
@RestController
public class AlbumController {

    @Autowired
    private AlbumService albumService;
    @Autowired
    private StarService starService;

    @RequestMapping("selectAll")
    public HashMap<Object, Object> selectAll(Integer page, Integer rows){
        HashMap<Object, Object> map = albumService.selectAll(page, rows);
        return map;
    }

    @RequestMapping("edit")
    public Map<String,Object> edit(String oper, Album album, HttpServletRequest request){
        Map<String, Object> map = new HashMap<>();
        try {
            if("add".equals(oper)){
                String id = albumService.add(album);
                map.put("message",id);
            }
            if("edit".equals(oper)){
                albumService.edit(album);
            }
            map.put("status",true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("status",false);
            map.put("message",e.getMessage());
        }
        return map;
    }




    @RequestMapping("upload")
    public Map<String,Object> upload(MultipartFile cover, String id, HttpServletRequest request){
        Map<String, Object> map = new HashMap<>();
        System.out.println(cover == null);
        System.out.println(cover.getOriginalFilename());
        try {
            //文件上传
            cover.transferTo(new File(request.getServletContext().getRealPath("/album/img"),cover.getOriginalFilename()));
            //修改album对象中cover属性
            Album album = new Album();
            album.setId(id);
            album.setCover(cover.getOriginalFilename());
            System.out.println(album);
            albumService.edit(album);
            map.put("status",true);
        } catch (IOException e) {
            e.printStackTrace();
            map.put("status",false);
        }
        return map;
    }

    @RequestMapping("findAll")
    public void findAll(HttpServletResponse response) throws IOException {

        List<Star> stars = starService.findAll();
        StringBuilder sb = new StringBuilder();
        sb.append("<select>");
        stars.forEach(star -> {
            sb.append("<option value=").append(star.getNickname()).append(">").append(star.getNickname()).append("</option>");
        });
        sb.append("</select>");
        //获取响应流
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println(sb.toString());
    }
}
