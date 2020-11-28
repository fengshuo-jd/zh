package com.zh_volunteer.ssm.service.back;

import com.zh_volunteer.ssm.pojo.Activity;

import java.util.List;

public interface ActivityService {
    List<Activity> findAll() throws Exception;

    void activityExamOne(String radio, String remarks, String id) throws Exception;

    void deleteActivityById(String id) throws Exception;

    List<Activity> suchFind(String id) throws Exception;

    List<Activity> charBoxByActivityName(String activity_name) throws Exception;

    Integer findAllCount() throws Exception;

    List<Activity> pageFindByPageNum(int n) throws Exception;

    List<Activity> pageFindByPageNumAndSearchContent(String finalStr, int n) throws Exception;

    Integer charBoxByActivityNameCount(String activity_name) throws Exception;

    List<Activity> pageFindByPageNumAndStateId(String stateId,Integer n) throws Exception;

    List<Activity> pageFindByPageNumAndSearchContentAndStateId(String str, String stateId, int n) throws Exception;;

    List<Activity> pageFindByPageNumAndSearchContentAndStateIdA(String str, String s) throws Exception;;

    Integer suchFindCount(String id) throws Exception;

    Integer pageFindByPageNumAndSearchContentAndStateIdACount(String str, String id) throws Exception;
}
