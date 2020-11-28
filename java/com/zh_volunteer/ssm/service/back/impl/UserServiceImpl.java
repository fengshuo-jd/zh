package com.zh_volunteer.ssm.service.back.impl;

import com.zh_volunteer.ssm.dao.back.UserDao;
import com.zh_volunteer.ssm.pojo.Activity;
import com.zh_volunteer.ssm.pojo.User;
import com.zh_volunteer.ssm.service.back.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public void queryOne(String id) throws Exception {

        User user = userDao.queryOneUserByStuId(id);

        System.out.println(user);
    }

    @Override
    public boolean login(String username, String password) throws Exception {

        User user = userDao.login(username, password);

        if(user == null) {

            System.out.println("there is false");
            return false;
        }else {

            System.out.println("there is true");
            return true;
        }
    }

    @Override
    public List<User> findAll() throws Exception {

        List<User> users = userDao.findAll();

        for(User user : users) {

            System.out.println(user.toString());
        }

        return users;
    }

    @Override
    public void addOneActivity(Activity activity) throws Exception {
        userDao.addOneActivity(activity);
    }

    @Override
    public void addOneUser(User user) throws Exception { userDao.addOneUser(user); }

    @Override
    public void updateUserInfo(User user) throws Exception { userDao.updateUserInfo(user); }

    @Override
    public void deleteUserInfo(String stu_id) throws Exception { userDao.deleteUserInfo(stu_id); }

    @Override
    public void updateUserRoleInfo(Integer role_id, String stu_id) throws Exception { userDao.updateUserRoleInfo(role_id,stu_id); }

    @Override
    public List<User> charBoxByUsernameOrStuId(String finalNum, String finalStr) throws Exception {
        return userDao.charBoxByUsernameOrStuId(finalNum,finalStr);
    }

    @Override
    public Integer findAllCount() throws Exception {
        return userDao.findAllCount();
    }

    @Override
    public List<User> pageFindByPageNum(Integer page) throws Exception {
        return userDao.pageFindByPageNum(page);
    }

    @Override
    public Integer charBoxByUsernameOrStuIdCount(String finalNum, String finalStr) throws Exception {
        return userDao.charBoxByUsernameOrStuIdCount(finalNum,finalStr);
    }

    @Override
    public List<User> pageFindByPageNumAndSearchContent(String finalNum, String finalStr, Integer page) throws Exception {
        return userDao.pageFindByPageNumAndSearchContent(finalNum,finalStr,page);
    }

    @Override
    public void reSetPaaWord(String stu_id) throws Exception {
        userDao.reSetPaaWord(stu_id);
    }
}
