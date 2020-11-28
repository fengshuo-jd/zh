package com.zh_volunteer.ssm.util.da;

import org.junit.Test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class eeqwe {


    public String timeSpile(String time) {

        String[] s = time.split(" ");

        String[] split = s[1].split(":");

        String final_time = s[0] + " " + split[0] + ":" + split[1];

        return final_time;
    }

    @Test
    public void test() {
        String s = timeSpile("2020-10-10 12:00:00");

        System.out.println(s);

    }

    @Test
    public void trueNumber() {

//        int[] nums = {1,2,3,1,1,3}; 15 6 3^2
//        int[] nums = {1,1,1,1}; //  6  4 3^1
        int[] nums = {1,2,3};   //    3  3 3^0

        int sum = 0;

        for(int i = 0;i < nums.length;i++) {
            for(int j = i + 1;j < nums.length;j++) {
                if(nums[i] == nums[j]) {
                   sum++;
                }
            }
        }

        System.out.println(sum);
    }

    @Test
    public void sortArray() {

        //  int[] nums = {2,5,1,3,4,7};
        //int[] nums = {1,2,3,4,4,3,2,1};
        int[] nums = {1,1,2,2};

        int flag = nums.length / 2;

        int[] finalArrat = new int[nums.length];
        int j = 0;

        for(int i = 0 ;i < nums.length;i++) {

            if(i % 2 == 0) {



                finalArrat[i] = nums[j++];
            } else if (i % 2 == 1) {

                finalArrat[i] = nums[flag++];
            }
        }

        System.out.println(Arrays.toString(finalArrat));

    }

    @Test
    public void deleteMidNode() {

//        LinkedList<Object> linkedList = new LinkedList<>();
//
//        linkedList.add("a");
//        linkedList.add("b");
//        linkedList.add("c");
//        linkedList.add("d");
//        linkedList.add("e");
//        linkedList.add("f");
//
//        System.out.println(linkedList.size() / 2);
//
//        linkedList.remove(linkedList.size() / 2 - 1);
//
//        System.out.println(linkedList.toString());


        LinkedList<Object> list = new LinkedList<>();

        list.add("1");
        list.add("2");
        list.add("3");
        list.add("4");
        list.add("5");
//        list.add("f");

        System.out.println(list.size() / 2);

        list.remove(list.size() / 2 );

        System.out.println(list.toString());
    }

    @Test
    public void lookForTheMostChildren() {

//        int[] candies = {2,3,5,1,3};
//        int[] candies = {4,2,1,1,2};
        int[] candies = {12,1,12};

//        int extraCandies = 3;
//        int extraCandies = 1;
        int extraCandies = 10;

        int mix = candies[0];

//        String[] finalStr = new String[candies.length];

        ArrayList<Boolean> finalStr = new ArrayList<>();

        for(int i = 0;i < candies.length;i++) {
            if(candies[i] >= mix) {
                mix = candies[i];
            }
        }

        int min = mix - extraCandies;

        for(int i = 0;i < candies.length;i++) {
            if(candies[i] >= min && candies[i] <= mix) {
//                finalStr[i] = "true";
                finalStr.add(i,true);
            }else {
                finalStr.add(i,false);
            }
        }

        System.out.println(finalStr.toString());
        System.out.println(mix);
        System.out.println(min);
    }

    @Test
    public void testZZ() {

        String str = "李13王2";

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


        System.out.println(finalNum);

        System.out.println(finalStr);

//        boolean isNum = str.matches("[0-9]+");
//
//        System.out.println(isNum);

    }

    @Test
    public void stoneAndBabyStone() {

        String s = "aAAbbbb";

        int n = 7;

        int finaa = n*(n-1) /2;

        System.out.println(finaa);

        String j = "aA";

//        String s = "ZZ";
//
//        String j = "z";


//        int sum = 0;

//        System.out.println(j.length());

//        if(s.contains(j)) {
//            sum += j.length();
//        }

//        for(int i = 0;i < s.length();i++) {
//            for(int i1 = 0;i1 < j.length();i1++) {
//
//                if(s.charAt(i) == j.charAt(i1)) {
//                    sum++;
//                    break;
//                }
//            }
//        }

//        System.out.println(sum);

    }

    @Test
    public void guessCoin() {

        System.out.println(17 / 2 + 1);

    }

    @Test
    public void CanUse() {

        String str = "255.100.50.0";

        StringBuffer stringBuffer = new StringBuffer(str);

        StringBuilder stringBuilder = new StringBuilder(str);

//        stringBuilder.

//        stringBuffer.replace()

        str.replaceAll("\\.","[.]");

        System.out.println(str);

//        String[] split = str.split("\\.");
//
//        String spileStr = "[.]";
//
//        String finalStr = "";
//
//        for(int i = 0;i < split.length;i++) {
//
//           if(".".equals(str.indexOf(i)) {
//               //str.charAt()
//
//               str.replace() = "[.]";
//            }
//        }
//
//        System.out.println(finalStr.toString());
    }


    @Test
    public void listNode() {

        Integer n = 4421;

        String s = n.toString();

        int length = s.length();

        int sum = 0;

        int grade = 1;

        for(int i = 0;i < length;i++) {
            //计算和
            sum += Integer.parseInt(String.valueOf(s.charAt(i)));
            //计算乘积
            grade *= Integer.parseInt(String.valueOf(s.charAt(i)));
        }


        //个位
        int individual = 0;
        //十位
        int ten = 0;
        //百位
        int hundred = 0;
        //千位
        int thousand = 0;


//        Integer n = 234;

//        n.
    }

    @Test
    public void getTime() {

        Calendar calendar = Calendar.getInstance();

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        String s  = simpleDateFormat.format(calendar.getTime());

        System.out.println(s);
    }


    @Test
    public void compareTime() throws ParseException {

        Date date = new Date();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

        String dateString = "2022-09-23 23:00:45";

        Date date2 = sdf.parse(dateString);
//        2020
        if (date.getTime() < date2.getTime()) {

            System.out.println(sdf.format(date));

        } else {

            System.out.println(sdf.format(date2));

        }
    }

    @Test
    public void creatMidArray() {

        int[] nums = {0,1,2,3,4};

        int[] index = {0,1,2,2,1};

        for(int i = 0;i < nums.length;i++) {

            int index_num = index[i];

            int nums_num = nums[i];

            if(index_num < i) {
//                for(int )

                for(int j = i + 1;j > 0;j--) {
                    nums[j] = nums[j-1];
                }
                nums[index_num] = nums_num;
            } else {
                nums[index_num] = nums_num;
            }

        }

        System.out.println(Arrays.toString(nums));

    }

    @Test
    public void list() {

        int[] nums = {1,2,3,4};

        int sum = 0;

        for(int q = 0;q < nums.length;q+=2) {

            sum += nums[q];

        }

        int index = 0;

        int[] target = new int[sum];

        for(int i = 0;i < nums.length;i+=2) {

            for(int j = 0;j < nums[i];j++) {
                target[index++] = nums[i + 1];
            }
        }

        System.out.println(Arrays.toString(target));

    }
}
