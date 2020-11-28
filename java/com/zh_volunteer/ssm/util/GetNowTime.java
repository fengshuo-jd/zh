package com.zh_volunteer.ssm.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;

public class GetNowTime {

    public static String getTimeByCalendar() {

        Calendar calendar = Calendar.getInstance();

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        String time  = simpleDateFormat.format(calendar.getTime());

        return time;
    }

}
