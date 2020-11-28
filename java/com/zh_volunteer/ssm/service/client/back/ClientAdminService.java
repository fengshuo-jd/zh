package com.zh_volunteer.ssm.service.client.back;

import com.zh_volunteer.ssm.pojo.Activity;
import com.zh_volunteer.ssm.pojo.User;

import java.util.List;

public interface ClientAdminService {
    User examLoginActivityAdmin(String id) throws Exception;

    List<Activity> selectActivityByUsername(String username) throws Exception;

    void updateActivity(Activity activity) throws Exception;

    void deleteActivity(Integer activity_id) throws Exception;

    List<Activity> selectActivityByUsernameAndStateId(String stateId, String creator);

    List<Activity> selectActivityByUsernameAndThrough(String creator) throws Exception;

    List<User> selectUserByActivityId(String activity_id) throws Exception;

    String selctSignUpTime(String activity_id);

    void updateUserState(String state, String stu_id,String activityId) throws Exception;

    String selectActivityName(String activity_id) throws Exception;

    void deleteUser(String stu_id) throws Exception;

    List<User> suchFind(String state_id, String activity_id);

    List<Activity> selectActivityByUsernameAndTime(String username, StringBuffer time);

    void addActivity(Activity activity) throws Exception;

    User updateUserInfo(String username) throws Exception;

    void updateUserInfoHasMore(String username, String gender, String phone_num) throws Exception;

    String selectPasswordByStuId(String stu_id) throws Exception;

    void updateUserPasswordByStu_id(String newPassword, String stu_id) throws Exception;

    List<Activity> charBoxByActivtyNameAndUserName(String username, String activity_name) throws Exception;

    List<User> charBoxNum(String activity_id, String finalNum, String finalStr) throws Exception;

    String selectNameByStuId(String stuid) throws Exception;
}
