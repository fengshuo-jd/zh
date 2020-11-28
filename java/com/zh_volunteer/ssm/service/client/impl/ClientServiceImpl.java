package com.zh_volunteer.ssm.service.client.impl;

import com.github.pagehelper.PageHelper;
import com.zh_volunteer.ssm.dao.client.ClientDao;
import com.zh_volunteer.ssm.pojo.Activity;
import com.zh_volunteer.ssm.pojo.User;
import com.zh_volunteer.ssm.service.client.ClientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ClientServiceImpl implements ClientService {

    @Autowired
    private ClientDao clientDao;

    @Override
    public User login(String username, String password) throws Exception {

        User user = clientDao.login(username, password);

       return user;
    }

    @Override
    public List<Activity> findSuchActivityByActivityType(String activityType) throws Exception {

        List<Activity> activities = clientDao.findSuchActivityByActivityType(activityType);

        return activities;
    }

    @Override
    public List<Activity> randomFind(String activity_type, String tie_id) throws Exception {

        List<Activity> activities = clientDao.randomFind(activity_type, tie_id);

        for(Activity activity : activities){
            System.out.println(activity.toString());
        }

        return activities;
    }

    @Override
    public List<Activity> findAll(int page, int size) throws Exception {
        //必须写在执行操作之前
        PageHelper.startPage(page,size);

        return clientDao.findAllActivity();
    }

    @Override
    public List<Activity> findPageTest(Integer page, Integer size, String activity_type, String tie_id) {

        PageHelper.startPage(page,size);

        return clientDao.randomFind(activity_type, tie_id);
    }

    @Override
    public Activity findOneActivityByActivity_id(String activity_id) throws Exception {
        return clientDao.findOneActivityByActivity_id(activity_id);
    }

    @Override
    public List<Activity> findAllActivity() throws Exception {
        return clientDao.findAllActivity();
    }

    @Override
    public List<Activity> getFixLimitActivities(Integer firstLimit, Integer afterLimit, String activityType, String tie) throws Exception {
        return clientDao.findAllActivityLimit(firstLimit,afterLimit,activityType,tie);
    }

    @Override
    public List<Activity> getFixLimitActivitiesNotTie(Integer firstLimit, String activityType) throws Exception {
        return clientDao.getFixLimitActivitiesNotTie(firstLimit,activityType);
    }

    @Override
    public List<Activity> getFixLimitTieNotActivities(Integer firstLimit, String tie) throws Exception {
        return clientDao.getFixLimitTieNotActivities(firstLimit, tie);
    }

    @Override
    public List<Activity> findSuchActivityByTie(String tie) throws Exception {
        return clientDao.findSuchActivityByTie(tie);
    }

    @Override
    public Integer findCountByTie(String tie) throws Exception {
        return clientDao.findCountByTie(tie);
    }

    @Override
    public Integer findCountByType(String ActType) throws Exception {
        return clientDao.findCountByType(ActType);
    }

    @Override
    public Integer findCounts() throws Exception {
        return clientDao.findCounts();
    }

    @Override
    public Integer findCountByTieAndType(String tieStr, String typeStr) throws Exception {
        return clientDao.findCountByTieAndType(tieStr,typeStr);
    }

    @Override
    public User findUserById(String stuId) throws Exception {
        return clientDao.findUserById(stuId);
    }

    @Override
    public Boolean signUpActivity(String activity_id, String stu_id,String time) throws Exception {

        clientDao.currentNumberPlus(activity_id);

        return clientDao.signUpActivity(activity_id,stu_id,time);
    }

    @Override
    public String isCanSignUp(String activity_id) throws Exception {
        return clientDao.isCanSignUp(activity_id);
    }

    @Override
    public String hasSignUp(String activity_id, String stu_id) throws Exception {
        return clientDao.hasSignUp(activity_id,stu_id);
    }

    @Override
    public List<Activity> selectActivityBySignUp(String stu_id) throws Exception {
        return clientDao.selectActivityBySignUp(stu_id);
    }

    @Override
    public Boolean updateStuInfo(String stu_id, String phone_num, String gender) {
        return clientDao.updateStuInfo(stu_id,phone_num,gender);
    }

    @Override
    public void updateStuPaw(String stu_id, String newPassword) {
        clientDao.updateStuPaw(stu_id,newPassword);
    }

    @Override
    public List<Activity> chartBoxSearchByKey(String key) throws Exception {
        return clientDao.chartBoxSearchByKey(key);
    }

    @Override
    public List<Activity> searchByChartBoxAndTie(String key, String tie) throws Exception {
        return clientDao.searchByChartBoxAndTie(key,tie);
    }

    @Override
    public Integer selectByChatBoxCount(String key) throws Exception {
        return clientDao.selectByChatBoxCount(key);
    }

    @Override
    public Integer selectByChatBoxCountAndTie(String key,String tie)  {
        return clientDao.selectByChatBoxCountAndTie(key,tie);
    }

    @Override
    public List<Activity> queryGroupNotTie(String key, Integer limit) throws Exception {
        return clientDao.queryGroupNotTie(key,limit);
    }

    @Override
    public List<Activity> queryGroupHaveTie(String key, Integer limit, String tie) throws Exception {
        return clientDao.queryGroupHaveTie(key,limit,tie);
    }

    @Override
    public List<User> selectTopTenStudent() throws Exception {
        return clientDao.selectTopTenStudent();
    }
}

