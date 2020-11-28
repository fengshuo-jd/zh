package com.zh_volunteer.ssm.service.back;

import com.zh_volunteer.ssm.pojo.Activity;
import com.zh_volunteer.ssm.pojo.User;

import java.util.List;

public interface UserService {
    /**
     * 查询一个用户
     * @param id
     * @throws Exception
     */
    void queryOne(String id) throws Exception;
    /**
     * 用户登录
     * @param username 用户名或者手机号
     * @param password 密码
     * @return 成功返回true 失败返回false
     * @throws Exception
     */
    boolean login(String username, String password) throws Exception;

    List<User> findAll() throws Exception;

    void addOneUser(User user) throws Exception;

    void updateUserInfo(User user) throws Exception;

    void deleteUserInfo(String stu_id) throws Exception;

    void updateUserRoleInfo(Integer role_id, String stu_id) throws Exception;

    void addOneActivity(Activity activity) throws Exception;

    List<User> charBoxByUsernameOrStuId(String finalNum, String finalStr) throws Exception;

    Integer findAllCount() throws Exception;

    List<User> pageFindByPageNum(Integer page) throws Exception;

    Integer charBoxByUsernameOrStuIdCount(String finalNum, String finalStr) throws Exception;

    List<User> pageFindByPageNumAndSearchContent(String finalNum, String finalStr,Integer page) throws Exception;

    void reSetPaaWord(String stu_id) throws Exception;
}
