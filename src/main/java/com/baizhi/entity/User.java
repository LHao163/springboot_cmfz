package com.baizhi.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.annotation.ExcelIgnore;
import com.alibaba.fastjson.annotation.JSONField;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Column;
import javax.persistence.Id;
import java.util.Date;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {

    @Id
    @Excel(name = "编号")
    private String id;
    @Excel(name = "用户名")
    private String username;
    private String password;
    @ExcelIgnore
    private String salt;
    @Excel(name = "昵称")
    private String nickname;
    @Excel(name = "电话")
    private String phone;
    @ExcelIgnore
    private String province;
    @Excel(name = "城市")
    private String city;
    @Excel(name = "签名")
    private String sign;
    @Excel(name = "头像")
    private String photo;
    @Excel(name = "性别",replace = { "男_N", "女_O" })
    private String sex;
    @JSONField(format = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "时间",format = "yyyy-MM-dd",width = 50)
    @Column(name = "create_date")
    private Date createdate;
    @Column(name = "starId")
    @ExcelIgnore
    private String starId;

}
