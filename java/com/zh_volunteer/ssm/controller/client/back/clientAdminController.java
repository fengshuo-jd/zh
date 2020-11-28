package com.zh_volunteer.ssm.controller.client.back;

import com.google.gson.JsonArray;
import com.sun.org.apache.xpath.internal.operations.Mod;
import com.zh_volunteer.ssm.pojo.Activity;
import com.zh_volunteer.ssm.pojo.User;
import com.zh_volunteer.ssm.service.client.back.ClientAdminService;
import com.zh_volunteer.ssm.util.ReturnFinalNumAndFinalStr;
import com.zh_volunteer.ssm.util.ToJsonArray;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.soap.Text;
import java.net.URLEncoder;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/clientAdmin")
public class clientAdminController {

    @Autowired
    private ClientAdminService clientAdminService;

    /**
     * 管理员登录
     * @param id
     * @return
     */
    @RequestMapping("/selectUserRole")
    public ModelAndView selectUserRole(@RequestParam(value = "id",required = true) String id) {

        ModelAndView mv = new ModelAndView();

        if("none".equals(id)) {

            mv.setViewName("Client/client_fist_page");

        } else {

            mv.setViewName("Client/client_back_act_index");

        }

        return mv;
    }

    /**
     * 活动select
     * @param username
     * @return
     * @throws Exception
     */
    @RequestMapping("/activityList")
    public ModelAndView activityList(@RequestParam(value = "username",required = true) String username) throws Exception {

        ModelAndView mv = new ModelAndView();

        List<Activity> activities = clientAdminService.selectActivityByUsername(username);

        JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

        mv.addObject("jsonArray",jsonArray);

        mv.setViewName("Client/client_back_act_list");

        return mv;
    }
    /**
     * 修改活动
     * @param activity_name
     * @param activity_details
     * @param activity_total_number
     * @param tie
     * @param activity_type
     * @param creator
     * @return
     * @throws Exception
     */
    @RequestMapping("/updateActivity")
    public ModelAndView updateActivity(@RequestParam(value = "activity_name",required = true) String activity_name,
                                       @RequestParam(value = "activity_details",required = true) String activity_details,
                                       @RequestParam(value = "activity_total_number",required = true) String activity_total_number,
                                       @RequestParam(value = "tie",required = true) String tie,
                                       @RequestParam(value = "activity_type",required = true) String activity_type,
                                       @RequestParam(value = "creator",required = true) String creator,
                                       @RequestParam(value = "activity_introduce",required = true) String activity_introduce,
                                       @RequestParam(value = "activity_score",required = true) Integer activity_score,
                                       @RequestParam(value = "activity_place",required = true) String activity_place,
                                       @RequestParam(value = "a",required = true) String a,
                                       @RequestParam(value = "l",required = true) String l,
                                       @RequestParam(value = "id",required = true) Integer id
    ) throws Exception {

        ModelAndView mv = new ModelAndView();

        System.out.println(activity_introduce+activity_score+activity_place+id);

        System.out.println(a + "=" + l);

        String typeStr = stringTypeToNumType(activity_type);

        String tieStr = StringTieToNumberTe(tie);

        System.out.println(typeStr + "===" +tieStr);

        Activity activity = new Activity(id,null, a,l,null,activity_name,activity_introduce,activity_details,null,typeStr,null,tieStr,activity_total_number,null,null,activity_score,activity_place);

        //Activity activity = new Activity(id,null,null,null,activity_name,null,activity_details,null,typeStr,null,tieStr,activity_total_number,null,null,null,null,null);

        clientAdminService.updateActivity(activity);

        List<Activity> activities = clientAdminService.selectActivityByUsername(creator);

        JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

        mv.addObject("jsonArray",jsonArray);

        mv.setViewName("Client/client_back_act_list");

        return mv;
    }
    /**
     * 删除活动
     * @param activity_id
     * @param creator
     * @return
     * @throws Exception
     */
    @RequestMapping("/deleteActivity")
    public ModelAndView deleteActivity(@RequestParam(value = "activity_id",required = true) Integer activity_id,@RequestParam(value = "creator",required = true) String creator) throws Exception {

        ModelAndView mv = new ModelAndView();

        System.out.println(activity_id + creator);

        clientAdminService.deleteActivity(activity_id);

        List<Activity> activities = clientAdminService.selectActivityByUsername(creator);

        JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

        mv.addObject("jsonArray",jsonArray);

        mv.setViewName("Client/client_back_act_list");

        return mv;
    }
    /**
     * 状态查询
     * @param stateId
     * @param creator
     * @return
     * @throws Exception
     */
    @RequestMapping("/suchFind")
    public ModelAndView suchFind(@RequestParam(value = "stateId",required = true) String stateId,@RequestParam(value = "creator",required = true) String creator) throws Exception {

        ModelAndView mv = new ModelAndView();

        List<Activity> activities = null;

        if("3".equals(stateId)) {

            activities = clientAdminService.selectActivityByUsername(creator);
        } else {

            activities = clientAdminService.selectActivityByUsernameAndStateId(stateId,creator);
        }

        JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

        mv.addObject("jsonArray",jsonArray);

        mv.setViewName("Client/client_back_act_list");

        return mv;
    }

