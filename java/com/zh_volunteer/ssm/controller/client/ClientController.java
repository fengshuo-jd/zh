package com.zh_volunteer.ssm.controller.client;

import com.github.pagehelper.PageInfo;
import com.google.gson.JsonArray;
import com.sun.org.apache.xpath.internal.operations.Mod;
import com.zh_volunteer.ssm.pojo.Activity;
import com.zh_volunteer.ssm.pojo.User;
import com.zh_volunteer.ssm.service.back.UserService;
import com.zh_volunteer.ssm.service.client.ClientService;
import com.zh_volunteer.ssm.service.client.back.ClientAdminService;
import com.zh_volunteer.ssm.util.GetNowTime;
import com.zh_volunteer.ssm.util.ToJsonArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 系别编号
 * 1 计算机工程系
 * 2 自动化工程系
 * 3 机械工程系
 * 4 经济管理工程系
 * 5 电子信息工程系
 * 6 院级组织
 * 7 工作履历
 *
 * 活动类型编号
 * 1 文体活动
 * 2 实践实习
 * 3 公益志愿
 * 4 创新创业
 * 5 思想成长
 * 6 技能培训
 * 7 工作履历
 *
 * 活动报名中 2
 * 报名已截止 1
 */
@Controller
@RequestMapping("/client")
public class ClientController {

    @Autowired
    private ClientService clientService;

    @Autowired
    private ClientAdminService clientAdminService;

    private static Map map = new HashMap();

