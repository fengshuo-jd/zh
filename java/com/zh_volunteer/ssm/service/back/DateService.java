package com.zh_volunteer.ssm.service.back;

import com.zh_volunteer.ssm.pojo.Activity;
import com.zh_volunteer.ssm.pojo.User;

import java.util.List;

public interface DateService {

    Activity test() throws Exception;

    Integer selectAllActivityCount() throws Exception;

    Integer selectTieActivityCount(String s) throws Exception;

    List<User> selectBeforeTenStudents() throws Exception;
}
