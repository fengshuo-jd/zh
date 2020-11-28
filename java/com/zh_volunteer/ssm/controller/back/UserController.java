package com.zh_volunteer.ssm.controller.back;

import com.google.gson.JsonArray;
import com.zh_volunteer.ssm.pojo.Activity;
import com.zh_volunteer.ssm.pojo.User;
import com.zh_volunteer.ssm.service.back.UserService;
import com.zh_volunteer.ssm.util.ExcelToList;
import com.zh_volunteer.ssm.util.ReturnFinalNumAndFinalStr;
import com.zh_volunteer.ssm.util.ToJsonArray;
import jxl.read.biff.BiffException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/findOne", method = RequestMethod.GET)
    public ModelAndView findOneByStuId() throws Exception {

        ModelAndView mv = new ModelAndView();

        String id = "18060001";

        userService.queryOne(id);

        mv.setViewName("user");

        return mv;
    }
    /**
     * 超级管理员登录
     * @param username
     * @param password
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public ModelAndView supLogin(@RequestParam(name = "username",required = true) String username, @RequestParam(name = "password",required = true) String password, HttpServletRequest httpServletRequest) throws Exception {
        //可以获取到username password
        ModelAndView mv = new ModelAndView();

        ModelMap modelMap = new ModelMap();
        //通过返回值判断是否登录成功 true:成功 false:失败
        boolean flag = userService.login(username, password);

        HttpSession session = httpServletRequest.getSession();

        if(flag == true) {

            session.setAttribute("password",password);
//            modelMap.addAttribute("password",password);

            mv.setViewName("BACK/background_first_page");
        }else {
            mv.addObject("msg","用户名错误或密码错误");

            mv.setViewName("BACK/background_login");
        }
        return mv;
    }
    /**
     * 查询所有用户
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/findall")
    public ModelAndView FindAll(HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        HttpSession session = request.getSession();
        //获取所有用户数据
        List<User> users = userService.findAll();

        Integer count = userService.findAllCount();
        //将count放入session
        session.setAttribute("userCount",count);

        session.setAttribute("pageNum1",1);

        session.removeAttribute("searchContent");
        //通过工具类将list转换成jsonarray
        JsonArray usersJson = ToJsonArray.getJsonArray(users, "user");

        mv.addObject("jsonArray",usersJson);

        mv.setViewName("BACK/background_user_list");

        return mv;
    }
    /**
     * 添加一个用户学生或者社团
     * @param username
     * @param stu_id
     * @param gender
     * @param limit_id
     * @param phone_num
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addOneUser",method = RequestMethod.POST)
    public String addUser(@RequestParam(name = "username",required = true) String username,
                                @RequestParam(name = "stu_id",required = true) String stu_id,
                                @RequestParam(name = "gender",required = true) String gender,
                                @RequestParam(name = "limit_id",required = true) String limit_id,
                                @RequestParam(name = "phone_num",required = true) String phone_num,
                          HttpServletRequest request) throws Exception {
        //参数可以全部获取 将String类型转化为Integer
        Integer Role_id;

        if("学生".equals(limit_id)){
            Role_id = 1;
        }else if("活动管理员".equals(limit_id)){
            Role_id = 2;
        }else{
            Role_id = 1;
        }

        User user = new User(null,username,"000000",gender,phone_num,Role_id,stu_id,"1",1,null,null,"1");

        userService.addOneUser(user);

        ModelAndView mv = FindAll(request);

        return "redirect:returnToNow";
    }

    @RequestMapping("/returnToNow")
    public ModelAndView returnToNow () throws Exception {

        ModelAndView mv = new ModelAndView();

        List<User> users = userService.findAll();
        //通过工具类将list转换成jsonarray
        JsonArray usersJson = ToJsonArray.getJsonArray(users, "user");

        mv.addObject("jsonArray",usersJson);

        mv.setViewName("BACK/background_user_list");

        return mv;
    }
    /**
     * 通过id 修改学生或者社团信息
     * @param id
     * @param username
     * @param stu_id
     * @param gender
     * @param phone_num
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateUserInfo",method = RequestMethod.POST)
    public ModelAndView update(@RequestParam(name = "id",required = true)Integer id,
                               @RequestParam(name = "username",required = true)String username,
                               @RequestParam(name = "stu_id",required = true)String stu_id,
                               @RequestParam(name = "gender",required = true)String gender,
                               @RequestParam(name = "phone_num",required = true)String phone_num,HttpServletRequest request) throws Exception {

        System.out.println(id+username+stu_id+gender+phone_num);

        User user = new User(id,username,"",gender,phone_num,1,stu_id,"",1,null,null,"1");

        userService.updateUserInfo(user);

        ModelAndView mv = FindAll(request);

        return mv;
    }
    /**
     * 删除用户信息
     * @param stu_id
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deleteUser")
    public ModelAndView deleteUser(@RequestParam(name = "stu_id") String stu_id,HttpServletRequest request) throws Exception {

        userService.deleteUserInfo(stu_id);

        ModelAndView mv = FindAll(request);

        return mv;
    }
    /**
     * 修改用户角色信息
     * @param limit_id
     * @param stu_id
     * @return
     * @throws Exception
     */
    @RequestMapping("/updateUserRoleInfo")
    public ModelAndView updateUserRoleInfo(@RequestParam(name = "limit_id") String limit_id,@RequestParam(name = "stu_id") String stu_id,HttpServletRequest request) throws Exception {

        Integer Role_id;

        if("31".equals(limit_id)){
            Role_id = 1;
        }else if("30".equals(limit_id)){
            Role_id = 2;
        }else {
            Role_id = 1;
        }

        userService.updateUserRoleInfo(Role_id,stu_id);

        ModelAndView mv = FindAll(request);

        return mv;
    }
    /**
     * 退出功能
     * @param req
     * @param resp
     */
    @RequestMapping("/logout")
    public ModelAndView logOut(HttpServletRequest req, HttpServletResponse resp){
        //清空所有session
        Enumeration em = req.getSession().getAttributeNames();

        ModelAndView mv = new ModelAndView();

        HttpSession session = req.getSession();

        System.out.println(session.getAttribute("password")+ "=========================");

        session.setAttribute("password",null);

        System.out.println(session.getAttribute("password") + "指控后");

        mv.setViewName("BACK/background_login");

        return mv;
    }

    /**
     * 导入excel表格
     * @return
     * @throws Exception
     */
    @RequestMapping("/gogogo")
    public ModelAndView insertUsers() throws Exception {

        ModelAndView mv = new ModelAndView();

        List<Activity> activities = ExcelToList.getListByExcel("F:\\Desktop\\tb_activity.xls");

        for(int i = 0;i < activities.size();i++) {

            userService.addOneActivity(activities.get(i));
        }

        mv.setViewName("BACK/background_activity_list");

        return mv;
    }

    @RequestMapping("/charBoxByUsernameOrStuId")
    public ModelAndView charBoxByUsernameOrStuId(@RequestParam(name = "query") String midStr,HttpServletRequest request) throws Exception{

        ModelAndView mv = new ModelAndView();

        HttpSession session = request.getSession();

        String[] strings = ReturnFinalNumAndFinalStr.finalNumAndFinalStr(midStr);

        session.setAttribute("pageNum1",1);

        String finalNum = strings[0];

        finalNum = isEmpty(finalNum);

        String finalStr = strings[1];

        finalStr = isEmpty(finalStr);

        Integer count = userService.charBoxByUsernameOrStuIdCount(finalNum, finalStr);

        session.setAttribute("userCount",count);

        session.setAttribute("searchContent",midStr);

        List<User> users = userService.charBoxByUsernameOrStuId(finalNum,finalStr);

        JsonArray usersJson = ToJsonArray.getJsonArray(users, "user");

        mv.addObject("jsonArray",usersJson);

        mv.setViewName("BACK/background_user_list");

        return mv;

    }

    @RequestMapping("/page")
    public ModelAndView page(@RequestParam(value = "page",required = true) Integer page,HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        HttpSession session = request.getSession();

        session.setAttribute("pageNum1", page);

        List<User> users = null;

        System.out.println();

        int n = (page - 1) * 10;

        System.out.println(n);

        if (session.getAttribute("searchContent") == null ) {

            users = userService.pageFindByPageNum(n);

        } else {

            String  str = (String) session.getAttribute("searchContent");

            String[] strings = ReturnFinalNumAndFinalStr.finalNumAndFinalStr(str);

            String finalNum = strings[0];

            finalNum = isEmpty(finalNum);

            String finalStr = strings[1];

            finalStr = isEmpty(finalStr);

            System.out.println(finalNum + "=" + finalStr + "=" + n);

            users = userService.pageFindByPageNumAndSearchContent(finalNum,finalStr,n);

        }

        JsonArray usersJson = ToJsonArray.getJsonArray(users, "user");

        mv.addObject("jsonArray", usersJson);

        mv.setViewName("BACK/background_user_list");

        return mv;
    }

    @RequestMapping("/reset")
    public ModelAndView reset(@RequestParam(name = "stu_id") String stu_id,HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        userService.reSetPaaWord(stu_id);

        return FindAll(request);
    }

    public String isEmpty(String str) {

        if("".equals(str)) {
            return " ";
        }
        return str;
    }
}