    /**
     * 学生登录或者超级管理员登录
     * @param username
     * @param password
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public ModelAndView login(@RequestParam(name = "username_a",required = true) String username, @RequestParam(name = "password_a",required = true) String password, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        User user = clientService.login(username, password);

        HttpSession session = request.getSession();

        if (user != null) {

            session.setAttribute("flag",0);

            session.setAttribute("wolcomeInfo","欢迎回来");

            session.setAttribute("userHone","个人中心");

            session.setAttribute("user",user);

            if(user.getLimit_id() == 2) {

                mv.setViewName("Client/client_back_act_index");

                return mv;
            }

            List<Activity> activities = clientService.findAllActivity();

            List<User> users = clientService.selectTopTenStudent();

            mv.addObject("topTenStudents",users);

            JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

            mv.addObject("jsonArray",jsonArray);

            mv.addObject("username",user.getUsername());

            mv.setViewName("Client/client_fist_page");

        } else {

            mv.addObject("msg","账号或者密码错误");

            mv.setViewName("Client/client_login_stu");
        }

        return mv;
    }

    /**
     * 通过活动类型查询活动
     * @param activtyType
     * @return
     * @throws Exception
     */
    @RequestMapping("/findSuchByActivityType")
    public ModelAndView findSuchByActivityType(@RequestParam(name = "activtyType",required = true) String activtyType,HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        HttpSession session = request.getSession();

        String type = NumTypeToStringType(activtyType);

        session.setAttribute("tittle",type);

        List<Activity> activities = clientService.findSuchActivityByActivityType(activtyType);

        Integer page = clientService.findCountByType(activtyType);

        JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

        mv.addObject("page",page);

        mv.addObject("jsonArray",jsonArray);

        mv.setViewName("Client/client_classify");

        return mv;
    }
    /**
     *  * 1 计算机工程系
     *  * 2 自动化工程系
     *  * 3 机械工程系
     *  * 4 经济管理工程系
     *  * 5 电子信息工程系
     *  * 6 院级组织
     *  * 7 工作履历
     *
     *  任意查询通过活动类型和系别
     * @param activity_type
     * @param tie
     * @return
     */
    @RequestMapping("/randomFind")
    public ModelAndView randomFind(@RequestParam(name = "activity_type",required = true) String activity_type,@RequestParam(name = "tie",required = true) String tie) throws Exception {

        System.out.println("==========================================================");

        ModelAndView mv = new ModelAndView();

        String tie_id = "";

        tie_id = StringTieToNumberTe(tie);

        List<Activity> activities = null;

        if( "0".equals(tie_id)) {

            activities = clientService.findSuchActivityByActivityType(activity_type);

            Integer page = clientService.findCountByTie(tie_id);

            JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

            mv.addObject("jsonArray",jsonArray);

            mv.addObject("page",page);

            mv.setViewName("Client/client_classify");

            return mv;

        } else {
            activities = clientService.randomFind(activity_type, tie_id);

            Integer page = clientService.findCountByTieAndType(tie_id, activity_type);

            JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

            mv.addObject("page",page);

            mv.addObject("jsonArray", jsonArray);

            mv.setViewName("Client/client_classify");

            return mv;
        }
    }
    /**
     *
     * @param activity_type
     * @param tie
     * @return
     */
    @RequestMapping("/randomFind_2")
    public ModelAndView randomFind_2(@RequestParam(name = "activity_type",required = true) String activity_type,@RequestParam(name = "tie",required = true) String tie) throws Exception {

        ModelAndView mv = new ModelAndView();

        if ("不限".equals(activity_type)) {

            String tieStr = StringTieToNumberTe(tie);

            Integer page = clientService.findCountByTie(tieStr);

            List<Activity> activities = clientService.findSuchActivityByTie(tieStr);

            JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

            mv.addObject("page",page);

            mv.addObject("jsonArray", jsonArray);

        } else {

            String typeStr = stringTypeToNumType(activity_type);

            String tieStr = StringTieToNumberTe(tie);

            List<Activity> activities = clientService.randomFind(typeStr, tieStr);

            Integer page = clientService.findCountByTieAndType(tieStr, typeStr);

            JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

            mv.addObject("page",page);

            mv.addObject("jsonArray", jsonArray);

        }

        mv.setViewName("Client/client_zdh");

        return mv;

    }
    /**
     * 根据系别查找
     * @param tie
     * @return
     * @throws Exception
     */
    @RequestMapping("/findSuchByTie")
    public ModelAndView pageInforandomFind(@RequestParam(name = "tie",required = true) String tie,HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        HttpSession session = request.getSession();

        String ti = numberTieToStringTie(tie);

        session.setAttribute("tittle",ti);

        List<Activity> activities = clientService.findSuchActivityByTie(tie);

        JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

        Integer page = clientService.findCountByTie(tie);

        mv.addObject("page",page);

        mv.addObject("jsonArray",jsonArray);

        mv.setViewName("Client/client_zdh");

        return mv;
    }
    /**
     * 活动详情
     * @param activity_id
     * @return
     */
    @RequestMapping("/activityDetail")
    public ModelAndView activityDetail(@RequestParam(name = "activity_id",required = true) String activity_id,@RequestParam(value = "stu_id",required = true) String stu_id) throws Exception {

        ModelAndView mv = new ModelAndView();

        Activity activity = null;   

        String ida = clientService.hasSignUp(activity_id, stu_id);

        String sign_id = clientService.isCanSignUp(activity_id);

        if (ida != null) {
            System.out.println("已报名");

            activity = clientService.findOneActivityByActivity_id(activity_id);

            String tieStr = numberTieToStringTie(activity.getTie());

            String activity_type = NumTypeToStringType(activity.getActivity_type());

            activity.setActivity_type(activity_type);

            activity.setTie(tieStr);

            mv.addObject("activity",activity);

            mv.addObject("activityHasSignUp", "已报名");

            mv.setViewName("Client/client_detail");

            return mv;
        }
        if (sign_id == null) {

            System.out.println("人数已满");

            mv.addObject("activityHasSignUp","人数已满");

            activity = clientService.findOneActivityByActivity_id(activity_id);

            String tieStr = numberTieToStringTie(activity.getTie());

            String activity_type = NumTypeToStringType(activity.getActivity_type());

            activity.setActivity_type(activity_type);

            activity.setTie(tieStr);

            mv.addObject("activity",activity);

            mv.setViewName("Client/client_detail");

            return mv;
        }

        if (ida == null) {

            System.out.println("我要报名");

            mv.addObject("activityHasSignUp", "我要报名");

            activity = clientService.findOneActivityByActivity_id(activity_id);

            String tieStr = numberTieToStringTie(activity.getTie());

            String activity_type = NumTypeToStringType(activity.getActivity_type());

            activity.setActivity_type(activity_type);

            activity.setTie(tieStr);

            System.out.println(activity.toString());

            mv.addObject("activity",activity);

            mv.setViewName("Client/client_detail");

            return mv;
        }

        return mv;
    }
    @RequestMapping("/pageInfoSelect_2")
    public ModelAndView pageInfoSelect_2(@RequestParam(name = "activityType",required = true) String activityType,
                                         @RequestParam(name = "page",required = true) Integer page,
                                         @RequestParam(name = "tie",required = true) String tie) throws Exception {

        ModelAndView mv = new ModelAndView();

        List<Activity> activities = null;
        //获取条数间距
        Integer firstLimit = ( page - 1 ) * 10;

        Integer afterLimit = firstLimit + 10;


        if("none".equals(activityType) ) {
            activities = clientService.getFixLimitTieNotActivities(firstLimit, tie);

            Integer page1 = clientService.findCountByTie(tie);

            mv.addObject("page",page1);

            JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

            mv.addObject("jsonArray",jsonArray);

            mv.setViewName("Client/client_zdh");

            return mv;
        }

        if("不限".equals(activityType)) {

            System.out.println("sddsadsadsad");

            String num_tie = StringTieToNumberTe(tie);

            activities = clientService.getFixLimitTieNotActivities(firstLimit, num_tie);

            Integer page1 = clientService.findCountByTie(num_tie);

            mv.addObject("page",page1);

            JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

            mv.addObject("jsonArray",jsonArray);

            mv.setViewName("Client/client_zdh");

            return mv;
        } else {

            String typeStr = stringTypeToNumType(activityType);

            String tieStr = StringTieToNumberTe(tie);

            activities = clientService.getFixLimitActivities(firstLimit, afterLimit, typeStr, tieStr);

            Integer page1 = clientService.findCountByTieAndType(tieStr, typeStr);

            mv.addObject("page",page1);

            JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

            mv.addObject("jsonArray",jsonArray);

            mv.setViewName("Client/client_zdh");

            return mv;
        }

    }
    @RequestMapping("/toIndex")
    public ModelAndView findall() throws Exception {
        ModelAndView mv = new ModelAndView();

        List<Activity> activities = clientService.findAllActivity();
        //进一步处理activities
        activities = doTime(activities);

        List<User> users = clientService.selectTopTenStudent();

        int i = 1;

        for(User user : users) {
            map.put(user.getStu_id(),i++);
        }

        mv.addObject("topTenStudents",users);

        JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

        mv.addObject("jsonArray",jsonArray);

        mv.setViewName("Client/client_fist_page");

        return mv;
    }

