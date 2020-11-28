package com.zh_volunteer.ssm.dao.client.back;

import com.zh_volunteer.ssm.pojo.Activity;
import com.zh_volunteer.ssm.pojo.User;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.type.JdbcType;

import java.util.List;

public interface ClientAdminDao {
    /**
     * 查询通过用户名
     * @param username
     * @return
     */
    @Select("SELECT a.id,a.activity_remarks,a.activity_introduce,activity_details,a.activity_type,a.activity_total_number,a.activity_name,a.time,a.end_time,a.activity_score,a.activity_place,a.tie,a.creator,a.state FROM tb_user AS u INNER JOIN tb_activity AS a ON a.creator = u.username WHERE u.username = #{username}")
    @Results(id = "selectActivity",value = {
            @Result(column="activity_name", property="activity_name", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_introduce", property="activity_introduce", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_details", property="activity_details", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_type", property="activity_type", jdbcType= JdbcType.VARCHAR),
            @Result(column="time", property="time", jdbcType=JdbcType.DATE),
            @Result(column="activity_remarks", property="activity_remarks", jdbcType=JdbcType.VARCHAR),
            @Result(column="activity_total_number", property="activity_total_number", jdbcType=JdbcType.VARCHAR),
            //@Result(column="activity_state", property="activity_state", jdbcType=JdbcType.VARCHAR),
            @Result(column="activity_score", property="activity_score", jdbcType=JdbcType.INTEGER),
            @Result(column="activity_place", property="activity_place", jdbcType=JdbcType.VARCHAR),
            @Result(column="end_time", property="end_time", jdbcType=JdbcType.DATE)
    })
    List<Activity> selectActivityByUsername(String username);
    /**
     * 修改活动
     * @param activity
     */
    @Update("update tb_activity set activity_name=#{activity_name},activity_details=#{activity_details},activity_type=#{activity_type},tie=#{tie},activity_total_number=#{activity_total_number},activity_introduce=#{activity_introduce},activity_score=#{activity_score},activity_place=#{activity_place},time=#{time},end_time=#{end_time} where id=#{id}")
    void updateActivity(Activity activity);

    /**
     * 删除活动
     * @param activity_id
     */
    @Delete("delete from tb_activity where id = #{activity_id}")
    void deleteActivity(Integer activity_id);

    /**
     *
     * @param stateId
     * @param creator
     * @return
     */
    @Select("SELECT a.id,a.activity_remarks,a.activity_introduce,activity_details,a.activity_type,a.activity_total_number,a.activity_name,a.time,a.tie,a.creator,a.state FROM tb_user AS u INNER JOIN tb_activity AS a ON a.creator = u.username WHERE u.username = #{creator} and a.state=#{stateId}")
    @Results({
            @Result(column="activity_name", property="activity_name", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_introduce", property="activity_introduce", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_details", property="activity_details", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_type", property="activity_type", jdbcType= JdbcType.VARCHAR),
            @Result(column="time", property="time", jdbcType=JdbcType.DATE),
            @Result(column="activity_remarks", property="activity_remarks", jdbcType=JdbcType.VARCHAR),
            @Result(column="activity_total_number", property="activity_total_number", jdbcType=JdbcType.VARCHAR)
    })
    List<Activity> selectActivityByUsernameAndStateId(@Param("stateId")String stateId, @Param("creator")String creator);

    @Select("SELECT a.activity_current_number,a.id,a.activity_remarks,a.activity_introduce,activity_details,a.activity_type,a.activity_total_number,a.activity_name,a.time,a.tie,a.creator,a.state FROM tb_user AS u INNER JOIN tb_activity AS a ON a.creator = u.username WHERE u.username = #{creator} and a.state=2")
    @Results(id = "selectMidActivity",value = {
            @Result(column="activity_name", property="activity_name", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_introduce", property="activity_introduce", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_details", property="activity_details", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_type", property="activity_type", jdbcType= JdbcType.VARCHAR),
            @Result(column="time", property="time", jdbcType=JdbcType.DATE),
            @Result(column="activity_remarks", property="activity_remarks", jdbcType=JdbcType.VARCHAR),
            @Result(column="activity_current_number", property="activity_current_number", jdbcType=JdbcType.VARCHAR),
            @Result(column="activity_total_number", property="activity_total_number", jdbcType=JdbcType.VARCHAR)
    })
    List<Activity> selectActivityByUsernameAndThrough(String creator);

    /**
     * 通过活动id查询学生报名信息
     * @param activity_id
     * @return
     */
    @Select("SELECT u.limit_id,u.phone_num,s.signUp_time,u.username,u.gender,u.stu_id,u.state_id,s.signUp_time,u.tie,s.signUp_state FROM tb_signup s RIGHT JOIN tb_user u ON s.stu_id=u.stu_id WHERE s.activity_id=#{activity_id} and limit_id=1")
    @Results(id = "selectMidUser",value = {
            @Result(column = "state_id",property = "state_id",jdbcType = JdbcType.VARCHAR),
            @Result(column = "stu_id",property = "stu_id",jdbcType = JdbcType.VARCHAR),
            @Result(column = "phone_num",property = "phone_num",jdbcType = JdbcType.VARCHAR),
            @Result(column = "limit_id",property = "limit_id",jdbcType = JdbcType.VARCHAR),
            @Result(column="signUp_time", property="signUpTime", jdbcType=JdbcType.DATE),
            @Result(column="signUp_state", property="signUp_state", jdbcType=JdbcType.VARCHAR)
//            @Result(column = "signUp_time",property = "signUp_time",jdbcType = JdbcType.VARCHAR)
    })
    List<User> selectUserByActivityId(String activity_id);

    @Update("update tb_signup set signUp_state=#{state} where stu_id=#{stu_id} and activity_id=#{activityId}")
    void updateUserState(@Param("state") String state, @Param("stu_id")String stu_id,@Param("activityId") String activityId);

    @Select("select activity_name from tb_activity where id=#{activity_id}")
    String selectActivityName(String activity_id);

    @Delete("delete from tb_signup where stu_id = #{stu_id}")
    void deleteUser(String stu_id);

    @Select("SELECT u.limit_id,u.phone_num,s.signUp_time,u.username,u.gender,u.stu_id,u.state_id,s.signUp_time,u.tie FROM tb_signup s RIGHT JOIN tb_user u ON s.stu_id=u.stu_id WHERE s.activity_id=#{activity_id} and limit_id=1 and u.state_id=#{state_id}")
    @ResultMap(value="selectMidUser")
    List<User> suchFind(@Param("state_id")String state_id, @Param("activity_id")String activity_id);

    @Select("SELECT a.id,a.activity_remarks,a.activity_introduce,activity_details,a.activity_type,a.activity_total_number,a.activity_current_number,a.activity_name,a.time,a.tie,a.creator,a.state FROM tb_user AS u INNER JOIN tb_activity AS a ON a.creator = u.username WHERE u.username =#{username} AND DATE_FORMAT(a.time,'%Y-%m-%d') = #{time}")
    @ResultMap(value="selectMidActivity")
    List<Activity> selectActivityByUsernameAndTime(@Param("username")String username, @Param("time") String time);

    @Insert("insert into tb_activity(photo_path,state,time,creator,activity_name,activity_introduce,activity_details,activity_total_number,activity_type,tie,activity_current_number,activity_score,activity_place,end_time) values(#{photo_path},#{state},#{time},#{creator},#{activity_name},#{activity_introduce},#{activity_details},#{activity_total_number},#{activity_type},#{tie},#{activity_current_number},#{activity_score},#{activity_place},#{end_time})")
    void    addActivity(Activity activity);

    @Select("select id,stu_id,username,password,gender,phone_num from tb_user where username=#{username}")
    @Results({
            @Result(column="phone_num", property="phone_num", jdbcType= JdbcType.VARCHAR),
            @Result(column="username", property="username", jdbcType= JdbcType.VARCHAR),
            @Result(column="stu_id", property="stu_id", jdbcType= JdbcType.VARCHAR),
            @Result(column="password", property="password", jdbcType= JdbcType.VARCHAR),
            @Result(column="gender", property="gender", jdbcType=JdbcType.CHAR)
    })
    User updateUserInfo(String username) throws Exception;

    @Update("update tb_user set gender=#{gender},phone_num=#{phone_num} where id=#{id}")
    void updateUserInfoHasMore(@Param("id") String id, @Param("gender")String gender, @Param("phone_num")String phone_num);

    @Select("select password from tb_user where stu_id=#{stu_id}")
    String selectPasswordByStuId(String stu_id);

    @Update("update tb_user set password=#{newPassword} where stu_id=#{stu_id}")
    void updateUserPasswordByStu_id(@Param("newPassword") String newPassword, @Param("stu_id") String stu_id);

    @Select("SELECT a.id,a.activity_remarks,a.activity_introduce,activity_details,a.activity_type,a.activity_total_number,a.activity_name,a.time,a.end_time,a.activity_score,a.activity_place,a.tie,a.creator,a.state FROM tb_user AS u INNER JOIN tb_activity AS a ON a.creator = u.username WHERE u.username = #{username} AND a.activity_name  LIKE CONCAT('%',#{activity_name},'%')")
    @ResultMap(value="selectActivity")
    List<Activity> charBoxByActivtyNameAndUserName(@Param("username") String username, @Param("activity_name") String activity_name);

    @Select("SELECT u.limit_id,u.phone_num,s.signUp_time,u.username,u.gender,u.stu_id,u.state_id,s.signUp_time,u.tie FROM tb_signup s RIGHT JOIN tb_user u ON s.stu_id=u.stu_id WHERE s.activity_id=#{activity_id} AND limit_id=1 AND u.username LIKE CONCAT('%',#{finalStr},'%') OR u.stu_id LIKE CONCAT('%',#{finalNum},'%'); ")
    @ResultMap(value="selectMidUser")
    List<User> charBoxNum(@Param("activity_id") String activity_id, @Param("finalNum")String finalNum, @Param("finalStr")String finalStr);

    @Select("select username from tb_user where stu_id=#{stuid}")
    String selectNameByStuId(String stuid) throws Exception;
}
