package com.zh_volunteer.ssm.controller.back;

import com.google.gson.JsonArray;
import com.zh_volunteer.ssm.pojo.Activity;
import com.zh_volunteer.ssm.pojo.User;
import com.zh_volunteer.ssm.service.back.DateService;
import com.zh_volunteer.ssm.util.ToJsonArray;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/date")
public class DateController {

    @Autowired
    private DateService dateService;

    @RequestMapping("/test")
    public ModelAndView test() throws Exception {

        ModelAndView mv = new ModelAndView();

        System.out.println(dateService);

        Activity activity = dateService.test();

        System.out.println(activity.toString());

        return mv;
    }

    /**
     *     1 计算机工程系
     *     2 自动化工程系
     *     3 机械工程系
     *     4 经济管理工程系
     *     5 电子信息工程系
     *     6 院级组织
     * @return
     * @throws Exception
     */
    @RequestMapping("/show")
    public ModelAndView show(HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        HttpSession session = request.getSession();
        //活动总数
        Integer count = dateService.selectAllActivityCount();

        session.setAttribute("actiivtyCount",count);
        //各系活动总数
        Integer computerActCount = dateService.selectTieActivityCount("1");
        session.setAttribute("computerActCount",computerActCount);

        Integer autoActCount = dateService.selectTieActivityCount("2");
        session.setAttribute("autoActCount",autoActCount);

        Integer mechanicalActCount = dateService.selectTieActivityCount("3");
        session.setAttribute("mechanicalActCount",mechanicalActCount);

        Integer economicActCount = dateService.selectTieActivityCount("4");
        session.setAttribute("economicActCount",economicActCount);

        Integer electronicActCount = dateService.selectTieActivityCount("5");
        session.setAttribute("electronicActCount",electronicActCount);

        Integer CollegeActCount = dateService.selectTieActivityCount("6");
        session.setAttribute("CollegeActCount",CollegeActCount);

        List<User> users = dateService.selectBeforeTenStudents();

        for(User user : users) {
            System.out.println(user);
        }

        JsonArray jsonArray = ToJsonArray.getJsonArray(users, "user");

        mv.addObject("jsonArray",jsonArray);

        mv.setViewName("BACK/background_admin_report");

        return mv;
    }

}
