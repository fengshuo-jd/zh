package com.zh_volunteer.ssm.service.back.impl;

import com.zh_volunteer.ssm.dao.back.ActivityDao;
import com.zh_volunteer.ssm.pojo.Activity;
import com.zh_volunteer.ssm.service.back.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ActivityServiceImpl implements ActivityService {

    @Autowired
    private ActivityDao activityDao;

    @Override
    public List<Activity> findAll() throws Exception {
        return  activityDao.findAll();
    }

    @Override
    public void activityExamOne(String radio, String remarks, String id) throws Exception {
        activityDao.activityExamOne(radio,remarks,id);
    }

    @Override
    public void deleteActivityById(String id) throws Exception {
        activityDao.deleteActivity(id);
    }

    @Override
    public List<Activity> suchFind(String id) throws Exception {
        return activityDao.suchFind(id);
    }

    @Override
    public List<Activity> charBoxByActivityName(String activity_name) throws Exception {
        return activityDao.charBoxByActivityName(activity_name);
    }

    @Override
    public Integer findAllCount() throws Exception {
        return activityDao.findAllCount();
    }

    @Override
    public List<Activity> pageFindByPageNum(int n) throws Exception {
        return activityDao.pageFindByPageNum(n);
    }

    @Override
    public List<Activity> pageFindByPageNumAndSearchContent(String finalStr, int n) throws Exception {
        return activityDao.pageFindByPageNumAndSearchContent(finalStr,n);
    }

    @Override
    public Integer charBoxByActivityNameCount(String activity_name) throws Exception {
        return activityDao.charBoxByActivityNameCount(activity_name);
    }

    @Override
    public List<Activity> pageFindByPageNumAndStateId(String stateId,Integer page) throws Exception {
        return activityDao.pageFindByPageNumAndStateId(stateId,page);
    }

    @Override
    public List<Activity> pageFindByPageNumAndSearchContentAndStateId(String str, String stateId, int n) {
        return activityDao.pageFindByPageNumAndSearchContentAndStateId(str,stateId,n);
    }

    @Override
    public List<Activity> pageFindByPageNumAndSearchContentAndStateIdA(String str, String s) {
        return activityDao.pageFindByPageNumAndSearchContentAndStateIdA(str,s);
    }

    @Override
    public Integer suchFindCount(String id) throws Exception {
        return activityDao.suchFindCount(id);
    }

    @Override
    public Integer pageFindByPageNumAndSearchContentAndStateIdACount(String str, String id) throws Exception {
        return activityDao.pageFindByPageNumAndSearchContentAndStateIdACount(str,id);
    }
}