    private List<Activity> doTime(List<Activity> activities) throws ParseException {

        //String nowTime = GetNowTime.getTimeByCalendar();

        Date date = new Date();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

        for(Activity activity : activities) {

            String end_time = activity.getEnd_time();

            Date date2 = sdf.parse(end_time);
            //如果当前时间小于结束时间
            if (date.getTime() < date2.getTime()) {

                System.out.println(sdf.format(date));

            }//当前时间大于结束时间 改变状态 然后在把credits+1
            else {

                activity.setActivity_state("1");


            }

        }

//        String dateString = nowTime;
//
//        Date date2 = sdf.parse(dateString);

//        if (date.getTime() < date2.getTime()) {
//
//            System.out.println(sdf.format(date));
//
//        } else {
//
//            System.out.println(sdf.format(date2));
//
//        }

        return activities;
    }

    @RequestMapping("/toIndex1")
    public ModelAndView toIndex1(HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        HttpSession session = request.getSession();

        session.invalidate();

        List<Activity> activities = clientService.findAllActivity();

        List<User> users = clientService.selectTopTenStudent();

        mv.addObject("topTenStudents",users);

        JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

        mv.addObject("jsonArray",jsonArray);

        mv.setViewName("Client/client_fist_page");

        return mv;
    }
    /**
     *
     * @param activityType
     * @param page
     * @param tie
     * @return
     * @throws Exception
     */
    @RequestMapping("/pageInfoSelect")
    public ModelAndView pageInfoSelect(@RequestParam(name = "activityType",required = true) String activityType,@RequestParam(name = "page",required = true) Integer page,@RequestParam(name = "tie",required = true) String tie) throws Exception {

        ModelAndView mv = new ModelAndView();

        List<Activity> activities = null;
        //获取条数间距
        Integer firstLimit = ( page - 1 ) * 10;

        Integer afterLimit = firstLimit + 10;

        if("none".equals(tie)) {

            activities = clientService.getFixLimitActivitiesNotTie(firstLimit, activityType);

            Integer page1 = clientService.findCountByType(activityType);

            mv.addObject("page",page1);

        } else {

            String Tie_id = StringTieToNumberTe(tie);

            activities = clientService.getFixLimitActivities(firstLimit, afterLimit, activityType, Tie_id);

            Integer page1 = clientService.findCountByTieAndType(Tie_id, activityType);

            mv.addObject("page",page1);

        }

        JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

        mv.addObject("jsonArray",jsonArray);

        mv.setViewName("Client/client_classify");

        return mv;
    }