    @RequestMapping("/selectActivityListAndSignUp")
    public ModelAndView selectActivityListAndSignUp(@RequestParam(value = "username",required = true) String creator) throws Exception {

        ModelAndView mv = new ModelAndView();

        List<Activity> activities = clientAdminService.selectActivityByUsernameAndThrough(creator);

        JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

        mv.addObject("jsonArray",jsonArray);

        mv.setViewName("Client/client_back_act_exam");

        return mv;
    }

    /**
     * 查询并且审报名某个活动的信息
     * @param activity_id
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/selectHasSignUpUser")
    public ModelAndView selectHasSignUpUser(@RequestParam(value = "activity_id",required = true) String activity_id, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        List<User> users = clientAdminService.selectUserByActivityId(activity_id);

        String activityName = clientAdminService.selectActivityName(activity_id);

        HttpSession session = request.getSession();

        session.setAttribute("actName",activityName);

        JsonArray jsonArray = ToJsonArray.getJsonArray(users, "user");

        mv.addObject("jsonArray",jsonArray);

        mv.setViewName("Client/client_back_act_number");

        return mv;
    }

    @RequestMapping("/updateState")
    public ModelAndView updateState(@RequestParam(value = "activityId",required = true) String activityId,@RequestParam(value = "radio",required = true) String state,@RequestParam(value = "stu_id",required = true) String stu_id) throws Exception {

        ModelAndView mv = new ModelAndView();

        System.out.println(activityId + "===" + state + "===" + stu_id);

        clientAdminService.updateUserState(state,stu_id,activityId);

        List<User> users = clientAdminService.selectUserByActivityId(activityId);

        JsonArray jsonArray = ToJsonArray.getJsonArray(users, "user");

        mv.addObject("jsonArray",jsonArray);

        mv.setViewName("Client/client_back_act_number");

        return mv;
    }

    @RequestMapping("/deleteSignUpUser")
    public ModelAndView deleteSignUpUser(@RequestParam(value = "stu_id",required = true) String stu_id,@RequestParam(value = "activity_id",required = true) String activity_id) throws Exception {

        ModelAndView mv = new ModelAndView();

        System.out.println(stu_id + "===" + activity_id);

        clientAdminService.deleteUser(stu_id);

        List<User> users = clientAdminService.selectUserByActivityId(activity_id);

        JsonArray jsonArray = ToJsonArray.getJsonArray(users, "user");

        mv.addObject("jsonArray",jsonArray);

        mv.setViewName("Client/client_back_act_number");

        return mv;

    }

    @RequestMapping("/suchFind1")
    public ModelAndView suchFind1(@RequestParam(value = "activity_id",required = true) String activity_id,@RequestParam(value = "state_id",required = true) String state_id) throws Exception {

        ModelAndView mv = new ModelAndView();

        System.out.println(activity_id + "===" + state_id);

        List<User> users = null;

        if("0".equals(state_id)) {

            users = clientAdminService.selectUserByActivityId(activity_id);
        } else {

            users = clientAdminService.suchFind(state_id, activity_id);
        }

        JsonArray jsonArray = ToJsonArray.getJsonArray(users, "user");

        mv.addObject("jsonArray",jsonArray);

        mv.setViewName("Client/client_back_act_number");

        return mv;
    }

    @RequestMapping("/selectByTime")
    public ModelAndView selectByTime(@RequestParam(value = "time",required = true) String time,@RequestParam(value = "username",required = true) String username) throws Exception {

        ModelAndView mv = new ModelAndView();

        System.out.println(time + "==" + username);

        List<Activity> activities = null;

        if("null".equals(time)) {

            System.out.println("0");

            activities = clientAdminService.selectActivityByUsernameAndThrough(username);

        } else {

            System.out.println("1");

            StringBuffer stringBuffer = new StringBuffer(time);

//            stringBuffer.append("%");

            activities = clientAdminService.selectActivityByUsernameAndTime(username,stringBuffer);
        }


        JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

        mv.addObject("jsonArray",jsonArray);

        mv.setViewName("Client/client_back_act_exam");

        return mv;
    }

    /**
     * 活动申请 / 活动添加
     * 重定向
     * @param activity_name
     * @param activity_introduce
     * @param activity_total_number
     * @param activity_type
     * @param stuid
     * @param tie
     * @param request
     * @param activity_details
     * @param activity_score
     * @param username
     * @param activity_place
     * @param l
     * @param a
     * @return
     * @throws Exception
     */
    @RequestMapping("/addActivity")
    public String addActivity(@RequestParam("activity_name") String activity_name,
                                    @RequestParam("activity_introduce") String activity_introduce,
                                    @RequestParam("activity_total_number") String activity_total_number,
                                    @RequestParam("activity_type") String activity_type,
                                    @RequestParam("stuid") String stuid,
                                    @RequestParam("tie") String tie,HttpServletRequest request,
                                    @RequestParam("activity_details") String activity_details,
                                    @RequestParam("activity_score") Integer activity_score,
                                    @RequestParam("name") String username,
                                    @RequestParam("activity_place") String activity_place,
                                    @RequestParam("l") String l,
                                    @RequestParam("a") String a

    ) throws Exception {

        HttpSession session = request.getSession();

        String numType = stringTypeToNumType(activity_type);

        String numTie = StringTieToNumberTe(tie);

        Activity activity = new Activity(null, username, a, l, "0", activity_name, activity_introduce, activity_details, null, numType, "/", numTie, activity_total_number, "0", null, activity_score, activity_place);

        clientAdminService.addActivity(activity);

        User user = (User) session.getAttribute("user");

        String url = "redirect:pridirect?stuid=" + stuid;

        return url;
    }

