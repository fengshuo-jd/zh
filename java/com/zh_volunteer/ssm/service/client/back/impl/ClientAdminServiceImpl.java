package com.zh_volunteer.ssm.service.client.back.impl;

import com.zh_volunteer.ssm.dao.client.ClientDao;

import com.zh_volunteer.ssm.dao.client.back.ClientAdminDao;
import com.zh_volunteer.ssm.pojo.Activity;
import com.zh_volunteer.ssm.pojo.User;
import com.zh_volunteer.ssm.service.client.back.ClientAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ClientAdminServiceImpl implements ClientAdminService {

    @Autowired
    private ClientAdminDao clientAdminDao;

    @Override
    public User examLoginActivityAdmin(String id) throws Exception {
        return new User();
    }

    @Override
    public List<Activity> selectActivityByUsername(String username) throws Exception {
        return clientAdminDao.selectActivityByUsername(username);
    }

    @Override
    public void updateActivity(Activity activity) throws Exception {
        clientAdminDao.updateActivity(activity);
    }

    @Override
    public void deleteActivity(Integer activity_id) throws Exception {
        clientAdminDao.deleteActivity(activity_id);
    }

    @Override
    public List<Activity> selectActivityByUsernameAndStateId(String stateId, String creator) {
        return clientAdminDao.selectActivityByUsernameAndStateId(stateId,creator);
    }

    @Override
    public List<Activity> selectActivityByUsernameAndThrough(String creator) throws Exception {
        return clientAdminDao.selectActivityByUsernameAndThrough(creator);
    }

    @Override
    public void updateUserPasswordByStu_id(String newPassword, String stu_id) throws Exception {
        clientAdminDao.updateUserPasswordByStu_id(newPassword,stu_id);
    }

    @Override
    public List<User> selectUserByActivityId(String activity_id) throws Exception {
        return clientAdminDao.selectUserByActivityId(activity_id);
    }

    @Override
    public String selctSignUpTime(String activity_id) {
        return null;
    }

    @Override
    public void updateUserState(String state, String stu_id,String activityId) throws Exception {
        clientAdminDao.updateUserState(state,stu_id,activityId);
    }

    @Override
    public String selectActivityName(String activity_id) throws Exception {
        return clientAdminDao.selectActivityName(activity_id);
    }

    @Override
    public void deleteUser(String stu_id) throws Exception {
        clientAdminDao.deleteUser(stu_id);
    }

    @Override
    public List<User> suchFind(String state_id, String activity_id) {
        return clientAdminDao.suchFind(state_id,activity_id);
    }

    @Override
    public List<Activity> selectActivityByUsernameAndTime(String username, StringBuffer time) {
        return clientAdminDao.selectActivityByUsernameAndTime(username,time.toString());
    }

    @Override
    public void addActivity(Activity activity) throws Exception {
        clientAdminDao.addActivity(activity);
    }

    @Override
    public User updateUserInfo(String username) throws Exception {
        return clientAdminDao.updateUserInfo(username);
    }

    @Override
    public void updateUserInfoHasMore(String username, String gender, String phone_num) throws Exception {
        clientAdminDao.updateUserInfoHasMore(username,gender,phone_num);
    }

    @Override
    public String selectPasswordByStuId(String stu_id) throws Exception {
        return clientAdminDao.selectPasswordByStuId(stu_id);
    }

    @Override
    public List<Activity> charBoxByActivtyNameAndUserName(String username, String activity_name) throws Exception {
        return clientAdminDao.charBoxByActivtyNameAndUserName(username,activity_name);
    }

    @Override
    public List<User> charBoxNum(String activity_id, String finalNum, String finalStr) throws Exception {
        return clientAdminDao.charBoxNum(activity_id,finalNum,finalStr);
    }

    @Override
    public String selectNameByStuId(String stuid) throws Exception {
        return clientAdminDao.selectNameByStuId(stuid);
    }
}