    /**
     * 学生个人信息展示
     *
     * 注:由于信息需要渲染到前端页面所有将部分信息存放到request域中
     * @param stuId
     * @return
     * @throws Exception
     */
    @RequestMapping("/stuCenter")
    public ModelAndView stuCenter(@RequestParam(name = "userId",required = true) String stuId) throws Exception {

        ModelAndView mv = new ModelAndView();

        System.out.println(stuId);

        User user = clientService.findUserById(stuId);

        List<Activity> activities = clientService.selectActivityBySignUp(user.getStu_id());

        JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

        Object number = map.get(stuId);

        mv.addObject("credits",user.getCredits());

        mv.addObject("rank",number);

        mv.addObject("jsonArray",jsonArray);

        mv.addObject("stu_id",user.getStu_id());

        mv.addObject("username",user.getUsername());

        mv.addObject("phoneNumber",user.getPhone_num());

        mv.addObject("gender",user.getGender());

        mv.setViewName("Client/client_memberCenter");

        return mv;
    }

    /**
     * 用户报名活动
     * 当用户进入该活动的时候 根据用户的信息来判断是否可以报名
     * 包含三种状态
     * 注： 有bug
     * @param activity_id
     * @param stu_id
     * @param time
     * @return
     * @throws Exception
     */
    @RequestMapping("/signUpActivity")
    public ModelAndView signUpActivity(@RequestParam(name = "activity_id",required = true) String activity_id,
                                       @RequestParam(name = "stu_id",required = true) String stu_id,
                                       @RequestParam("time") String time) throws Exception {

            ModelAndView mv = new ModelAndView();

            Boolean flag = clientService.signUpActivity(activity_id, stu_id, time);

            System.out.println(flag);

            if (flag == true) {

                mv.addObject("activityHasSignUp", "已报名");
            }

            Activity activity = clientService.findOneActivityByActivity_id(activity_id);

            String tieStr = numberTieToStringTie(activity.getTie());

            String activity_type = NumTypeToStringType(activity.getActivity_type());

            activity.setActivity_type(activity_type);

            activity.setTie(tieStr);

            System.out.println(activity.toString());

            mv.addObject("activity", activity);

            mv.setViewName("Client/client_detail");

        return mv;
    }

    @RequestMapping("/gotoHasSignUpActivityDetail")
    public ModelAndView gotoHasSignUpActivityDetail(@RequestParam(name = "activity_id",required = true) String activity_id,@RequestParam(value = "stu_id",required = true) String stu_id) throws Exception {

        ModelAndView mv = new ModelAndView();

        Activity activity = clientService.findOneActivityByActivity_id(activity_id);

        String tieStr = numberTieToStringTie(activity.getTie());

        String activity_type = NumTypeToStringType(activity.getActivity_type());

        activity.setActivity_type(activity_type);

        activity.setTie(tieStr);

        mv.addObject("activity",activity);

        mv.addObject("activityHasSignUp", "已报名");

        mv.setViewName("Client/client_detail");

        return mv;
    }

