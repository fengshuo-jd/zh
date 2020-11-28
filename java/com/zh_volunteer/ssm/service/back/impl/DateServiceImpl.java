package com.zh_volunteer.ssm.service.back.impl;

import com.zh_volunteer.ssm.dao.back.DateDao;
import com.zh_volunteer.ssm.pojo.Activity;
import com.zh_volunteer.ssm.pojo.User;
import com.zh_volunteer.ssm.service.back.DateService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class DateServiceImpl implements DateService {

    @Autowired
    private DateDao dateDao;

    @Override
    public Activity test() throws Exception {
        return dateDao.test();
    }

    @Override
    public Integer selectAllActivityCount() throws Exception {
        return dateDao.selectAllActivityCount();
    }

    @Override
    public Integer selectTieActivityCount(String tie) throws Exception {
        return dateDao.selectTieActivityCount(tie);
    }

    @Override
    public List<User> selectBeforeTenStudents() throws Exception {
        return dateDao.selectBeforeTenStudents();
    }
}
