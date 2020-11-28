package com.zh_volunteer.ssm.util;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.zh_volunteer.ssm.pojo.Activity;
import com.zh_volunteer.ssm.pojo.User;
import com.zh_volunteer.ssm.strategy.rolestrategy.*;
import com.zh_volunteer.ssm.strategy.tiestrategy.*;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

/**
 * 将前台传入的List 根据类型封装成为不同的json数组
 */
public class ToJsonArray {

    private static List<DealContext> list = new ArrayList<>();
    // 先加载好所有的角色策略
    static {
        list.add( new DealContext("1",new StudentStrategy()));
        list.add( new DealContext("2",new ManagerStrategy()));
        list.add( new DealContext("4",new SuperStretegy()));
    }
    private static List<TieContext> ties = new ArrayList<>();
    //加载所有的系别
    static {
        ties.add(new TieContext("1",new ComputerTieStrategy()));
        ties.add(new TieContext("2",new AutomaticTieStrategy()));
        ties.add(new TieContext("3",new MachineTieStrategy()));
        ties.add(new TieContext("4",new EconomyTieStatrgy()));
        ties.add(new TieContext("5",new EletrictInfoStrategy()));
    }
    public static <T> JsonArray getJsonArray(List<T> list,String name){

        if("user".equals(name)){

            try {

                return uJsonArray(list);
            } catch (Exception e) {
                e.printStackTrace();
            }

        } else if("activity".equals(name)){
            try {

                return aJsonArray(list);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
       return null;
    }

    private static  <T> JsonArray aJsonArray(List<T> list) throws Exception {

        JsonArray jsonElements = new JsonArray();
        JsonObject jsonObject;
        String staueStr = "";
        String decre = "";
        for(T t:list){

            jsonObject = new JsonObject();
            Activity aa =  (Activity)t;

            jsonObject.addProperty("id",aa.getId());
            jsonObject.addProperty("activity_introduce",aa.getActivity_introduce());
            jsonObject.addProperty("activity_details",aa.getActivity_details());

            String type = NumTypeToStringType(aa.getActivity_type());
            jsonObject.addProperty("activity_type",type);

            String activityState = "";
            if("1".equals(aa.getActivity_state())) {

                activityState = "报名已截止";
            } else if ("2".equals(aa.getActivity_state())) {

                activityState = "活动报名中";
            } else {

                activityState = "报名已截止";
            }
            jsonObject.addProperty("activityState",activityState);
            jsonObject.addProperty("photo_path",aa.getPhoto_path());
            jsonObject.addProperty("activity_remarks",aa.getActivity_remarks());
            jsonObject.addProperty("id",aa.getId());
            jsonObject.addProperty("activity_name",aa.getActivity_name());
            jsonObject.addProperty("creator",aa.getCreator());
            jsonObject.addProperty("state",aa.getState());
            jsonObject.addProperty("activity_total_number",aa.getActivity_total_number());
            jsonObject.addProperty("activity_current_number",aa.getActivity_current_number());

            if(aa.getTime() == null) {

                jsonObject.addProperty("time","");
            } else {

                String final_time = Filter_time.timeSpile(aa.getTime().toString().replace(".0", ""));

                jsonObject.addProperty("time",final_time);
            }


            if(aa.getEnd_time() == null) {

                jsonObject.addProperty("end_time","");
            } else {

                String final_time = Filter_time.timeSpile(aa.getEnd_time().toString().replace(".0", ""));

                jsonObject.addProperty("end_time",final_time);
            }

            jsonObject.addProperty("activity_score",aa.getActivity_score());
            jsonObject.addProperty("activity_place",aa.getActivity_place());

            if("0".equals(aa.getState())){
                staueStr = "未审核";
            }else if("1".equals(aa.getState())){
                staueStr = "审核未通过";
            }else if("2".equals(aa.getState())){
                staueStr = "已审核";
            }
            jsonObject.addProperty("stateStr",staueStr);

            decre = getTie(aa.getTie().toString());
            jsonObject.addProperty("tie",decre);
            jsonElements.add(jsonObject);
        }
        return jsonElements;
    }

    private static  <T> JsonArray uJsonArray(List<T> list) throws Exception{

        JsonArray  jsonElements = new JsonArray();
        JsonObject jsonObject;
        String decre = "";
        for(T t:list){

            jsonObject = new JsonObject();
            User aa =  (User)t;

            jsonObject.addProperty("id",aa.getId());
            jsonObject.addProperty("username",aa.getUsername());
            jsonObject.addProperty("stu_id",aa.getStu_id());
            jsonObject.addProperty("phone_num",aa.getPhone_num());
            jsonObject.addProperty("gender",aa.getGender());
            jsonObject.addProperty("state_id",aa.getState_id());
            jsonObject.addProperty("credits",aa.getCredits());

            String stateStr1 = "";
            if("0".equals(aa.getSignUp_state())){
                stateStr1 = "未审核";
            }else if("1".equals(aa.getSignUp_state())){
                stateStr1 = "未通过";
            }else if("2".equals(aa.getSignUp_state())){
                stateStr1 = "已通过";
            }

            jsonObject.addProperty("signUp_state",stateStr1);

            jsonObject.addProperty("state2",aa.getSignUp_state());
            String stateStr = "";

            if("0".equals(aa.getState_id())){
                stateStr = "未审核";
            }else if("1".equals(aa.getState_id())){
                stateStr = "未通过";
            }else if("2".equals(aa.getState_id())){
                stateStr = "已通过";
            }

            jsonObject.addProperty("stateStr",stateStr);

            if(aa.getSignUpTime() == null) {

                jsonObject.addProperty("time", "");
//                jsonObject.addProperty("tie", "");
//                jsonObject.addProperty("limit_id","");

            }else {

                String[] s = aa.getSignUpTime().split(" ");
                System.out.println(s[0] + s[1]);
                jsonObject.addProperty("time", s[0]);
            }

            if(aa.getTie() == null) {
                jsonObject.addProperty("tie", "");
            } else {
                decre = getTie(aa.getTie().toString());
                jsonObject.addProperty("tie",decre);
            }

            if(aa.getLimit_id() == null) {
                jsonObject.addProperty("limit_id", "");
            } else {
                decre = test(aa.getLimit_id().toString());
                jsonObject.addProperty("limit_id",decre);
            }

            jsonElements.add(jsonObject);
        }

        System.out.println(jsonElements.toString());
        return jsonElements;
    }
    @Test
    public void test2(){
        test("3");
    }

    public static String test(String type) {
        String s = "";
        RoleStrategy roleStrategy = null;
        for(DealContext dealContext : list){
            if(dealContext.options(type)) {
                roleStrategy = dealContext.getRoleStrategy();
                s = roleStrategy.roleStrategy(type);
            }
        }
        return  s;
    }


    public static String getTie(String type){

        String s = "";
        TieStrategy tieStrategy = null;
        for(TieContext tieContext:ties){
            if("1".equals(type) || "2".equals(type) || "3".equals(type) || "4".equals(type) || "5".equals(type)) {
                if (tieContext.options(type)) {
                    tieStrategy = tieContext.getRoleStrategy();
                    s = tieStrategy.roleStrategy(type);
                    return s;
                }
            }else {
                return "院级组织";
            }
        }
        return "院级组织";
    }

    private static String NumTypeToStringType(String str) {

        String finnalStr = "";

        if("1".equals(str)) {
            finnalStr = "文体活动";
        }else if("2".equals(str)) {
            finnalStr = "实践实习";
        }else if("3".equals(str)) {
            finnalStr = "公益志愿";
        }else if("4".equals(str)) {
            finnalStr = "创新创业";
        }else if("5".equals(str)) {
            finnalStr = "思想成长";
        }else if("6".equals(str)) {
            finnalStr = "技能培训";
        }else {
            finnalStr = "技能培训";
        }

        return finnalStr;
    }
}