    @RequestMapping("/updateStuInfo")
    public ModelAndView updateStuInfo(@RequestParam(value = "stu_id",required = true) String stu_id,@RequestParam(value = "phone_num",required = true) String phone_num,@RequestParam(value = "gender",required = true) String gender) throws Exception {

        ModelAndView mv = new ModelAndView();
        //,@RequestParam(value = "phone_num",required = true) String phone_num,@RequestParam(value = "gender",required = true) String gender
        System.out.println(phone_num + gender + stu_id);

        Boolean flag = clientService.updateStuInfo(stu_id, phone_num, gender);

        User user = clientService.findUserById(stu_id);

        //List<Activity> activities = clientService.selectActivityBySignUp(stu_id);

        //jsonArray = ToJsonArray.getJsonArray(activities, "activity");

        //mv.addObject("jsonArray",jsonArray);

//        mv.addObject("stu_id",user.getStu_id());
//
//        mv.addObject("gender",user.getGender());
//
//        mv.addObject("username",user.getUsername());
//
//        mv.addObject("phoneNumber",user.getPhone_num());

        return stuCenter(stu_id);


    }
    @RequestMapping("/updateStuPsw")
    public ModelAndView updateStuPsw(@RequestParam(value = "stu_id",required = true) String stu_id,@RequestParam(value = "oldPassword") String oldPassword,@RequestParam(value = "newPassword") String newPassword,HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        JsonArray jsonArray = null;

        User user = null;

        String oldPsw = clientAdminService.selectPasswordByStuId(stu_id);

        if(oldPassword.equals(oldPsw)) {

            clientService.updateStuPaw(stu_id,newPassword);

            user = clientService.findUserById(stu_id);

            List<Activity> activities = clientService.selectActivityBySignUp(stu_id);

            jsonArray = ToJsonArray.getJsonArray(activities, "activity");

            mv.addObject("jsonArray",jsonArray);

            mv.addObject("stu_id",user.getStu_id());

            mv.addObject("username",user.getUsername());

            mv.addObject("phoneNumber",user.getPhone_num());

            mv.setViewName("Client/client_login_stu");

            HttpSession session = request.getSession();

            session.invalidate();

        } else {
            user = clientService.findUserById(stu_id);

            List<Activity> activities = clientService.selectActivityBySignUp(stu_id);

            jsonArray = ToJsonArray.getJsonArray(activities, "activity");

            mv.addObject("jsonArray",jsonArray);

            mv.addObject("stu_id",user.getStu_id());

            mv.addObject("username",user.getUsername());

            mv.addObject("phoneNumber",user.getPhone_num());

            mv.addObject("errorUpdatePsw","原密码错误");

            mv.setViewName("Client/client_memberCenter");

            return mv;
        }

        //Enumeration em = request.getSession().getAttributeNames();  //得到session中所有的属性名


//        if(oldPassword.equals(oldPsw)) {
//
//            System.out.println("true");
//
//            clientAdminService.updateUserPasswordByStu_id(newPassword,stu_id);
//
//            mv.setViewName("Client/client_memberCenter");
//
//        } else {
//
//            System.out.println("else");
//
//            mv.addObject("passwordMsge","原密码有误");
//
//            mv.setViewName("Client/client_memberCenter");
//        }
       //mv.setViewName("Client/client_login_stu");
        return mv;
    }

    @RequestMapping("/search")
    public ModelAndView search(@RequestParam(value = "key",required = true) String key,HttpServletRequest request) throws Exception{

        ModelAndView mv = new ModelAndView();

        List<Activity> activities = clientService.chartBoxSearchByKey(key);

        Integer count = clientService.selectByChatBoxCount(key);

        System.out.println("Count ==" + count);

        JsonArray jsonArray = ToJsonArray.getJsonArray(activities, "activity");

        System.out.println(jsonArray);

        HttpSession session = request.getSession();

        session.setAttribute("ChartBoxCount",count);

        session.setAttribute("key",key);

        mv.addObject("jsonArray",jsonArray);

        mv.setViewName("Client/client_search");

        return mv;
    }

