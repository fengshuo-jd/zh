package com.zh_volunteer.ssm.util;


import com.zh_volunteer.ssm.pojo.Activity;
import com.zh_volunteer.ssm.pojo.User;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * 导入excel表格
 * 需要继续封装
 */
public class ExcelToList {

    private static File file;
    private static Workbook workbook;
    private static Sheet sheet;
    private static List<User> users;
    private Integer integer;
    public static List getListByExcel(String path) throws IOException, BiffException {
        //获取excel文件
         file = new File(path);

         workbook = Workbook.getWorkbook(file);
        //获取指定的sheet页
        sheet = workbook.getSheet("Sheet1");
        //获取行数列数
        //获取指定单元格的数据
        List<Activity> activities = new ArrayList<>(sheet.getRows());

        for(int i = 1;i < sheet.getRows();i++){
//            User user = new User();
            Activity activity = new Activity();
            for(int j = 0;j < sheet.getColumns();j++){
                switch (j){
                    case 0:
                        activity.setCreator(sheet.getCell(j,i).getContents());
                        //user.setUsername(sheet.getCell(j,i).getContents());
                        break;
                    case 1:
                        activity.setTime(sheet.getCell(j,i).getContents());
                        //user.setPassword(sheet.getCell(j,i).getContents());
                        break;
                    case 2:
                        activity.setState(sheet.getCell(j,i).getContents());
                        //user.setGender(sheet.getCell(j,i).getContents());
                        break;
                    case 3:
                        activity.setActivity_name(sheet.getCell(j,i).getContents());
                        //user.setPhone_num(sheet.getCell(j,i).getContents());
                        break;
                    case 4:
                        activity.setActivity_introduce(sheet.getCell(j,i).getContents());
                        //user.setLimit_id(Integer.parseInt(sheet.getCell(j,i).getContents()));
                        break;
                    case 5:
                        activity.setActivity_details(sheet.getCell(j,i).getContents());
                        //user.setStu_id(sheet.getCell(j,i).getContents());
                        break;
                    case 6:
                        activity.setActivity_remarks(sheet.getCell(j,i).getContents());
                        //user.setState_id(sheet.getCell(j,i).getContents());
                        break;
                    case 7:
                        activity.setTie(sheet.getCell(j,i).getContents());
                        //user.setTie(Integer.parseInt(sheet.getCell(j,i).getContents()));
                        break;
                    case 8:
                        activity.setActivity_type(sheet.getCell(j,i).getContents());
                        //user.setTie(Integer.parseInt(sheet.getCell(j,i).getContents()));
                        break;
                    case 9:
                        activity.setPhoto_path(sheet.getCell(j,i).getContents());
                        //user.setTie(Integer.parseInt(sheet.getCell(j,i).getContents()));
                        break;
                    case 10:
                        activity.setActivity_total_number(sheet.getCell(j,i).getContents());
                        //user.setTie(Integer.parseInt(sheet.getCell(j,i).getContents()));
                        break;
                    case 11:
                        activity.setActivity_current_number(sheet.getCell(j,i).getContents());
                        //user.setTie(Integer.parseInt(sheet.getCell(j,i).getContents()));
                        break;
                    default:
                        break;
                }
            }
            activities.add(activity);
        }
        //关闭workbook
        workbook.close();
        return activities;
    }

}