    @RequestMapping("/pridirect")
    public ModelAndView pridirect(HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        String stuid = request.getParameter("stuid");

        System.out.println(stuid);

        String username = clientAdminService.selectNameByStuId(stuid);

        List<Activity> activities = clientAdminService.selectActivityByUsername(username);

        JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

        mv.addObject("jsonArray", jsonArray);

        mv.setViewName("client_back_act_list");

        return mv;
    }

    @RequestMapping("/updateUser")
    public ModelAndView updateUser(@RequestParam("username") String username) throws Exception {

        ModelAndView mv = new ModelAndView();

        User user = clientAdminService.updateUserInfo(username);

        System.out.println("user=" + user);

        List<User> users = new ArrayList<>();

        users.add(user);

        for(User user1 : users) {

            System.out.println("user1=" +user1);
        }

        JsonArray jsonArray = ToJsonArray.getJsonArray(users, "user");

        mv.addObject("jsonArray",jsonArray);

        mv.setViewName("Client/client_back_act_info");

        return mv;
    }

    @RequestMapping("/updateUserInfo")
    public ModelAndView updateUserInfo(@RequestParam(value = "id",required = true) String id,@RequestParam("gender") String gender,@RequestParam("phone_num") String phone_num) throws Exception {

        ModelAndView mv = new ModelAndView();

        System.out.println(id + "=" + gender + "=" + phone_num);

        clientAdminService.updateUserInfoHasMore(id,gender,phone_num);

        mv.setViewName("Client/client_back_act_index");

        return mv;
    }

    @RequestMapping("/updateUserInfoHasMore")
    public ModelAndView updateUserInfoHasMore(@RequestParam(value = "stu_id",required = true) String stu_id,
                                              @RequestParam(value = "oldPassword") String oldPassword,
                                              @RequestParam(value = "newPassword") String newPassword,
                                              HttpServletRequest request
    ) throws Exception {

        ModelAndView mv = new ModelAndView();

        HttpSession session = request.getSession();

        String oldPsw = clientAdminService.selectPasswordByStuId(stu_id);

        if(oldPassword.equals(oldPsw)) {

            System.out.println("true");

            clientAdminService.updateUserPasswordByStu_id(newPassword,stu_id);

            session.invalidate();

            mv.setViewName("Client/client_login_stu");

        } else {

            System.out.println("else");

            mv.addObject("passwordMsg","原密码有误");

            mv.setViewName("Client/client_back_act_psw");
        }

        return mv;
    }

    @RequestMapping("/logout")
    public ModelAndView logout(HttpServletRequest request) {

        ModelAndView mv = new ModelAndView();

        HttpSession session = request.getSession();

        session.invalidate();

        mv.setViewName("Client/client_login_stu");

        return mv;
    }