    @RequestMapping("/searchByChartBoxAndTie")
    public ModelAndView searchByChartBoxAndTie(@RequestParam("tie") String tie,@RequestParam("key") String key,HttpServletRequest request) throws Exception {

        System.out.println("key = " + key);

        ModelAndView mv = new ModelAndView();

        List<Activity> activities = null;

        JsonArray jsonArray = null;

        Integer count = 1;

        HttpSession session = request.getSession();

        String num_tie = StringTieToNumberTe(tie);

        if("不限".equals(tie)) {

            System.out.println("1");

            activities = clientService.chartBoxSearchByKey(key);

            jsonArray = ToJsonArray.getJsonArray(activities, "activity");

            count = clientService.selectByChatBoxCount(key);

            session.setAttribute("ChartBoxCount",count);

            mv.addObject("jsonArray",jsonArray);

            mv.setViewName("Client/client_search");

            return mv;
        }

        activities = clientService.searchByChartBoxAndTie(key, num_tie);

        count = clientService.selectByChatBoxCountAndTie(key,num_tie);

        System.out.println("count =" + count);

        jsonArray = ToJsonArray.getJsonArray(activities, "activity");

        session.setAttribute("ChartBoxCount",count);

        mv.addObject("jsonArray",jsonArray);

        mv.setViewName("Client/client_search");

        return mv;
    }

    @RequestMapping("/queryGroupByChartBox")
    public ModelAndView queryGroupByChartBox(@RequestParam(value = "key",required = true) String key,@RequestParam(value = "tie",required = true) String tie,@RequestParam(value = "page",required = true) Integer page) throws Exception {

        ModelAndView mv = new ModelAndView();

        Integer limit = (page - 1) * 10;

        List<Activity> activities = null;

        JsonArray jsonArray = null;

        if("none".equals(tie) || "不限".equals(tie)) {

            activities = clientService.queryGroupNotTie(key, limit);

            jsonArray = ToJsonArray.getJsonArray(activities,"activity");

            mv.addObject("jsonArray",jsonArray);

        } else {

            String num_tie = StringTieToNumberTe(tie);

            activities = clientService.queryGroupHaveTie(key, limit, num_tie);

            jsonArray = ToJsonArray.getJsonArray(activities,"activity");

            mv.addObject("jsonArray",jsonArray);

        }

        mv.setViewName("Client/client_search");

        return mv;
    }

    @RequestMapping("/honor")
    public ModelAndView honor(@RequestParam(value = "username",required = true) String username,
                              @RequestParam(value = "rankNum",required = true) Integer rankNum) {

        ModelAndView mv = new ModelAndView();

        String rank = rankToBig(rankNum);

        mv.addObject("honorName",username);

        mv.addObject("rankNum",rank);

        mv.setViewName("Client/client_honor");

        return mv;
    }

    @RequestMapping("/certificate")
    public ModelAndView certificate(@RequestParam(value = "username",required = true) String username,
                                    @RequestParam(value = "activityName",required = true) String activityName,
                                    @RequestParam(value = "endTime",required = true) String endTime) {

        ModelAndView mv = new ModelAndView();

        String[] s = endTime.split(" ");

        String[] split = s[0].split("-");

        String finalStr = split[0] + "年" +split[1] + "月" + split[2] + "日";

        mv.addObject("endTime",finalStr);

        mv.addObject("activityName",activityName);

        mv.addObject("username",username);

        mv.setViewName("Client/client_certificate");

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
            case "经济管理系":
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

    private String rankToBig(Integer number) {

        if(number == 1) {
            return "一";
        }else if(number == 2) {
            return "二";
        }else if(number == 3) {
            return "三";
        }else if(number == 4) {
            return "四";
        }else if(number == 5) {
            return "五";
        }else if(number == 6) {
            return "六";
        }else if(number == 7) {
            return "七";
        }else if(number == 8) {
            return "八";
        }else if(number == 9) {
            return "九";
        }else if(number == 10) {
            return "十";
        } else {
            return "";
        }

    }
}

