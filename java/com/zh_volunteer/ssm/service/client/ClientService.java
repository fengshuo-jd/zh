package com.zh_volunteer.ssm.service.client;

import com.sun.org.apache.xpath.internal.operations.Bool;
import com.zh_volunteer.ssm.pojo.Activity;
import com.zh_volunteer.ssm.pojo.User;

import java.util.List;

public interface ClientService {

    User login(String username, String password) throws Exception;

    List<Activity> findSuchActivityByActivityType(String activityType) throws Exception;

    List<Activity> randomFind(String activity_type, String tie_id) throws Exception;

    List<Activity> findAll(int page,int size) throws Exception;

    List<Activity> findPageTest(Integer page, Integer size, String activity_type, String tie_id) throws Exception;

    Activity findOneActivityByActivity_id(String activity_id) throws Exception;

    List<Activity> findAllActivity() throws Exception;

    List<Activity> getFixLimitActivities(Integer firstLimit, Integer afterLimit, String activityType, String tie) throws Exception;

    List<Activity> getFixLimitActivitiesNotTie(Integer firstLimit, String activityType) throws Exception;

    List<Activity> getFixLimitTieNotActivities(Integer firstLimit, String tie) throws Exception;

    List<Activity> findSuchActivityByTie(String tie) throws Exception;

    Integer findCountByTie(String tie) throws Exception;

    Integer findCountByType(String ActType) throws Exception;

    Integer findCounts() throws Exception;

    Integer findCountByTieAndType(String tieStr, String typeStr) throws Exception;

    User findUserById(String stuId) throws Exception;

    Boolean signUpActivity(String activity_id, String stu_id,String time) throws Exception;

    String isCanSignUp(String activity_id) throws Exception;

    String hasSignUp(String activity_id, String stu_id) throws Exception;

    List<Activity> selectActivityBySignUp(String stu_id) throws Exception;

    Boolean updateStuInfo(String stu_id, String phone_num, String gender);

    void updateStuPaw(String stu_id, String newPassword);

    List<Activity> chartBoxSearchByKey(String key)throws Exception;

    List<Activity> searchByChartBoxAndTie(String key, String tie) throws Exception;

    Integer selectByChatBoxCount(String key) throws Exception;


    Integer selectByChatBoxCountAndTie(String key, String num_tie);

    List<Activity> queryGroupNotTie(String key, Integer limit) throws Exception;

    List<Activity> queryGroupHaveTie(String key, Integer limit, String tie) throws Exception;

    List<User> selectTopTenStudent() throws Exception;
}
