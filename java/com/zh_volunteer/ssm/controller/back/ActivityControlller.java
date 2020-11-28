package com.zh_volunteer.ssm.controller.back;

import com.google.gson.JsonArray;
import com.zh_volunteer.ssm.pojo.Activity;
import com.zh_volunteer.ssm.service.back.ActivityService;
import com.zh_volunteer.ssm.util.ToJsonArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/activity")
public class ActivityControlller {

    @Autowired
    private ActivityService activityService;

    public List<Activity> findAll111() throws Exception {

        List<Activity> activities = activityService.findAll();

        return  activities;
    }

    /**
     * 查询所有活动
     * @return
     * @throws Exception
     */
    @RequestMapping("/findAll")
    public ModelAndView findAll(HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        HttpSession session = request.getSession();

        List<Activity> activities = activityService.findAll();

        Integer activityCount = activityService.findAllCount();

        session.setAttribute("activityCount",activityCount);

        session.setAttribute("pageNum2",1);

        session.removeAttribute("searchActContent");

        session.removeAttribute("activityStateId");

        JsonArray activity = ToJsonArray.getJsonArray(activities, "activity");

        mv.addObject("jsonArray",activity);

        mv.setViewName("BACK/background_activity_list");

        return mv;
    }

    /**
     * 0 未审核 1 审核未通过 2已审核
     * @param id
     * @param radio
     * @param remarks
     * @return
     */
    @RequestMapping(value = "/activityExam" ,method = RequestMethod.POST)
    public ModelAndView ActivityExam(@RequestParam(name = "id") String id,
                                     @RequestParam(name = "radio") String radio,
                                     @RequestParam(name = "remarks") String remarks,
                                     HttpServletRequest request) throws Exception {

        activityService.activityExamOne(radio,remarks,id);

        ModelAndView mv = findAll(request);

        return mv;
    }
    /**
     *删除一个活动
     * @param id
     * @return
     * @throws Exception
     */
    @RequestMapping("/deleteActivity")
    public ModelAndView deleteActivity(@RequestParam(name = "id") String id,
                                       HttpServletRequest request) throws Exception {

        activityService.deleteActivityById(id);

        ModelAndView mv = findAll(request);

        return mv;
    }
    /**
     * 3 全部 0 未审核 1审核未通过 2 已审核
     *通过列表选项查询
     * @param id
     * @return
     */
    @RequestMapping("/suchFind")
    public ModelAndView suchFindList(@RequestParam(name = "id",required = true) String id,
                                     HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        HttpSession session = request.getSession();

        session.setAttribute("activityStateId",id);

        session.setAttribute("pageNum2",1);

        String str= (String) session.getAttribute("searchActContent");

        List<Activity> activities = null;

        if("3".equals(id)){

            if(str != null) {
                activities = activityService.charBoxByActivityName(str);

                JsonArray activitys = ToJsonArray.getJsonArray(activities, "activity");

                mv.addObject("jsonArray",activitys);

                mv.setViewName("BACK/background_activity_list");

                Integer count = activityService.charBoxByActivityNameCount(str);

                session.setAttribute("activityCount",count);

                return mv;
            }

          activities = findAll111();

          Integer activityCount = activityService.findAllCount();

          session.setAttribute("activityCount",activityCount);


        } else {

            if(str != null) {
                activities = activityService.pageFindByPageNumAndSearchContentAndStateIdA(str,id);

                Integer count = activityService.pageFindByPageNumAndSearchContentAndStateIdACount(str,id);

                session.setAttribute("activityCount",count);

                JsonArray activitys = ToJsonArray.getJsonArray(activities, "activity");

                mv.addObject("jsonArray",activitys);

                mv.setViewName("BACK/background_activity_list");

                return mv;
            }
            Integer count = activityService.suchFindCount(id);

            session.setAttribute("activityCount",count);

            activities = activityService.suchFind(id);
        }

        JsonArray activitys = ToJsonArray.getJsonArray(activities, "activity");

        mv.addObject("jsonArray",activitys);

        mv.setViewName("BACK/background_activity_list");

        return mv;
    }

    @RequestMapping("/charBoxByActivityName")
    public ModelAndView charBoxByActivityName(@RequestParam(name = "query") String activity_name,
                                              HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        HttpSession session = request.getSession();

//        if(session.getAttribute("activityStateId") == null || session.getAttribute("activityStateId") == "3") {
//
//        }

        session.setAttribute("searchActContent",activity_name);

        session.setAttribute("pageNum2",1);

        session.removeAttribute("activityStateId");

        List<Activity> activities = activityService.charBoxByActivityName(activity_name);

        Integer count = activityService.charBoxByActivityNameCount(activity_name);

        session.setAttribute("activityCount",count);

        JsonArray activity = ToJsonArray.getJsonArray(activities, "activity");

        mv.addObject("jsonArray",activity);

        mv.setViewName("BACK/background_activity_list");

        return mv;
    }

    @RequestMapping("/page")
    public ModelAndView page(@RequestParam("page") Integer page_num,HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        HttpSession session = request.getSession();

        session.setAttribute("pageNum2",page_num);

        List<Activity> activities = null;

        int n = (page_num - 1) * 10;

        String str= (String) session.getAttribute("searchActContent");

        if(session.getAttribute("searchActContent") == null && session.getAttribute("activityStateId") == null) {

            activities = activityService.pageFindByPageNum(n);
        } else {

            if("3".equals(session.getAttribute("activityStateId")) && session.getAttribute("searchActContent") == null) {

                activities = activityService.pageFindByPageNum(n);

                JsonArray activity = ToJsonArray.getJsonArray(activities, "activity");

                mv.addObject("jsonArray",activity);

                mv.setViewName("BACK/background_activity_list");

                return mv;
            }

            if (session.getAttribute("searchActContent") != null && session.getAttribute("activityStateId") == null) {

                activities = activityService.pageFindByPageNumAndSearchContent(str,n);
            } else if(session.getAttribute("searchActContent") == null && session.getAttribute("activityStateId") != null) {

                String stateId = (String) session.getAttribute("activityStateId");

                activities = activityService.pageFindByPageNumAndStateId(stateId,n);
            } else if(session.getAttribute("searchActContent") != null && session.getAttribute("activityStateId") != null) {

                String stateId = (String) session.getAttribute("activityStateId");

                if("3".equals(session.getAttribute("activityStateId"))) {

                    activities = activityService.pageFindByPageNumAndSearchContent(str,n);

                    JsonArray activity = ToJsonArray.getJsonArray(activities, "activity");

                    mv.addObject("jsonArray",activity);

                    mv.setViewName("BACK/background_activity_list");

                    return mv;
                }

                activities = activityService.pageFindByPageNumAndSearchContentAndStateId(str,stateId,n);
            }
        }

        JsonArray activity = ToJsonArray.getJsonArray(activities, "activity");

        mv.addObject("jsonArray",activity);

        mv.setViewName("BACK/background_activity_list");

        return mv;
    }
}
