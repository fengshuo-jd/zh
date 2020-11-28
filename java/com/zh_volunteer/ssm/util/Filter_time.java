package com.zh_volunteer.ssm.util;

/**
 * 过滤时间格式
 */
public class Filter_time {

    public static String timeSpile(String time) {

        String[] s = time.split(" ");

        String[] split = s[1].split(":");

        String final_time = s[0] + " " + split[0] + ":" + split[1];

        return final_time;
    }
}
