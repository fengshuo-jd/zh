package com.zh_volunteer.ssm.dao.back;

import com.zh_volunteer.ssm.pojo.Activity;
import com.zh_volunteer.ssm.pojo.User;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.type.JdbcType;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DateDao {

    @Select("select * from tb_activity where id=70")
    Activity test() throws Exception;

    @Select("SELECT COUNT(*) FROM tb_activity")
    Integer selectAllActivityCount() throws Exception;

    @Select("select count(*) from tb_activity where tie=#{tie}")
    Integer selectTieActivityCount(String tie) throws Exception;

    @Select("SELECT * FROM tb_user WHERE limit_id=1 ORDER BY credits DESC LIMIT 0,10")
    @Results(id = "selectUser",value = {
            @Result(column="username", property="username", jdbcType= JdbcType.VARCHAR),
            @Result(column="tie", property="tie", jdbcType= JdbcType.VARCHAR),
            @Result(column="stu_id", property="stu_id", jdbcType= JdbcType.VARCHAR),
            @Result(column="credits", property="credits", jdbcType=JdbcType.CHAR)
    })
    List<User> selectBeforeTenStudents();
}
