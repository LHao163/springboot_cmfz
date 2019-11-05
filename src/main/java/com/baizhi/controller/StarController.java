package com.baizhi.controller;


import com.baizhi.entity.Star;
import com.baizhi.service.StarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("star")
public class StarController {

    @Autowired
    private StarService starService;

    @RequestMapping("selectAll")
    public HashMap<Object, Object> selectAll(Integer page, Integer rows){
        HashMap<Object, Object> map = starService.selectAll(page, rows);
        return map;
    }


    @RequestMapping("edit")
    public Map<String,Object> edit(String oper, Star star, HttpServletRequest request){
        Map<String, Object> map = new HashMap<>();
        try {
            if("add".equals(oper)){
                String id = starService.add(star);
                map.put("message",id);
            }
            if("edit".equals(oper)){
                starService.edit(star);
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
    public Map<String,Object> upload(MultipartFile photo, String id, HttpServletRequest request){
        Map<String, Object> map = new HashMap<>();
        System.out.println(photo == null);
        System.out.println(photo.getOriginalFilename());
        try {
            //文件上传
            photo.transferTo(new File(request.getServletContext().getRealPath("/star/img"),photo.getOriginalFilename()));
            //修改star对象中cover属性
            Star star = new Star();
            star.setId(id);
            star.setPhoto(photo.getOriginalFilename());
            System.out.println(star);
            starService.edit(star);
            map.put("status",true);
        } catch (IOException e) {
            e.printStackTrace();
            map.put("status",false);
        }
        return map;
    }

}
