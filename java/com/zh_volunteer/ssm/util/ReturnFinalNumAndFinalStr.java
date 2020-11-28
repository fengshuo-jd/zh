package com.zh_volunteer.ssm.util;

/**
 * 将搜索框输入的内容切割成为两部分
 * 1.文字内容
 * 2.数字内容
 */
public class ReturnFinalNumAndFinalStr {

    public static String[] finalNumAndFinalStr (String str) {

        boolean isNum = true;

        String finalStr = "";

        String finalNum = "";

        char[] chars = str.toCharArray();

        String[] strs = new String[ str.toCharArray().length];

        for(int i = 0;i < strs.length;i++) {

            strs[i] = String.valueOf(chars[i]);
        }

        for(int i = 0;i < chars.length;i++) {

            isNum = strs[i].matches("[0-9]+");

            if(isNum == true) {
                finalNum += strs[i];
            } else {
                finalStr += strs[i];
            }
        }

        return new String[]{finalNum,finalStr};

    }
}