    @RequestMapping("/charBoxByActivtyNameAndUserName")
    public ModelAndView charBoxByActivtyNameAndUserName(@RequestParam(value = "username") String username,
                                                        @RequestParam(value = "query") String activity_name) throws Exception {
        ModelAndView mv = new ModelAndView();

        List<Activity> activities = clientAdminService.charBoxByActivtyNameAndUserName(username,activity_name);

        JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

        mv.addObject("jsonArray", jsonArray);

        mv.setViewName("client_back_act_list");

        return mv;
    }

    @RequestMapping("/charBoxByActivtyNameAndUserNameT")
    public ModelAndView charBoxByActivtyNameAndUserNameT(@RequestParam(value = "username") String username,
                                                        @RequestParam(value = "query") String activity_name) throws Exception {
        ModelAndView mv = new ModelAndView();

        List<Activity> activities = clientAdminService.charBoxByActivtyNameAndUserName(username,activity_name);

        JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

        mv.addObject("jsonArray", jsonArray);

        mv.setViewName("Client/client_back_act_exam");

        return mv;
    }
    @RequestMapping("/charBoxNum")
    public ModelAndView charBoxNum(@RequestParam(name = "activity_id") String activity_id,
                                   @RequestParam(value = "query") String activity_name)throws Exception {

        ModelAndView mv = new ModelAndView();

        String[] strings = ReturnFinalNumAndFinalStr.finalNumAndFinalStr(activity_name);

        String finalNum = strings[0];

        if("".equals(finalNum)) {
            finalNum = " ";
        }

        String finalStr = strings[1];

        if("".equals(finalStr)) {
            finalStr = " ";
        }

        List<User> users = clientAdminService.charBoxNum(activity_id,finalNum,finalStr);

        JsonArray jsonArray = ToJsonArray.getJsonArray(users, "user");

        mv.addObject("jsonArray",jsonArray);

        mv.setViewName("Client/client_back_act_number");

        return mv;
    }

    /**
     *      *  * 1 计算机工程系
     *      *  * 2 自动化工程系
     *      *  * 3 机械工程系
     *      *  * 4 经济管理工程系
     *      *  * 5 电子信息工程系
     *      *  * 6 院级组织
     *      *  * 7 工作履历
     * @param tie
     * @return
     */
    private String numberTieToStringTie(String tie) {

        String finalStr = "";

        if("1".equals(tie)){
            finalStr = "计算机工程系";
        }else if("2".equals(tie)){
            finalStr = "自动化工程系";
        }else if("3".equals(tie)){
            finalStr = "机械工程系";
        }else if("4".equals(tie)){
            finalStr = "经济管理工程系";
        }else if("5".equals(tie)){
            finalStr = "电子信息工程系";
        }else if("6".equals(tie)){
            finalStr = "院级组织";
        }else {
            finalStr = "院级组织";
        }

        return finalStr;
    }
    /**
     *
     * @param tie
     * @return
     */
    private String StringTieToNumberTe(String tie) {
        String tie_id = "";

        switch (tie) {
            case "计算机工程系":
                tie_id = "1";
                break;
            case "自动化工程系":
                tie_id = "2";
                break;
            case "机械工程系":
                tie_id = "3";
                break;
            case "经济与管理系":
                tie_id = "4";
                break;
            case "电子信息工程系":
                tie_id = "5";
                break;
            case "院级组织":
                tie_id = "6";
                break;
            case "不限":
                tie_id = "0";
                break;
        }
        return tie_id;
    }
    /**
     *  * 1 文体活动
     *  * 2 实践实习
     *  * 3 公益志愿
     *  * 4 创新创业
     *  * 5 思想成长
     *  * 6 技能培训
     *  * 7 工作履历
     * @param str
     * @return
     */
    private String NumTypeToStringType(String str) {

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
    /**
     *
     * @param typeStr
     * @return
     */
    private String stringTypeToNumType(String typeStr) {

        String finStr = "";

        if("文体活动".equals(typeStr)) {
            finStr = "1";
        } else if("实践实习".equals(typeStr)) {
            finStr = "2";
        } else if("公益志愿".equals(typeStr)) {
            finStr = "3";
        } else if("创新创业".equals(typeStr)) {
            finStr = "4";
        } else if("思想成长".equals(typeStr)) {
            finStr = "5";
        } else if("技能培训".equals(typeStr)) {
            finStr = "6";
        }  else {
            finStr = "6";
        }
        return finStr;
    }
}
