package com.baizhi.controller;


import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import com.baizhi.entity.User;
import com.baizhi.entity.UserEchaters;
import com.baizhi.service.UserService;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("user")
@RestController
public class UserController {

   @Autowired
    private UserService userService;

    @RequestMapping("selectUsersByStarIdAll")
    public Map<String,Object> selectUsersByStarIdAll(Integer page, Integer rows, String starId){
        return userService.selectUsersByStarIdAll(page,rows,starId);
    }

    @RequestMapping("easyPoi")
    public void export(HttpServletResponse resp){
        List<User> list = userService.easyPoi();

        Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams("计算机一班学生","学生"), com.baizhi.entity.User.class, list);

        String fileName = "用户报表("+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+").xls";
        //处理中文下载名乱码
        try {
            fileName = new String(fileName.getBytes("gbk"),"iso-8859-1");
            //设置 response
            resp.setContentType("application/vnd.ms-excel");
            resp.setHeader("content-disposition","attachment;filename="+fileName);
            workbook.write(resp.getOutputStream());
            workbook.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    @RequestMapping("echarts")
    public Map<String,Object> echarts() {
        Map<String, Object> map = new HashMap<>();
        List<UserEchaters> list = userService.findAll("男");
        Integer[] nan = {0, 0, 0, 0, 0, 0};
        for (UserEchaters user : list) {
            String month = user.getMonth();
            for (int i = 0; i < 6; i++) {
                if (String.valueOf(i+1).equals(month)) {
                    nan[i] = user.getCount();
                }
            }
        }
        map.put("nan", nan);
        List<UserEchaters> list1 = userService.findAll("女");
        Integer[] nv = {0, 0, 0, 0, 0, 0};
        for (UserEchaters user : list1) {
            String month = user.getMonth();
            for (int i = 0; i < 6; i++) {
                if (String.valueOf(i+1).equals(month)) {
                    nv[i] = user.getCount();
                }
            }
        }
        map.put("nv", nv);
        return map;
    }
}
