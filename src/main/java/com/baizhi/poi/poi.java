package com.baizhi.poi;

import org.apache.poi.hssf.usermodel.*;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class poi {
    public static void main(String[] args) throws Exception {

        HSSFWorkbook workbook = new HSSFWorkbook(new FileInputStream("C:/Users/MagicBook/Desktop/ser.xls"));
        HSSFCellStyle cellStyle = workbook.createCellStyle();
        HSSFDataFormat dataFormat = workbook.createDataFormat();
        short format = dataFormat.getFormat("yyyy-MM-dd");
        cellStyle.setDataFormat(format);
        HSSFSheet sheet = workbook.getSheet("yy");
        List<User> list = new ArrayList<>();
        for (int i = 0; i <= sheet.getLastRowNum(); i++) {
            User user = new User();
            HSSFRow row = sheet.getRow(i);

            HSSFCell cell = row.getCell(0);
            String id = cell.getStringCellValue();
            user.setId(id);

            HSSFCell cell1 = row.getCell(1);
            String name = cell1.getStringCellValue();
            user.setName(name);

            HSSFCell cell2 = row.getCell(2);
            Date date = cell2.getDateCellValue();
            user.setBir(date);
            cell2.setCellStyle(cellStyle );

            list.add(user);
        }


        //workbook.write(new FileOutputStream(new File("C:/Users/MagicBook/Desktop/user.xls")));

        for (User user : list) {
             System.out.println(user);
         }
    }
}
